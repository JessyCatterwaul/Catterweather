import Combine
import SwiftUI

struct HomeView: View {
  @Environment(\.isSearching) private var isSearching
  @Environment(HomeView.Model.self) private var model
}

// MARK: - View
extension HomeView {
  @ViewBuilder var body: some View {
    if isSearching {
      List(model.possibleLocations) { possibleLocation in
        Location.SearchResult.View(searchResult: possibleLocation)
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
