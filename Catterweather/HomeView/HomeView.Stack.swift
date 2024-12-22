import SwiftUI

extension HomeView {
  /// A parent view that is necessary for `HomeView`'s search bar to function.
  ///
  /// 1. The `searchable` modifier requires a navigation view.
  /// 2. The `isSearching` environment variable requires `searchable` on a ***parent*** view.
  ///
  /// This view serves both purposes.
  struct Stack: View {
    @State private var model = HomeView.Model()
  }
}

// MARK: - View
extension HomeView.Stack {
  var body: some View {
    NavigationStack {
      HomeView(model: $model)
        .searchable(text: $model.locationSearchText, prompt: "Search Location")
    }
  }
}

#Preview {
  HomeView.Stack()
}
