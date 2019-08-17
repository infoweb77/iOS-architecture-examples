//
//  WeatherViewModel.swift
//  MVP
//
//  Created by alex on 09/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

protocol WeatherViewModelDelegate: class {
    func isDataLoading(_ loading: Bool)
    func didReceiveCurrentWeather(_ weather: CurrentWeather)
}

final class CurrentWeatherVM {
    weak var delegate: WeatherViewModelDelegate?
    
    private var currentWeather: CurrentWeather?
    
    private let throttle = Throttle(minimumDelay: 1.5)
    private var currentSearchNetworkTask: URLSessionDataTask?
    private var lastCityName: String?
    
    private let netService: NetworkService
    
    init(service: NetworkService) {
        netService = service
    }
    
    // inputs
    func ready() {
        startFetching(withCity: "Moscow")
    }
    
    func didChangeCity(_ name: String) {
        guard name.count > 2, name != lastCityName else { return }
        lastCityName = name
        
        throttle.throttle {
            self.startFetching(withCity: name)
        }
    }
    
    private func startFetching(withCity name: String) {
        currentSearchNetworkTask?.cancel()
        delegate?.isDataLoading(true)
        
        netService.getCurrentWeather(city: name) { [weak self] weather in
            guard let sSelf = self else { return }
            sSelf.finishFetching(weather)
        }
    }
    
    private func finishFetching(_ weather: CurrentWeather) {
        delegate?.isDataLoading(false)
        currentWeather = weather
        
        delegate?.didReceiveCurrentWeather(weather)
    }
}
