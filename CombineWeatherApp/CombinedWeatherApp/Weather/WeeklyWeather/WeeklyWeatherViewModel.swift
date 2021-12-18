import SwiftUI
import Combine

class WeeklyWeatherViewModel: ObservableObject, Identifiable {

  // MARK: - Properties
  @Published var city: String = ""
  @Published var dataSource: [DailyWeatherRowViewModel] = []

  private let weatherFetcher: WeatherFetchable
  private var disposables = Set<AnyCancellable>()

  // MARK: - Initializer
  init(weatherFetcher: WeatherFetchable, scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")) {
    self.weatherFetcher = weatherFetcher

    // View의 TextField에서 입력받은 값을 통해 weather fetching
    $city
      .dropFirst(1)
      .debounce(for: .seconds(0.5), scheduler: scheduler)
      .sink(receiveValue: fetchWeather(forCity:))
      .store(in: &disposables)
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

extension WeeklyWeatherViewModel {
  var currentWeatherView: some View {
    return WeeklyWeatherBuilder.makeCurerntWeatherView(withCity: city, weatherFetcher: weatherFetcher)
  }
}
