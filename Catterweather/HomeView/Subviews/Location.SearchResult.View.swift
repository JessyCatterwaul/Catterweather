import SwiftUI

extension Location.SearchResult {
  struct View: SwiftUI.View {
    init(searchResult: Location.SearchResult) {
      self.searchResult = searchResult
    }

    // MARK: - private

    private let searchResult: Location.SearchResult
    @Environment(\.dismissSearch) private var dismissSearch
    @Environment(HomeView.Model.self) private var model
  }
}

// MARK: - View
extension Location.SearchResult.View {
  var body: some View {
    Button {
      dismissSearch()
      model.updateLocation(.init(searchResult))
    } label: {
      HStack {
        VStack(alignment: .leading) {
          Text(searchResult.name)
            .poppins(weight: .semiBold, size: 20, relativeTo: .title2)
            .foregroundColor(.primaryText)
          Text(searchResult.region)
            .poppins(weight: .medium, size: 15, relativeTo: .title3)
            .foregroundColor(.secondaryText)
          Text(searchResult.country)
            .poppins(weight: .medium, size: 15, relativeTo: .title3)
            .foregroundColor(.primaryText)
        }
        Spacer()
      }
      .padding(16)
      .background(.cardBackground)
      .cornerRadius(16)
    }
  }
}

#Preview {
  List {
    Location.SearchResult.View(
      searchResult: .init(
        id: 1,
        name: "Mumbai",
        region: "Maharashtra",
        country: "India"
      )
    )
    .listRowSeparator(.hidden)
  }
  .listStyle(.plain)
  .environment(try! HomeView.Model(storeLocationsToDrive: false))
}
