//
//  MaketDataService.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/25.
//

import Combine
import Foundation

class MarketDataService {

    // MARK: - Properties

    @Published var marketData: MarketData? = nil
    var marketDataSubscription: AnyCancellable?

    init() {
        getMarketData()
    }
}

private extension MarketDataService {
    func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }

        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] in
                self?.marketData = $0.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
