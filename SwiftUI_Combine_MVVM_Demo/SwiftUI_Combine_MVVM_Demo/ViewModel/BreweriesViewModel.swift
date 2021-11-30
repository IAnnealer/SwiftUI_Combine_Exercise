//
//  BreweriesViewModel.swift
//  SwiftUI_Combine_MVVM_Demo
//
//  Created by 여정수 on 2021/11/30.
//

import Foundation
import Combine

class BreweriesViewModel: ObservableObject {

    // MARK: - Properties

    private let url = "https://api.openbrewerydb.org/breweries"
    private var cancellable = Set<AnyCancellable>()

    @Published var breweries: [Brewery] = []

    // MARK: - Methods

    func fetchBreweries() {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: url)!)
            .map { $0.data }
            .decode(type: [Brewery].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.breweries, on: self)
            .store(in: &cancellable)
    }
}
