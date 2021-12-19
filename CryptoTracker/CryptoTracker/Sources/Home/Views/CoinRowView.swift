//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/19.
//

import SwiftUI

struct CoinRowView: View {

    // MARK: - Properties

    let coin: Coin
    let showHoldingsColumn: Bool

    var body: some View {

        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

private extension CoinRowView {
    var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .bold()
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 25)
            Circle()
                .frame(width: 25, height: 25)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)
        }

    }

    var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(.theme.accent)
    }

    var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(.theme.accent)
            Text("\(coin.priceChangePercentage24H?.asPercentString() ?? "")")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.mockUpCoin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)

            CoinRowView(coin: dev.mockUpCoin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
