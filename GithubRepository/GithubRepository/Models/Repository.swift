//
//  Repository.swift
//  GithubRepository
//
//  Created by Ian on 2022/02/05.
//

import Foundation

struct Repository: Decodable, Hashable, Identifiable {

    // MARK: - Properties
    let id: Int64
    let fullName: String
    let description: String?
    var strgazersCount: Int = 0
    let language: String?
    let owner: User
}
