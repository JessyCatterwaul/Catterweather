import Foundation

struct Weather {
  /// In degrees Celsius
  let temperature: Int

  /// In degrees Celsius
  let feelsLikeTemperature: Int

  /// Humidity percentage
  let humidity: Int

  /// UV index
  let uv: Int

  let iconURL: URL
}

// MARK: - Decodable
extension Weather: Decodable {
  init(from decoder: any Decoder) throws {
    enum CodingKey: Swift.CodingKey {
      case current

      case temp_c
      case feelslike_c
      case humidity
      case uv

      case condition
      case icon
    }

    let container = try decoder.container(keyedBy: CodingKey.self)
      .nestedContainer(keyedBy: CodingKey.self, forKey: .current)

    
    /// Decode `Double`s and round them to `Int`s.
    func decode(key: CodingKey) throws -> Int {
      .init(
        try container.decode(Double.self, forKey: key).rounded()
      )
    }

    try self.init(
      temperature: decode(key: .temp_c),
      feelsLikeTemperature: decode(key: .feelslike_c),
      humidity: decode(key: .humidity),
      uv: decode(key: .uv),
      iconURL: {
        // The following force unwrapping is fine here,
        // because an error will be thrown if the URL is somehow invalid,
        // before any unwrapping would take place.
        // And if an error is not thrown, it is impossible for the unwrapping to fail.
        var components = URLComponents(
          url: try container
            .nestedContainer(keyedBy: CodingKey.self, forKey: .condition)
            .decode(URL.self, forKey: .icon),
          resolvingAgainstBaseURL: true
        )!
        components.scheme = "https"
        return components.url!
      } ()
    )
  }
}
