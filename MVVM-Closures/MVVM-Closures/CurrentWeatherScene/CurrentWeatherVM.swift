//
//  WeatherViewModel.swift
//  MVVM-Closures
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

final class CurrentWeatherVM {
    // outputs
    var isRefreshing: ((Bool) -> Void)?
    var didUpdateWeather: ((CurrentWeather) -> Void)?
    
    private(set) var currentWeather: CurrentWeather? = CurrentWeather.empty {
        didSet {
            if let weather = currentWeather {
                didUpdateWeather?(weather)
            }
        }
    }
    
    private let throttle = Throttle(minimumDelay: 1.5)
    private var lastCityName: String?
    
    private let netService: NetworkService
    
    init(service: NetworkService) {
        netService = service
    }
    
    // inputs
    func ready() {
        isRefreshing?(true)
        
        netService.getCurrentWeather(city: "Moscow") { [weak self] weather in
            guard let sSelf = self else { return }
            sSelf.finishFetching(weather)
        }
    }
    
    func didChangeCity(_ name: String) {
        guard name.count > 2, name != lastCityName else { return }
        lastCityName = name
        
        throttle.throttle {
            self.startFetching(withCity: name)
        }
    }
    
    private func startFetching(withCity name: String) {
        isRefreshing?(true)
        
        netService.getCurrentWeather(city: name) { [weak self] weather in
            guard let sSelf = self else { return }
            sSelf.finishFetching(weather)
        }
    }
    
    private func finishFetching(_ weather: CurrentWeather) {
        isRefreshing?(false)
        currentWeather = weather
    }
}
