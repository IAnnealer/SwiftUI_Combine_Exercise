//
//  AnySubscription.swift
//  GithubRepository
//
//  Created by Ian on 2022/02/05.
//

import Combine

final class AnySubscription: Subscription {

    // MARK: - Properties
    private let cancellable: AnyCancellable

    init(_ cancel: @escaping() -> Void) {
        self.cancellable = AnyCancellable(cancel)
    }

    // MARK: - Methods
    func request(_ demand: Subscribers.Demand) {}

    func cancel() {
        cancellable.cancel()
    }
}
