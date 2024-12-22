import SwiftUI

extension Location.SearchResult {
  struct View: SwiftUI.View {
    init(location: Location.SearchResult) {
      self.location = location
    }

    private let location: Location.SearchResult
  }
}

// MARK: - View
extension Location.SearchResult.View {
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(location.name)
          .poppins(weight: .semiBold, size: 20, relativeTo: .title2)
          .foregroundColor(.primaryText)
        Text(location.region)
          .poppins(weight: .medium, size: 15, relativeTo: .title3)
          .foregroundColor(.secondaryText)
        Text(location.country)
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

#Preview {
  List {
    Location.SearchResult.View(
      location: .init(
        id: 1,
        name: "Mumbai",
        region: "Maharashtra",
        country: "India"
      )
    )
    .listRowSeparator(.hidden)
  }
  .listStyle(.plain)
}
