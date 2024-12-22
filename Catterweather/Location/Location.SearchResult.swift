extension Location {
  /// Search results for location name autocomplete.
  ///
  /// These results do not include any weather information.
  /// That requires per-location API calls.
  struct SearchResult: Decodable, Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
  }
}

// MARK: - internal
extension Location {
  /// Request autocompleted locations.
  ///
  /// To achieve results for even the shortest searches,
  /// this will send `searchTerm` to the API enclosed in quotation marks,
  /// if it's under three characters.
  static subscript(searchTerm: String) -> [SearchResult] {
    get async throws {
      try await WeatherAPI.request(
        method: "search",
        query: searchTerm.count < 3 ? "\"\(searchTerm)\"" : searchTerm
      )
    }
  }
}
