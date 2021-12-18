//
//  StoryWebView.swift
//  HackerNews
//
//  Created by Ian on 2021/12/17.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    // MARK: - Properties

    var url: String

    // MARK: - Methods

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView.pageNotFound()
        }
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)


        return wkWebView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: self.url) else {
            return
        }

        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
