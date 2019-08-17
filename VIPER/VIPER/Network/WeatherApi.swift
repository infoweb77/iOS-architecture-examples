//
//  WeatherApi.swift
//  VIPER
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation
import Moya

enum WeatherAPI {
    case currentWeather(cityName: String)
}

extension WeatherAPI: TargetType {
    var baseURL: URL {
        return URL(string: Configs.Network.apiBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .currentWeather(_): return "/weather"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var task: Task {
        switch self {
        case let .currentWeather(cityName):
            return .requestParameters(parameters: ["q": cityName.urlEscaped, "APPID": Configs.App.myApiKey,
                                                   "units": "metric", "lang": "ru"], encoding: parameterEncoding)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
