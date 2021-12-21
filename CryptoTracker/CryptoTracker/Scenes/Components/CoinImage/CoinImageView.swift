//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/21.
//

import SwiftUI

struct CoinImageView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: CoinImageViewModel

    // MARK: - Initializer

    init(_ coin: Coin) {
        self.viewModel = CoinImageViewModel(coin: coin)
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.theme.accent)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(dev.mockUpCoin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
