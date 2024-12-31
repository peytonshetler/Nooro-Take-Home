//
//  Models.swift
//  NooroTakeHome
//
//  Created by Peyton Shetler on 12/30/24.
//

import Foundation

protocol WeatherAPIModel {
    var error: WeatherError? { get }
}

// MARK: - Decodable API Models. Used for decoding responses from the API.

struct CityWeatherResponse: Decodable, WeatherAPIModel {
    var location: Location?
    var current: CurrentWeather?
    var error: WeatherError?
    
    init(location: Location, current: CurrentWeather, error: WeatherError?) {
        self.location = location
        self.current = current
        self.error = error
    }
    
    enum CodingKeys: String, CodingKey {
        case location
        case current
        case error
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        location = try container.decodeIfPresent(Location.self, forKey: .location)
        current = try container.decodeIfPresent(CurrentWeather.self, forKey: .current)
        error = try container.decodeIfPresent(WeatherError.self, forKey: .error)
    }
}

struct Location: Decodable {
    var name: String
}

struct CurrentWeather: Decodable {
    var celsiusTemp: Double
    var farenheitTemp: Double
    var condition: WeatherCondition
    var humidity: Int
    var feelsLikeCelsius: Double
    var feelsLikeFarenheit: Double
    var uvIndex: Double
    
    enum CodingKeys: String, CodingKey {
        case celsiusTemp = "temp_c"
        case farenheitTemp = "temp_f"
        case condition
        case humidity
        case feelsLikeCelsius = "feelslike_c"
        case feelsLikeFarenheit = "feelslike_f"
        case uvIndex = "uv"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.celsiusTemp = try container.decode(Double.self, forKey: .celsiusTemp)
        self.farenheitTemp = try container.decode(Double.self, forKey: .farenheitTemp)
        self.condition = try container.decode(WeatherCondition.self, forKey: .condition)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.feelsLikeCelsius = try container.decode(Double.self, forKey: .feelsLikeCelsius)
        self.feelsLikeFarenheit = try container.decode(Double.self, forKey: .feelsLikeFarenheit)
        self.uvIndex = try container.decode(Double.self, forKey: .uvIndex)
    }
}

struct WeatherCondition: Decodable {
    var text: String
    var icon: String
}

// For codes 400, 401 & 403, the WeatherAPI responds with an error object containing
// two properties: "code" (Int), and "message"(String)
struct WeatherError: Decodable {
    var code: Int
    var message: String
}
