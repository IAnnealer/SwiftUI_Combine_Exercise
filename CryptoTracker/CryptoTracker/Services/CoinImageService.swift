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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String

    // MARK: - Initializer

    init(_ coin: Coin) {
        self.coin = coin
        self.imageName = coin.id

        getCoinImage()
    }
}

// MARK: - Private Extension

private extension CoinImageService {

    func getCoinImage() {
        if let retrievedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = retrievedImage
        } else {
            downloadCoinImage()
        }
    }

    func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {
            return
        }

        imageSubscription = NetworkingManager.download(url: url)
            .tryMap { data -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:),
                  receiveValue: { [weak self] image in
                guard let self = self,
                      let downloadedImage = image else {
                    return
                }

                self.image = image
                self.imageSubscription?.cancel()
                self.fileManager.saveIamge(downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
