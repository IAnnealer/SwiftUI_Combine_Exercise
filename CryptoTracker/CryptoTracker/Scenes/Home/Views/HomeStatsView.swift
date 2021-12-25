//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/25.
//

import SwiftUI

struct HomeStatsView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: HomeViewModel
    @Binding var showPortfolio: Bool

    var body: some View {
        HStack {
            ForEach(viewModel.statistics, content: {
                StatisticsView(stat: $0)
                    .frame(width: UIScreen.main.bounds.width / 3)
            })
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}
