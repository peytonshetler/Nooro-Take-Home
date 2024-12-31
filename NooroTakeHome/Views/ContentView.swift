//
//  ContentView.swift
//  NooroTakeHome
//
//  Created by Peyton Shetler on 12/30/24.
//

import SwiftUI

enum UserDefaultsKeys: String {
    case cityName
}

struct ContentView: View {
    @AppStorage(UserDefaultsKeys.cityName.rawValue) private var cachedCityName = ""
    @State private var viewModel = HomeViewModel()

    var body: some View {
        VStack() {
            // Search View
            VStack {
                Spacer()
                    .frame(height: 44)
                    .background(.blue)
                
                HStack {
                    TextField("Search Location", text: $viewModel.searchText)
                        .onChange(of: viewModel.searchText) { _, newValue in
                            // debounce
                            // trigger viewModel.getWeather() func
                        }
                    Image(systemName: "magnifyingglass")
                }
                .frame(height: 46)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.secondary)
                .cornerRadius(16)
            } // End Search View
            
            Spacer()
            
        } // End VStack
        .padding(.horizontal, 24)
//        .overlay(Group {
//            if !viewModel.hasCachedCity {
//                NoCitySelectedView()
//            }
//        }) // End Overlay
        .alert(
            "Something went wrong.",
            isPresented: $viewModel.shouldShowAlert,
            actions: { Button("Ok") { viewModel.errorMessage = nil } },
            message: { Text(viewModel.errorMessage ?? "") }
        ) // End Alert
        .task {
            await viewModel.getWeather(text: "Nashville")
        }
    }
}

#Preview {
    ContentView()
}

enum ViewModelNetworkState {
    case loading, completed
}

@Observable @MainActor
class HomeViewModel {
    let weatherService: WeatherService
    var searchText: String = ""
    var result: CityWeatherResponse?
    var errorMessage: String?
    var shouldShowAlert: Bool = false
    
    var hasCachedCity: Bool {
        if let name = UserDefaults.standard.string(forKey: UserDefaultsKeys.cityName.rawValue),
           name != "" {
            return true
        }
        return false
    }
    
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func getWeather(text: String) async {
        do {
            result = try await weatherService.fetchWeatherForCity(cityName: text)
            dump(result)
        } catch {
            print(error.localizedDescription)
            errorMessage = error.userFacingMessage
            shouldShowAlert = true
        }
    }
}
