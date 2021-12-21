//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/21.
//

import Foundation
import Combine
import SwiftUI

final class CoinImageViewModel: ObservableObject {

    // MARK: - Properties

    @Published var image: UIImage? = nil
    @Published var isLoading: Bool

    private let coin: Coin
    private let imageService: CoinImageService
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Initializer

    init(coin: Coin) {
        self.coin = coin
        self.imageService = CoinImageService(coin)
        self.isLoading = true
        self.publishImage()
    }

    // MARK: - Methods

    private func publishImage() {
        imageService.$image
            .sink(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            }, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            })
            .store(in: &cancellable)
    }
}
