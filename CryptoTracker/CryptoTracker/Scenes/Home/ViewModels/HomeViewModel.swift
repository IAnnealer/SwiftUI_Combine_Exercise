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
    }
}
