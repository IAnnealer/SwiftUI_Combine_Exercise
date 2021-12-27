//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/18.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {

    @StateObject private var homeViewModel = HomeViewModel(coinDataService: CoinDataService(),
                                                           marketDataService: MarketDataService(),
                                                           portfolioDataService: PortfolioDataService())

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(homeViewModel)
        }
    }
}
