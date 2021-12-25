//
//  Statistic.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/25.
//

import Foundation

struct Statistic: Identifiable {

    // MARK: - Properties

    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?

    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
