//
//  User.swift
//  SwiftUI_Combine_Github
//
//  Created by Ian on 2021/12/04.
//

import Foundation

struct User: Hashable, Identifiable, Decodable {
    var id: Int64
    var login: String
    var avatar_url: URL
}

struct SearchUserResponse: Decodable {
    var items: [User]
}
