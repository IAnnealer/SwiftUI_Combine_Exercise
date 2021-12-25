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

    private let coinDataService: CoinDataService
    private let marketDataService: MarketDataService
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Initializer

    init(coinDataService: CoinDataService, marketDataService: MarketDataService) {
        self.coinDataService = coinDataService
        self.marketDataService = marketDataService
        addSubscribers()
    }
}

private extension HomeViewModel {
    func addSubscribers() {
        coinDataService.$allCoins
            .sink(receiveValue: { [weak self] in
                self?.allCoins = $0
            })
            .store(in: &cancellable)

        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink(receiveValue: { [weak self] coins in
                self?.allCoins = coins
            })
            .store(in: &cancellable)

        marketDataService.$marketData
            .map(mapGlobalMarketData )
            .sink(receiveValue: { [weak self] in
                self?.statistics = $0
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

    func mapGlobalMarketData(_ marketData: MarketData?) -> [Statistic] {
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

        let portfolio = Statistic(title: "Portfolio Value",
                                  value: "$0.00",
                                  percentageChange: 0)

        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])

        return stats
    }
}
