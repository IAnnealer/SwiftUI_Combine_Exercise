//
//  Coin.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/19.
//

import Foundation

// CoinGecko API Info
/*
URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=krw&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h

*/


struct Coin: Codable, Identifiable {

    // MARK: - Properteis

    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H, priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "makret_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }

    var currentHoldingsValue: Double {
        (currentHoldings ?? 0) * currentPrice
    }

    var rank: Int {
        Int(marketCapRank ?? 0)
    }

    // MARK: - Methods

    func updateHoldings(amount: Double) -> Coin {
        return Coin(id: self.id, symbol: self.symbol,
                    name: self.name, image: self.image,
                    currentPrice: self.currentPrice, marketCap: self.marketCap,
                    marketCapRank: self.marketCapRank, fullyDilutedValuation: self.fullyDilutedValuation,
                    totalVolume: self.totalVolume, high24H: self.high24H,
                    low24H: self.low24H, priceChange24H: self.priceChange24H,
                    priceChangePercentage24H: self.priceChange24H, marketCapChange24H: self.marketCapChange24H,
                    marketCapChangePercentage24H: self.marketCapChangePercentage24H,
                    circulatingSupply: self.circulatingSupply, totalSupply: self.totalSupply,
                    maxSupply: self.maxSupply, ath: self.ath, athChangePercentage: self.athChangePercentage,
                    athDate: self.athDate, atl: self.atl, atlChangePercentage: self.atlChangePercentage,
                    atlDate: self.atlDate, lastUpdated: self.lastUpdated, sparklineIn7D: self.sparklineIn7D,
                    priceChangePercentage24HInCurrency: self.priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
