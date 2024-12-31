//
//  WeatherService.swift
//  NooroTakeHome
//
//  Created by Peyton Shetler on 12/31/24.
//

import Foundation

protocol WeatherServiceInterface {
    func fetchWeatherForCity(cityName: String) async throws -> CityWeatherResponse
}

struct WeatherService: WeatherServiceInterface {
    private var apiKey = "ebeead95830b4ec1947205151242912"
    private var baseUrl = "https://api.weatherapi.com/v1/current.json"
    
    func fetchWeatherForCity(cityName: String) async throws(APIError) -> CityWeatherResponse {
        let urlString = "\(baseUrl)?key=\(apiKey)&q=\(cityName)&aqi=no"

        do {
            let weatherResponse: CityWeatherResponse = try await APIService.shared.get(urlString: urlString)
            return weatherResponse
        } catch {
            print("WeatherServiceError: \(error.localizedDescription)")
            throw error
        }
    }
}
