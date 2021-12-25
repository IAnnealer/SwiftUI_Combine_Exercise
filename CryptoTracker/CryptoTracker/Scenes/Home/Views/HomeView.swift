//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/18.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()

            // content layer
            VStack {
                homeHeader
                HomeStatsView(viewModel: viewModel, showPortfolio: $showPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                columnTitles

                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                        .animation(.default)
                } else {
                    portfolioCoinsList
                        .transition(.move(edge: .leading))
                        .animation(.default)
                }

                Spacer(minLength: 0)
            }
        }
    }
}

private extension HomeView {
    var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(content: {
                    CircleButtonAnimationView(animate: $showPortfolio)
                })

            Spacer()

            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none)

            Spacer()

            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.none, {
                        showPortfolio.toggle()
                    })
                }
        }
        .padding(.horizontal)
    }

    var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins, content: { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            })
        }
        .listStyle(.plain)
    }

    var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins, content: { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
            })
        }
        .listStyle(.plain)
    }

    var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Prices")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeViewModel)
    }
}
