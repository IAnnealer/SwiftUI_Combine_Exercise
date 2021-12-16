//
//  WebServices.swift
//  HackerNews
//
//  Created by Ian on 2021/12/16.
//

import Foundation
import Combine

class WebService {

    // MARK: - Properties

    static let shared = WebService()

    static let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty")!

    private init() {}

    // MARK: - Methods

    func getAllTopStories() -> AnyPublisher<[Int], Error> {
        return URLSession.shared.dataTaskPublisher(for: Self.url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
