import Combine
import SwiftUI

struct HomeView: View {
  @Environment(\.isSearching) private var isSearching
  @Binding private var model: Model

  init(model: Binding<Model>) {
    _model = model
  }
}

// MARK: - View
extension HomeView {
  @ViewBuilder var body: some View {
    if isSearching {
      List(model.possibleLocations) { possibleLocation in
        Location.SearchResult.View(
          searchResult: possibleLocation,
          selectedLocation: $model.location
        )
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
    } else if let location = model.location {
      Location.View(location: location)
        .transition(.blurReplace)
    } else {
      NoCityView()
        .transition(.blurReplace)
    }
  }
}
