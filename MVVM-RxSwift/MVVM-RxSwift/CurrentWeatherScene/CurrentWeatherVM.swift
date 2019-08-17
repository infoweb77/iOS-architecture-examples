//
//  WeatherViewModel.swift
//  MVVM-RxSwift
//
//  Created by alex on 10/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import RxSwift
import RxCocoa

final class CurrentWeatherVM{
    struct Input {
        let ready: Driver<Void>
        let newCity: Driver<String>
    }
    
    struct Output {
        let loading: Driver<Bool>
        let currentWeather: Driver<CurrentWeather>
    }
    
    struct Dependencies {
        let networkService: NetworkService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        
        let initialCity = input.ready
            .flatMap { _ in
                self.dependencies.networkService
                    .getCurrentWeather(city: "Moscow")
                    .trackActivity(loading)
                    .asDriver(onErrorJustReturn: CurrentWeather.empty)
        }
        
        let newCity = input.newCity
            .filter { $0.count > 2 }
            .throttle(1.5)
            .distinctUntilChanged()
            .flatMapLatest { cityName in
                self.dependencies.networkService
                    .getCurrentWeather(city: cityName)
                    .trackActivity(loading)
                    .asDriver(onErrorJustReturn: CurrentWeather.empty)
        }
        
        let currentWeather = Driver.merge(initialCity, newCity)
        
        return Output(loading: loading.asDriver(), currentWeather: currentWeather)
    }
}
