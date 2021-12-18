//
//  Color+Extension.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/18.
//

import Foundation
import SwiftUI

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

extension Color {
    static let theme = ColorTheme()
}
