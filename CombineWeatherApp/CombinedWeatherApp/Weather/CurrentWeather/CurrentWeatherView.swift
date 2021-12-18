import SwiftUI
import Combine

struct CurrentWeatherView: View {

  // MARK: - Properties
  @ObservedObject var viewModel: CurrentWeatherViewModel

  // MARK: - Initializer
  init(viewModel: CurrentWeatherViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    List(content: content)
      .onAppear(perform: viewModel.refresh)
      .navigationBarTitle(viewModel.city)
      .listStyle(GroupedListStyle())
  }
}

// MARK: - Private Extension
private extension CurrentWeatherView {
  var loading: some View {
    Text("Loading \(viewModel.city)'s weather...")
      .foregroundColor(.gray)
  }

  func content() -> some View {
    if let viewModel = viewModel.dataSource {
      return AnyView(details(for: viewModel))
    } else {
      return AnyView(loading)
    }
  }

  func details(for viewModel: CurrentWeatherRowViewModel) -> some View {
    CurrentWeatherRow(viewModel: viewModel)
  }
}
