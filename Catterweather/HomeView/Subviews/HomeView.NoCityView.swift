import SwiftUI

extension HomeView {
  struct NoCityView: View { }
}

// MARK: - View
extension HomeView.NoCityView {
  var body: some View {
    VStack {
      Text("No City Selected")
        .poppins(weight: .semiBold, size: 30, relativeTo: .title)
      Text("Please Search For A City")
        .poppins(weight: .semiBold, size: 15, relativeTo: .title3)
    }
    .foregroundColor(.primaryText)
  }
}

#Preview {
  HomeView.NoCityView()
}
