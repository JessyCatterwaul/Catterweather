import Observation

/// The location for which the user wants to know the weather.
///
/// See [Weather API's documentation](https://www.weatherapi.com/docs/#intro-location)
/// for further available details.
@Observable final class Location {
  init(name: String, id: Int, currentWeather: Weather? = nil) {
    self.name = name
    self.id = id
    self.currentWeather = currentWeather
  }

  let name: String

  /// Weather API's unique identifier.
  let id: Int

  private(set) var currentWeather: Weather?
}

// MARK: - internal
extension Location {
  convenience init(_ searchResult: SearchResult) {
    self.init(name: searchResult.name, id: searchResult.id)
  }

  func updateWeather() async throws {
    currentWeather = try await WeatherAPI.request(method: "current", query: "id:\(id)")
  }
}
