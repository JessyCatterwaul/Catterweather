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
      List(model.possibleLocations) { location in
        VStack {
          Text(location.name)
          Text(location.region)
          Text(location.country)
        }
      }
    } else {
      VStack {
        Text("No City Selected")
        Text("Please search for a City")
      }
    }
  }
}
