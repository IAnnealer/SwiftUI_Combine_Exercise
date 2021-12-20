//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/19.
//

import Combine
import Foundation

class CoinDataService {

    // MARK: - Properties

    @Published var allCoins: [Coin] = []
//    private var cancellable = Set<AnyCancellable>()
    private var subscription: AnyCancellable?

    // MARK: - Initializer

    init() {
        getCoins()
    }

    // MARK: - Methods

    func getCoins() {
        guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }

        subscription = NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:),
                  receiveValue: { [weak self] in
                guard let self = self else {
                    return
                }

                self.allCoins = $0
                self.subscription?.cancel()
            })
    }
}
