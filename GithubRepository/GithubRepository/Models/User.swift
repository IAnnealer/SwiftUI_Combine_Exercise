//
//  User.swift
//  GithubRepository
//
//  Created by Ian on 2022/02/05.
//

import Foundation

struct User: Decodable, Hashable, Identifiable {

    // MARK: - Properties
    let id: Int64
    let login: String
    let avatarUrl: URL
}
