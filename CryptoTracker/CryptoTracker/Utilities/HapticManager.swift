//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/28.
//

import Foundation
import SwiftUI

class HapticManager {

    // MARK: - Properties

    static private let generator = UINotificationFeedbackGenerator()

    // MARK: - Methods

    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
