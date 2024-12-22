import SwiftUI

extension Location {
  struct View: SwiftUI.View {
    init(location: Location) {
      self.location = location
    }

    // MARK: - private

    private let location: Location
    private var hasCurrentWeather: Bool { location.currentWeather != nil }
    @ScaledMetric(relativeTo: .title) private var scaledPadding = 16
  }
}

// MARK: - View
extension Location.View {
  var body: some View {
    VStack(alignment: .center, spacing: scaledPadding) {
      WeatherView(locationName: location.name, weather: location.currentWeather)
        .animation(.easeOut(duration: 0.5), value: hasCurrentWeather)
      Spacer()
    }
  }
}

// MARK: - private
private extension Location.View {
  private struct WeatherView: View {
    private struct WeatherDetailStack: View {
      let name: String
      let value: String

      var body: some View {
        VStack {
          Text(name)
            .poppins(weight: .medium, size: 12, relativeTo: .subheadline)
            .foregroundColor(.tertiaryText)
          Text(value)
            .poppins(weight: .medium, size: 15, relativeTo: .headline)
            .foregroundColor(.secondaryText)
        }
      }
    }

    let locationName: String
    let weather: Weather?

    var body: some View {
      AsyncImage(url: weather?.iconURL) { image in
        image
          .resizable()
          .scaledToFit()
      } placeholder: {
        ZStack {
          RoundedRectangle(cornerRadius: 16)
            .fill(.cardBackground)
          ProgressView()
        }
      }
      .frame(width: 123, height: 123, alignment: .bottom)

      HStack {
        Text(locationName)
          .poppins(weight: .semiBold, size: 30, relativeTo: .title)
          .foregroundColor(.primaryText)
        Image(systemName: "location.fill")
          .imageScale(.large)
      }

      Text("\(weather?.temperature.description ?? "—")°")
        .poppins(weight: .medium, size: 70, relativeTo: .largeTitle)
        .foregroundColor(.primaryText)

      HStack(alignment: .center, spacing: 56) {
        WeatherDetailStack(name: "Humidity", value: "\(weather?.humidity.description ?? "—")%")
        WeatherDetailStack(name: "UV", value: weather?.uv.description ?? "—")
        WeatherDetailStack(name: "Feels Like", value: "\(weather?.feelsLikeTemperature.description ?? "—")°")
      }
      .padding(16)
      .background(Color.cardBackground.cornerRadius(16))
    }
  }
}

#Preview {
  Location.View(
    location: .init(
      name: "Hyderabad",
      id: 1116530,
      currentWeather: .init(
        temperature: 31,
        feelsLikeTemperature: 38,
        humidity: 20,
        uv: 4,
        iconURL: .init(string: "https://cdn.weatherapi.com/weather/64x64/night/113.png")!
      )
    )
  )
}

#Preview {
  Location.View(
    location: .init(
      name: "Hyderabad",
      id: 1116530,
      currentWeather: nil
    )
  )
}
