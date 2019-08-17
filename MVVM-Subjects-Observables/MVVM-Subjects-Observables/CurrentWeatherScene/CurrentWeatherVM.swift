//
//  WeatherViewModel.swift
//  MVVM-Subjects-Observables
//
//  Created by alex on 14/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import RxSwift
import RxCocoa

final class CurrentWeatherVM {
    // inputs
    let viewWillAppearSubject = PublishSubject<Void>()
    let newCitySubject = BehaviorSubject(value: "")
    
    // outputs
    var loading: Driver<Bool>
    var currentWeather: Driver<CurrentWeather>
    
    private let networkService: NetworkService
    
    init(service: NetworkService) {
        networkService = service
        
        let loading = ActivityIndicator()
        self.loading = loading.asDriver()
        
        let initialCity = viewWillAppearSubject
            .asObservable()
            .flatMap { _ in
                service
                    .getCurrentWeather(city: "Moscow")
                    .trackActivity(loading)
            }
            .asDriver(onErrorJustReturn: CurrentWeather.empty)
        
        let newCity = newCitySubject
            .asObservable()
            .filter { $0.count > 2 }
            .throttle(1.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { name in
                service
                    .getCurrentWeather(city: name)
                    .trackActivity(loading)
            }
            .asDriver(onErrorJustReturn: CurrentWeather.empty)
        
        currentWeather = Driver.merge(initialCity, newCity)
    }
}
