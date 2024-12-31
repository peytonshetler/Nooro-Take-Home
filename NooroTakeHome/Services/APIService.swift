//
//  APIService.swift
//  NooroTakeHome
//
//  Created by Peyton Shetler on 12/31/24.
//

import Foundation

class APIService {
    static let shared: APIService = APIService()
    private init() { }
    
    func get<T>(urlString: String) async throws(APIError) -> T where T : (Decodable) {
        guard let url = URL(string: urlString) else {
            throw APIError.badURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            let model = try JSONDecoder().decode(T.self, from: data)
            
            if let response = response as? HTTPURLResponse {
                let statusCode = response.statusCode
                
                // WeatherAPI.com sends error objects for these three status codes.
                // We want to surface those messages for users.
                if [400, 401, 403].contains(statusCode),
                   let apiModel = model as? WeatherAPIModel,
                   let apiError = apiModel.error {
                    throw APIError.generic(message: apiError.message)
                }
                
                // We'll catch all the remaining invalid statuses here
                guard (200...299).contains(statusCode) else {
                    throw APIError.invalidStatusCode(statusCode: statusCode)
                }
            }
            
            return model
        } catch {
            if let error = error as? APIError {
                throw error
            } else {
                throw APIError.generic(message: "An Error occurred")
            }
        }
    }
}


enum APIError: Error, LocalizedError {
    case badURL
    case invalidStatusCode(statusCode: Int)
    case generic(message: String)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad Url"
        case .invalidStatusCode(let statusCode):
            return "Bad response with status: \(statusCode)"
        case .generic(let message):
            return message
        }
    }
    
    var userFacingMessage: String {
        switch self {
        case .badURL:
            return "There's a problem with the url"
        case .invalidStatusCode(_):
            return "Hm, looks like something went wrong."
        case .generic(let message):
            return message
        }
    }
}
