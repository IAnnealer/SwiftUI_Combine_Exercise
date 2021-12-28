//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/19.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    // MARK: - Properites

    @Published var statistics: [Statistic] = []
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false

    private let coinDataService: CoinDataService
    private let marketDataService: MarketDataService
    private let portfolioDataService: PortfolioDataService

    private var cancellable = Set<AnyCancellable>()

    // MARK: - Initializer

    init(coinDataService: CoinDataService,
         marketDataService: MarketDataService,
         portfolioDataService: PortfolioDataService) {
        self.coinDataService = coinDataService
        self.marketDataService = marketDataService
        self.portfolioDataService = portfolioDataService

        addSubscribers()
    }

    // MARK: - Methods

    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }

    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
}

// MARK: - Private Extension
private extension HomeViewModel {

    // Update Flow: 전체 -> 입력 코인 & 포트폴리오 -> 마켓

    func addSubscribers() {
        // 전체 코인 업데이트
        coinDataService.$allCoins
            .sink(receiveValue: { [weak self] in
                self?.allCoins = $0
            })
            .store(in: &cancellable)

        // 입력값에 따른 코인 업데이트
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink(receiveValue: { [weak self] coins in
                self?.allCoins = coins
            })
            .store(in: &cancellable)

        // 포트폴리오 업데이트
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink(receiveValue: { [weak self] in
                self?.portfolioCoins = $0
            })
            .store(in: &cancellable)

        // 마켓 데이터 업데이트
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink(receiveValue: { [weak self] in
                self?.statistics = $0
                self?.isLoading = false
            })
            .store(in: &cancellable)
    }

    func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }

        let lowercasedText = searchText.lowercased()

        return coins
            .filter { $0.name.lowercased().contains(lowercasedText) ||
                $0.symbol.lowercased().contains(lowercasedText) ||
                $0.id.lowercased().contains(lowercasedText)
            }
    }

    func mapGlobalMarketData(_ marketData: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data = marketData else {
            return stats
        }

        let marketCap = Statistic(title: "Market Cap",
                                  value: data.marketCap,
                                  percentageChange: data.marketCapChangePercentage24HUsd)

        let volume = Statistic(title: "24H Volume",
                               value: data.volume)

        let btcDominance = Statistic(title: "BTC Dominance",
                                     value: data.btcDominance)

        let portfolioValue =
        portfolioCoins
            .map { return $0.currentHoldings ?? 0.0 }
            .reduce(0, +)

        let previousValue =
        portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0.0 / 100
                return (currentValue / (1 + percentChange))
            }
            .reduce(0, +)

        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100

        let portfolio = Statistic(title: "Portfolio Value",
                                  value: portfolioValue.asCurrencyWith2Decimals(),
                                  percentageChange: percentageChange)

        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])

        return stats
    }

    func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioCoins: [PortfolioEntity]) -> [Coin] {
        allCoins
            .compactMap { coin -> Coin? in
                guard let entity = portfolioCoins.first(where: { ($0.coinID ?? "") == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
}
