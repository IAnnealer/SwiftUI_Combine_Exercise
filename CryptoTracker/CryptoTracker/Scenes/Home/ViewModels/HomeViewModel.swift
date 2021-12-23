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

    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Initializer

    init() {
        addSubscribers()
    }
}

private extension HomeViewModel {
    func addSubscribers() {
        dataService.$allCoins
            .sink(receiveValue: { [weak self] in
                self?.allCoins = $0
            })
            .store(in: &cancellable)

        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink(receiveValue: { [weak self] coins in
                self?.allCoins = coins
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
}
