//
//  NetworkService.swift
//  MVVM-Subjects-Observables
//
//  Created by alex on 14/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol Networkable {
    var provider: MoyaProvider<WeatherAPI> { get }
    func getCurrentWeather(city name: String) -> Observable<CurrentWeather>
}

struct NetworkService: Networkable {
    var provider = MoyaProvider<WeatherAPI>() //(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func getCurrentWeather(city name: String) -> Observable<CurrentWeather> {
        return provider.rx
            .request(.currentWeather(cityName: name))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(CurrentWeather.self)
            .asObservable()
    }
}
