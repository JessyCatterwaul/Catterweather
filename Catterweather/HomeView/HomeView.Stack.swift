import SwiftUI

extension HomeView {
  /// A parent view that is necessary for `HomeView`'s search bar to function.
  ///
  /// 1. The `searchable` modifier requires a navigation view.
  /// 2. The `isSearching` environment variable requires `searchable` on a ***parent*** view.
  ///
  /// This view serves both purposes.
  struct Stack: View {
    @State private var model: Model

    /// - Parameter storeLocationsToDrive: Setting this to `false` can be useful for previewing.
    /// - Throws: If SwiftData cannot create a model container—which should never happen.
    init(storeLocationsToDrive: Bool = true) throws {
      model = try Model(storeLocationsToDrive: storeLocationsToDrive)
    }
  }
}

// MARK: - View
extension HomeView.Stack {
  var body: some View {
    NavigationStack {
      HomeView()
        .environment(model)
        .searchable(text: $model.locationSearchText, prompt: "Search Location")
    }
  }
}

#Preview {
  try? HomeView.Stack(storeLocationsToDrive: false)
}
