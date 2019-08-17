//
//  CityWeatherWireframe.swift
//  VIPER
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

final class CityWeatherWireframe: CityWeatherWireframeType {
    static func createCityWeatherModule() -> UIViewController {
        let view = CityWeatherViewController()
        let presenter = CityWeatherPresenter()
        let interactor = CityWeatherInteractor()
        let wireframe = CityWeatherWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
}

