//
//  StoryListVIewModel.swift
//  HackerNews
//
//  Created by Ian on 2021/12/16.
//

import Foundation
import Combine

class StoryListViewModel: ObservableObject {

    // MARK: - Properties

    @Published var stories: [StoryViewModel] = []
    private var cancellabe: AnyCancellable?

    init() {
        fetchTopStories()
    }
}

private extension StoryListViewModel {
    func fetchTopStories() {
        self.cancellabe = WebService.shared.getAllTopStories()
            .map { $0.map { StoryViewModel(id: $0) } }
            .sink(receiveCompletion: { _ in } , receiveValue: { [weak self] in
                self?.stories = $0
            })

    }
}
