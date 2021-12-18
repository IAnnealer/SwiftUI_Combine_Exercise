//
//  WKWebView+Extenions.swift
//  HackerNews
//
//  Created by Ian on 2021/12/18.
//

import Foundation
import WebKit

extension WKWebView {
    static func pageNotFound() -> WKWebView {
        let wkWebView = WKWebView()
        wkWebView.loadHTMLString("<html><body><h1>Page not found!</h1></body></html>", baseURL: nil)

        return wkWebView
    }
}
