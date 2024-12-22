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
      List(model.possibleLocations, rowContent: Location.SearchResult.View.init)
    } else {
      NoCityView()
    }
  }
}
