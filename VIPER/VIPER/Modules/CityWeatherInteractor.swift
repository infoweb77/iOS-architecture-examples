//
//  CityWeatherInteractor.swift
//  VIPER
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

final class CityWeatherInteractor: CityWeatherInteractorInputsType {
    weak var presenter: CityWeatherInteractorOutputsType?
    
    // dependencies
    private let networkService: NetworkService
    private let validator = ThrottledTextFieldValidator()
    
    init(service: NetworkService = NetworkService()) {
        networkService = service
    }
    
    func fetchCityWeather(_ name: String) {
        if(name.isEmpty) {
            startFetching("Moscow")
        } else {
            validator.validate(query: name) { [weak self] name in
                guard let sSelf = self, let cityName = name else { return }
                sSelf.startFetching(cityName)
            }
        }
    }
    
    func fetchInitialCityWeather() {
        startFetching("Moscow")
    }
    
    private func startFetching(_ name: String) {
        networkService.getCurrentWeather(city: name) { [weak self] weather in
            guard let sSelf = self else { return }
            sSelf.presenter?.didRetrieveWeather(weather)
        }
    }
}

