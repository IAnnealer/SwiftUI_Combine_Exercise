//
//  StoryDetailViewModel.swift
//  HackerNews
//
//  Created by Ian on 2021/12/16.
//

import Foundation
import Combine

class StoryDetailViewModel: ObservableObject {

    // MARK: - Properties

    var storyId: Int
    var title: String?
    var url: URL?
    private var cancellable: AnyCancellable?

    @Published private var story: Story! {
        didSet {
            self.title = story.title
            self.url = URL(string: story.url)
        }
    }

    // MARK: - Initializer
    init(storyId: Int) {
        self.storyId = storyId
        self.cancellable = WebService.shared.getStoryById(storyId: storyId)
            .catch { _ in Just(Story.placeholder()) }
            .sink(receiveCompletion: { _ in }, receiveValue: {
                self.story = $0
            })
    }
}
