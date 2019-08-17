//
//  CityWeatherPresenter.swift
//  VIPER
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

final class CityWeatherPresenter: CityWeatherPresenterType, CityWeatherInteractorOutputsType {
    weak var view: CityWeatherViewType?
    var interactor: CityWeatherInteractorInputsType?
    var wireframe: CityWeatherWireframeType?
    
    private var cityWeather = CurrentWeather.empty
    
    func onViewDidLoad() {
        view?.showLoading()
        interactor?.fetchInitialCityWeather()
    }
    
    func didRetrieveWeather(_ weather: CurrentWeather) {
        cityWeather = weather
        view?.hideLoading()
        view?.didReceiveWeather(weather)
    }
    
    func didChangeCity(_ name: String?) {
        guard let cityName = name else { return }
        view?.showLoading()
        interactor?.fetchCityWeather(cityName)
    }
}

