//
//  APIRequestType.swift
//  GithubRepository
//
//  Created by Ian on 2022/02/06.
//

import Foundation

/// API Request 기능 추상화 인터페이스
protocol APIRequestType {
    associatedtype Response: Decodable

    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}
