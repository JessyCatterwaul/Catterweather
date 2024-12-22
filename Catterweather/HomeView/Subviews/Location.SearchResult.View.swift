import SwiftUI

extension Location.SearchResult {
  struct View: SwiftUI.View {
    init(
      searchResult: Location.SearchResult,
      selectedLocation: Binding<Location?>
    ) {
      self.searchResult = searchResult
      _selectedLocation = selectedLocation
    }

    // MARK: - private

    private let searchResult: Location.SearchResult
    @Environment(\.dismissSearch) private var dismissSearch

    /// This view does not need to `get` the selected location,
    /// but it does need to set it.
    @Binding private var selectedLocation: Location?
  }
}

// MARK: - View
extension Location.SearchResult.View {
  var body: some View {
    Button {
      dismissSearch()
      selectedLocation = .init(searchResult)
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
      ),
      selectedLocation: .constant(nil)
    )
    .listRowSeparator(.hidden)
  }
  .listStyle(.plain)
}
