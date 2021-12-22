//
//  UIApplication+Extension.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/22.
//

import Foundation
import SwiftUI

extension UIApplication {

    // MARK: - Methods

    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}
