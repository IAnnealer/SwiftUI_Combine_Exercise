//
//  Story.swift
//  HackerNews
//
//  Created by Ian on 2021/12/16.
//

import Foundation

struct Story: Codable {

    // MARK: - Properties

    let id: Int
    let title: String
    let url: String
}

extension Story {
    static func placeholder() -> Story {
        return Story(id: 0, title: "N/A", url: "")
    }
}
