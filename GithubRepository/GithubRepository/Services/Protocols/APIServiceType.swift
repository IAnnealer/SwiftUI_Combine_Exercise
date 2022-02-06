//
//  APIServiceType.swift
//  GithubRepository
//
//  Created by Ian on 2022/02/06.
//

import Foundation
import Combine

protocol APIServiceType {
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType
}
