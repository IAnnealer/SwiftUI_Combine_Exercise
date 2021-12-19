//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/19.
//

import Foundation

class HomeViewModel: ObservableObject {

    // MARK: - Properites

    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
            guard let self = self else {
                return
            }

            // Mocking
            self.allCoins.append(DeveloperPreview.instance.mockUpCoin)
            self.allCoins.append(DeveloperPreview.instance.mockUpCoin)

            self.portfolioCoins.append(DeveloperPreview.instance.mockUpCoin)
            self.portfolioCoins.append(DeveloperPreview.instance.mockUpCoin)
        })
    }
}
