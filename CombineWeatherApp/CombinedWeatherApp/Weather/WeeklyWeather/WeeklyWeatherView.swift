import SwiftUI

struct WeeklyWeatherView: View {

  // MARK: - Properties
  @ObservedObject var viewModel: WeeklyWeatherViewModel

  // Inject viewModel when intiialzie view.
  init(viewModel: WeeklyWeatherViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    NavigationView {
      List {
        searchField

        if viewModel.dataSource.isEmpty {
          emptySection
        } else {
          cityHourlyWeatherSection
          forecastSection
        }
      }
      .listStyle(.grouped)
      .navigationBarTitle("Weather")
    }
  }
}

private extension WeeklyWeatherView {
  var searchField: some View {
    HStack(alignment: .center) {
      // TextField의 입력되는 값을 viewModel.city로 바인딩
      TextField("e.g. Seoul", text: $viewModel.city)
    }
  }

  var forecastSection: some View {
    Section {
      ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
    }
  }

  var cityHourlyWeatherSection: some View {
    Section {
      NavigationLink(destination: CurrentWeatherView(), label: {
        VStack(alignment: .leading) {
          Text(viewModel.city)
          Text("Weather today")
            .font(.caption)
            .foregroundColor(.gray)
        }
      })
    }
  }

  var emptySection: some View {
    Section {
      Text("No Results")
        .foregroundColor(.gray)
    }
  }
}
