import typealias Foundation.DispatchQueue
import Combine
import SwiftData

extension HomeView {
  @Observable final class Model {
    /// - Parameters:
    ///   - storeLocationsToDrive: Setting this to `false` can be useful for previewing.
    ///   - searchDelay: How long (in seconds), after the user stops typing, a location search is performed.
    /// - Throws: If SwiftData cannot create a model container—which should never happen.
    init(
      storeLocationsToDrive: Bool = true,
      searchDelay: Double = 0.1
    ) throws {
      container = try ModelContainer(
        for: Location.PersistentModel.self,
        configurations: .init(isStoredInMemoryOnly: !storeLocationsToDrive)
      )

      if let location: Location.PersistentModel = try? makeContext().fetch(.init()).first {
        updateLocation(.init(location))
      }

      cancellable = locationSearchTextPublisher
        .debounce(for: .seconds(searchDelay), scheduler: DispatchQueue.main)
        .sink { searchText in
          Task {
            self.possibleLocations = try await Location[searchText]
          }
        }
    }

    /// The user's chosen location.
    private(set) var location: Location?

    var locationSearchText = "" {
      didSet { locationSearchTextPublisher.send(locationSearchText) }
    }

    /// The possible locations for which the user is searching.
    private(set) var possibleLocations: [Location.SearchResult] = []

    /// Request weather data from the API, and persist the location to drive.
    ///
    /// - Note: This could be the body of `location`'s `didSet`, instead,
    /// if `@Observable` were compatible with property observers.
    func updateLocation(_ location: Location) {
      Task(operation: location.updateWeather)
      let context = makeContext()

      if self.location != nil {
        // This should always be overkill,
        // but in the unlikely event that multiple previous deletions failed,
        // this will ensure that the correct location will appear at app launch,
        // rather than one that is unnecessarily hanging around on drive.
        try? context.delete(model: Location.PersistentModel.self)
      }

      self.location = location
      context.insert(Location.PersistentModel(location))

      // TODO: Ask the designer(s) what they would like to display in the unlikely event that saving fails.
      // (The app will still function otherwise if saving a location is impossible.)
      try? context.save()
    }

    // MARK: - private

    /// The container for saving one selected location.
    private let container: ModelContainer

    /// SwiftUI does not yet provide a way to debounce search results.
    /// Using Combine is simpler than `AsyncSequence`.
    private let locationSearchTextPublisher = PassthroughSubject<String, Never>()

    /// This is implicitly-unwrapped because it requires `self` to otherwise be initialized,
    /// before being initialized itself.
    private var cancellable: AnyCancellable!
  }
}

// MARK: - private
private extension HomeView.Model {
  /// Creating per-operation model contexts, for thread safety, may not be necessary for this app.
  /// But it doesn't hurt anything, and is more future-proof than always using the same context.
  func makeContext() -> ModelContext { .init(container) }
}
