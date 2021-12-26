//
//  PortfolioVIew.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/26.
//

import SwiftUI

struct PortfolioView: View {

    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                        .padding([.leading, .trailing, .bottom])
                    coingLogoList

                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: { XMarkButton() })
                ToolbarItem(placement: .navigationBarTrailing, content: { trailingNavButton })
            })
        }
    }
}

struct PortfolioVIew_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(viewModel: dev.homeViewModel)
    }
}

private extension PortfolioView {
    var coingLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.allCoins, content: { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 60)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn, {
                                selectedCoin = coin
                            })
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.accent : Color.clear,
                                        lineWidth: 1)
                        )
                })
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }

    var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }

            Divider()
            HStack {
                Text("Amount in your Portfolio: ")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value: ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }

    var trailingNavButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button(action: {
                didTapSaveButton()
            }, label: {
                Text("SAVE")
            })
                .opacity(
                    (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
                )
        }
        .font(.headline)
    }

    func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }

    func didTapSaveButton() {
        guard let coin = selectedCoin else { return }

        withAnimation(.easeIn, {
            showCheckmark = true
            removeSelectedCoin()
        })

        UIApplication.shared.endEditing()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            withAnimation(.easeOut, {
                showCheckmark = false
            })
        })
    }

    func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}
