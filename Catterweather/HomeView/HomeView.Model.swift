import Combine
import SwiftUI

extension HomeView {
  @Observable final class Model {
    // MARK: - internal
    /// - Parameter searchDelay: How long (in seconds), after the user stops typing, a location search is performed.
    init(searchDelay: Double = 0.1) {
      cancellable = locationSearchTextPublisher
        .debounce(for: .seconds(searchDelay), scheduler: DispatchQueue.main)
        .sink { searchText in
          Task {
            self.possibleLocations = try await Location[searchText]
          }
        }
    }

    var locationSearchText = "" {
      didSet { locationSearchTextPublisher.send(locationSearchText) }
    }

    /// The possible locations for which the user is searching.
    private(set) var possibleLocations: [Location.SearchResult] = []

    // MARK: - private

    /// SwiftUI does not yet provide a way to debounce search results.
    /// Using Combine is simpler than `AsyncSequence`.
    private let locationSearchTextPublisher = PassthroughSubject<String, Never>()

    /// This is implicitly-unwrapped because it requires `self` to otherwise be initialized,
    /// before being initialized itself.
    private var cancellable: AnyCancellable!
  }
}
