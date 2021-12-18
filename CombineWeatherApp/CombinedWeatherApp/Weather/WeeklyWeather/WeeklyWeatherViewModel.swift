import SwiftUI
import Combine

class WeeklyWeatherViewModel: ObservableObject, Identifiable {

  // MARK: - Properties
  @Published var city: String = ""
  @Published var dataSource: [DailyWeatherRowViewModel] = []

  private let weatherFetcher: WeatherFetchable
  private var disposables = Set<AnyCancellable>()

  // MARK: - Initializer
  init(weatherFetcher: WeatherFetchable) {
    self.weatherFetcher = weatherFetcher
  }

  // MARK: - Methods
  private func fetchWeather(forCity city: String) {
    weatherFetcher.weeklyWeatherForecast(forCity: city)
      .map { $0.list.map(DailyWeatherRowViewModel.init) }   // Response.item to ViewModel
      .map(Array.removeDuplicates)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
        guard let self = self else {
           return
        }

        switch completion {
        case .failure:
          self.dataSource = []
        case .finished:
          break
        }
      }, receiveValue: { [weak self] forecasts in
        guard let self = self else {
          return
        }

        self.dataSource = forecasts
      })
      .store(in: &disposables)
  }
}
