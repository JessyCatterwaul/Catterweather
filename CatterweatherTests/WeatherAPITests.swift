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
}
