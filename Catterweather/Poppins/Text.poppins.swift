import SwiftUI

extension Text {
  /// Style this view using the Poppins font.
  func poppins(
    weight: Font.Weight.Poppins, size: Double, relativeTo textStyle: Font.TextStyle
  ) -> Self {
    font(.custom("Poppins-\(weight)", size: size, relativeTo: textStyle))
  }
}

extension Font.Weight {
  enum Poppins {
    case medium
    case semiBold
  }
}

// MARK: - CustomStringConvertible
extension Font.Weight.Poppins: CustomStringConvertible {
  var description: String {
    switch self {
    case .medium: "Medium"
    case .semiBold: "SemiBold"
    }
  }
}
