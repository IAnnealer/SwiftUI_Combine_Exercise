//
//  Double+Extension.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/19.
//

import Foundation

extension Double {

    // MARK: - Properties

    /// Convert a Dobule to Currency with 2 decimal places.
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        return formatter
    }

    /// Convert a Dobule to Currency with 2~6 decimal places.
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6

        return formatter
    }

    // MARK: - Methods

    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }

    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }

    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }

    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
