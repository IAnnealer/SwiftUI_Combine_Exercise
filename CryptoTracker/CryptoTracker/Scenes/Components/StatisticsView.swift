//
//  StatisticsView.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/25.
//

import SwiftUI

struct StatisticsView: View {

    let stat: Statistic

    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)

            Text(stat.value)
                .font(.headline)
                .foregroundColor(.theme.accent)

            HStack(spacing: 5) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        .degrees((stat.percentageChange ?? 0) >= 0 ? 0 : 180)
                    )

                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor(stat.percentageChange ?? 0 >= 0 ? .theme.green : .theme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticsView(stat: dev.stat1)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            StatisticsView(stat: dev.stat2)
                .previewLayout(.sizeThatFits)
            StatisticsView(stat: dev.stat3)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
