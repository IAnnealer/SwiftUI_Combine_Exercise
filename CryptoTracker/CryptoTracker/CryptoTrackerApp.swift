//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/18.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {

    @StateObject private var homeViewModel = HomeViewModel()

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
