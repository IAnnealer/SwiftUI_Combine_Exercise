//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/20.
//

import Foundation
import Combine

final class NetworkingManager {

    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unKnown

        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url):
                return "[⚠️ ERROR - \(#file)] Bad response from \(url)."
            case .unKnown:
                return "[⚠️ ERROR - \(#file)] Unknown error occured"
            }
        }
    }

    // MARK: - Methods

    /// Download and Return the data.
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))     // On Sub-Thread
            .tryMap { try tryHandleURLResponse(output: $0, url: url) }
            .receive(on: DispatchQueue.main)    // On Main-Thread
            .eraseToAnyPublisher()
    }

    /// Handle normal completion.
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let err):
            print(err.localizedDescription)
        }
    }

    /// Try handle DataTaskPublisher.Output to Data
    static func tryHandleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 300 else {
                  throw NetworkingError.badURLResponse(url: url)
              }

        return output.data
    }
}
