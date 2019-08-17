//
//  NetworkService.swift
//  VIPER
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<WeatherAPI> { get }
    func getCurrentWeather(city name: String, completion: @escaping(CurrentWeather)->())
}

struct NetworkService: Networkable {
    var provider = MoyaProvider<WeatherAPI>() //(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func getCurrentWeather(city name: String, completion: @escaping(CurrentWeather)->()) {
        provider.request(.currentWeather(cityName: name)) { result in
            switch result {
            case let .success(moyaResponse):
                
                let response = try? JSONDecoder().decode(CurrentWeather.self, from: moyaResponse.data)
                if let weather = response {
                    completion(weather)
                }
                
            case let .failure(error):
                print("error = \(error.localizedDescription)")
            }
        }
    }
}
