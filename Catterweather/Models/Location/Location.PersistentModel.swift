import SwiftData

extension Location {
  /// This type acts solely to persist `Location` data.
  ///
  /// Ideally, `Location` could be a `Model` (with `currentWeather` being `Transient`).
  /// But `Model`s do not (yet) update UI the way that other `Observable`s do,
  /// so an intermediary type is necessary.
  @Model final class PersistentModel {
    init(_ location: Location) {
      self.name = location.name
      self.id = location.id
    }

    private(set) var name: String

    /// Weather API's unique identifier.
    @Attribute(.unique) private(set) var id: Int
  }
}
