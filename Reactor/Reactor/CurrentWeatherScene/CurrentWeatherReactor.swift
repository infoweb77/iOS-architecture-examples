//
//  WeatherReactor.swift
//  Reactor
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import RxSwift
import ReactorKit

final class CurrentWeatherReactor: Reactor {
    enum Action {
        case ready
        case newCity(name: String)
    }
    
    enum Mutation {
        case indicator(start: Bool)
        case fetchEnded(weather: CurrentWeather)
    }
    
    struct State {
        var loading: Bool
        var currentWeather: CurrentWeather
    }
    
    struct Dependencies {
        let network: NetworkService
    }
    
    private let dependencies: Dependencies
    let initialState: CurrentWeatherReactor.State
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.initialState = State(loading: false, currentWeather: CurrentWeather.empty)
    }
    
    func mutate(action: CurrentWeatherReactor.Action) -> Observable<CurrentWeatherReactor.Mutation> {
        switch action {
        case .ready:
            return self.getWeather(city: "Moscow")
        case .newCity(let name):
            guard name.count > 2 else { return Observable.empty() }
            return self.getWeather(city: name)
        }
    }
    
    private func getWeather(city name: String) -> Observable<Mutation> {
        
        let weatherObservable: Observable<Mutation> = dependencies.network
            .getCurrentWeather(city: name)
            .map {
                Mutation.fetchEnded(weather: $0)
            }
        
        return Observable<CurrentWeatherReactor.Mutation>.concat(
            Observable.just(Mutation.indicator(start: true)),
            weatherObservable,
            Observable.just(Mutation.indicator(start: false))
        )
    }
    
    func reduce(state: CurrentWeatherReactor.State, mutation: CurrentWeatherReactor.Mutation) -> CurrentWeatherReactor.State {
        var state = state
        switch mutation {
        case .indicator(let start):
            state.loading = start
        case .fetchEnded(let weather):
            state.currentWeather = weather
        }
        return state
    }
}
