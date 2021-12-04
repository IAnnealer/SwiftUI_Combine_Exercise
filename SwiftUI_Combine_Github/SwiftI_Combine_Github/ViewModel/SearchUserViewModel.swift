//
//  SearchUserViewModel.swift
//  SwiftI_Combine_Github
//
//  Created by Ian on 2021/12/04.
//

import SwiftUI
import Combine

class SearchUserViewModel: ObservableObject {

    // MARK: - Properties
    @Published var name = "yeojaeng"
    @Published private(set) var users = [User]()
    @Published private(set) var userImages = [User: UIImage]()

    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }

    deinit {
        searchCancellable?.cancel()
    }
}

extension SearchUserViewModel {
    func search() {
        guard !name.isEmpty else {
            return
        }

        var urlComponents = URLComponents(string: "https://api.github.com/search/users")!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: name)
        ]

        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        searchCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: SearchUserResponse.self, decoder: JSONDecoder())
            .map { $0.items }
            .replaceError(with: [])
            .receive(on: RunLoop.main)      // cf
            .assign(to: \SearchUserViewModel.users, on: self)
    }

    func fetchImage(for user: User) {
        guard userImages[user] == .none else {
            return
        }

        let request = URLRequest(url: user.avatar_url)

        _ = URLSession.shared.dataTaskPublisher(for: request)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] image in
                self?.userImages[user] = image
            })
    }
}
