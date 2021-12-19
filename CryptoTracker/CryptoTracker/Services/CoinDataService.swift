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

        subscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))     // On Sub-Thread
            .tryMap { output -> Data in
                guard let resposne = output.response as? HTTPURLResponse,
                      resposne.statusCode >= 200 && resposne.statusCode < 300 else {
                          throw URLError(.badServerResponse)
                      }

                return output.data
            }
            .receive(on: DispatchQueue.main)        // On Main-Thread
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }, receiveValue: { [weak self] coins in
                guard let self = self else {
                    return
                }
                self.allCoins = coins
                self.subscription?.cancel()
            })
    }
}
