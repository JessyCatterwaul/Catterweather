import Testing
@testable import Catterweather

struct WeatherAPITests {
  /// This test ensures we have a valid API key,
  /// which is fundamental to the app's functionality.
  @Test func key() async throws {
    // This space is encoded as `%20` and won't yield any results.
    #expect(try await Location[" "].isEmpty)
  }

  /// Multiple results should be returned for most characters.
  /// The current limit is 5, but this is not guaranteed by the API.
  @Test func locationSearch() async throws {
    #expect(try await Location["a"].isEmpty == false)
  }

  /// Search for a location by name, then retrieve its weather data.
  @Test func weather() async throws {
    let name = "Mumbai"
    let location = try Location(
      await #require(Location[name].first)
    )
    #expect(location.name == name)
    try await location.updateWeather()
    #expect(location.currentWeather != nil)
  }
}
