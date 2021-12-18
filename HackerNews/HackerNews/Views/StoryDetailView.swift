//
//  StoryDetailView.swift
//  HackerNews
//
//  Created by Ian on 2021/12/16.
//

import SwiftUI

struct StoryDetailView: View {

    // MARK: - Properties

    @ObservedObject private var storyDetailViewModel: StoryDetailViewModel
    private var storyId: Int

    init(storyId: Int) {
        self.storyId = storyId
        self.storyDetailViewModel = StoryDetailViewModel(storyId: storyId)
    }
 
    var body: some View {
        VStack {
            Text(self.storyDetailViewModel.title ?? "")
            WebView(url: self.storyDetailViewModel.url ?? "")
        }.onAppear {
            self.storyDetailViewModel.fetchStoryDetails(storyId: storyId)
        }
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView(storyId: 8863)
    }
}
