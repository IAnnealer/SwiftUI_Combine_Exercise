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

    func getAllTopStories() -> AnyPublisher<[Story], Error> {
        return URLSession.shared.dataTaskPublisher(for: Self.url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .flatMap { storyIds in return self.mergeStories(ids: storyIds) }
            .scan([], { stories, story -> [Story] in
                return stories + [story]
            })
            .eraseToAnyPublisher()
    }

    func getStoryById(storyId: Int) -> AnyPublisher<Story, Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(storyId).json?print=pretty") else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: Story.self, decoder: JSONDecoder())
            .catch { _ in Empty<Story, Error>() }
            .eraseToAnyPublisher()
    }
}

private extension WebService {
    func mergeStories(ids storyIds: [Int]) -> AnyPublisher<Story, Error> {
        let storyIds = Array(storyIds.prefix(50))
        let initialPublisher = getStoryById(storyId: storyIds[0])
        let remainer = Array(storyIds.dropFirst())

        return remainer
            .reduce(initialPublisher) { combined, id in
                return combined.merge(with: getStoryById(storyId: id))
                    .eraseToAnyPublisher()
            }
    }
}
