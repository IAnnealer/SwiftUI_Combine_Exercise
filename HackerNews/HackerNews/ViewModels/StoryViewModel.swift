//
//  StoryViewModel.swift
//  HackerNews
//
//  Created by Ian on 2021/12/16.
//

import Foundation
import Combine

struct StoryViewModel {

    // MARK: - Properties

    let story: Story

    var id: Int {
        return self.story.id
    }

    var title: String {
        return self.story.title
    }

    var url: String {
        return self.story.url
    }
}
