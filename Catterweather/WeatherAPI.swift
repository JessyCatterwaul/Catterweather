import Foundation

enum WeatherAPI { }

// MARK: - internal
extension WeatherAPI {
  /// Request JSON, and decode it.
  /// - Parameters:
  ///   - method: The [API method](https://www.weatherapi.com/docs/#intro-request).
  ///   - query: [The value for `q`.](https://www.weatherapi.com/docs/#intro-request-param)
  /// - Returns: A `Decodable`, decoded from the requested JSON.
  static func request<Decodable: Swift.Decodable>(method: String, query: String) async throws -> Decodable {
    try JSONDecoder().decode(
      Decodable.self,
      from: await URLSession.shared.data(
        from: {
          var components = URLComponents()
          components.scheme = "https"
          components.host = "api.weatherapi.com"
          components.path = "/v1/\(method).json"
          components.queryItems = [
            .init(name: "key", value: .init(0x6a124d94ea674ea180694522241812 as UInt128, radix: 0x10)),
            .init(name: "q", value: query)
          ]
          return components.url!
        } ()
      ).0
    )
  }
}
