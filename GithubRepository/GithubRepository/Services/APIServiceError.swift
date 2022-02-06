//
//  APIServiceError.swift
//  GithubRepository
//
//  Created by Ian on 2022/02/06.
//

import Foundation

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}
