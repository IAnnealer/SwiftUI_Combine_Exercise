//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/21.
//

import Combine
import Foundation
import SwiftUI

// 이미지 다운로드 로직을 분리하여 재사용성을 높인다.
class CoinImageService {

    // MARK: - Properties

    @Published var image: UIImage? = nil

    private var imageSubscription: AnyCancellable?
    private let coin: Coin


    // MARK: - Initializer

    init(_ coin: Coin) {
        self.coin = coin
        getCoinImage()
    }

    // MARK: - Methods

    func getCoinImage() {
        guard let url = URL(string: coin.image) else {
            return
        }

        imageSubscription = NetworkingManager.download(url: url)
            .tryMap { data -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:),
                  receiveValue: { [weak self] image in
                self?.image = image
                self?.imageSubscription?.cancel()
            })
    }
}
