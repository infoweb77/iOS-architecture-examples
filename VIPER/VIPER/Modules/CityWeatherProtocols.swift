//
//  CityWeatherProtocols.swift
//  VIPER
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

protocol CityWeatherViewType: class {
    var presenter: CityWeatherPresenterType? { get set }
    func didReceiveWeather(_ weather: CurrentWeather)
    func showLoading()
    func hideLoading()
}

protocol CityWeatherWireframeType: class {
    static func createCityWeatherModule() -> UIViewController
}

protocol CityWeatherPresenterType: class {
    var view: CityWeatherViewType? { get set }
    var interactor: CityWeatherInteractorInputsType? { get set }
    var wireframe: CityWeatherWireframeType? { get set }
    
    func onViewDidLoad()
    func didChangeCity(_ name: String?)
}

protocol CityWeatherInteractorInputsType: class {
    var presenter: CityWeatherInteractorOutputsType? { get set }
    func fetchCityWeather(_ name: String)
    func fetchInitialCityWeather()
}

protocol CityWeatherInteractorOutputsType: class {
    func didRetrieveWeather(_ weather: CurrentWeather)
}
