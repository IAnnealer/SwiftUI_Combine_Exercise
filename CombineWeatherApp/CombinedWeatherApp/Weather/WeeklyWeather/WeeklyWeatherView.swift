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
      VStack {
        NavigationLink(
          "Best weather app :] ⛅️",
          destination: CurrentWeatherView()
        )
      }
    }
  }
}
