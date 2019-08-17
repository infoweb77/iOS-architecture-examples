//
//  ViewController.swift
//  RxFeedback-MVC
//
//  Created by alex on 14/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxFeedback
import Kingfisher
import SnapKit

fileprivate struct State {
    var cityName: String
    var results: CurrentWeather
    var initialFetch: Bool
    var shouldFetch: Bool
}

extension State {
    var shouldFetchCityWeather: String? {
        guard !initialFetch else { return "Moscow" }
        return shouldFetch ? cityName : nil
    }
}

extension State {
    static var empty: State {
        return State(cityName: "", results: CurrentWeather.empty, initialFetch: true, shouldFetch: false)
    }
    
    static func reduce(state: State, event: Event) -> State {
        switch event {
        case .cityNameChanged(let name):
            var result = state
            result.cityName = name
            return result
        case .response(let weather):
            var result = state
            result.results = weather
            result.initialFetch = false
            result.shouldFetch = false
            return result
        case .shouldFetch:
            var result = state
            result.shouldFetch = true
            return result
        }
    }
}

fileprivate enum Event {
    case cityNameChanged(String)
    case response(CurrentWeather)
    case shouldFetch
}


final class CurrentWeatherVC: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let networkApi = NetworkService()
    private let disposeBag = DisposeBag()
    
    // views
    private let tempLabel = ComponentLabel(props: .font(.normal, .custom(56)), .center)
    private let descrLabel = ComponentLabel(props: .font(.normal, .custom(42)), .center)
    private let nameLabel = ComponentLabel(props: .font(.bold, .custom(48)), .center)
    
    private let icon = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = nil
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        
        setupUI()
        bindFeedbackLoop()
    }

    private func setupUI() {
        // add to view
        view.addSubviews(nameLabel, icon, tempLabel, descrLabel)
        
        // layout
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(180)
        }
        
        icon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(220)
            $0.size.equalTo(CGSize(width: 200, height: 200))
        }
        
        tempLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(420)
        }
        
        descrLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(500)
        }
    }

    private func updateUI(_ weather: CurrentWeather) {
        
        let temp = round(weather.main.temp)
        tempLabel.text = temp > 0 ? "+ \(temp)" : "- \(temp)"
        
        nameLabel.text = weather.name
        descrLabel.text = weather.weather.first?.description ?? ""
        
        
        let iconName = weather.weather.first?.icon
        if let name = iconName, name != "" {
            let url = URL(string: Configs.Network.iconBaseUrl + "\(name)@2x.png")!
            icon.kf.setImage(with: url)
        }
    }
    
    private func bindFeedbackLoop() {
        let triggerFetch: (Driver<State>) -> Signal<Event> = { state in
            return state
                .map { $0.cityName }
                .filter { $0.count > 2 }
                .throttle(1.5)
                .distinctUntilChanged()
                .asSignal(onErrorJustReturn: "")
                .map { _ in Event.shouldFetch }
        }
        
        let bindUI: (Driver<State>) -> Signal<Event> = bind(self) { me, state in
            let subscription = [
                state.map { $0.cityName }
                    .drive(me.searchController.searchBar.rx.text),
                
                state.map { $0.results }
                    .drive(onNext: { weather in
                        me.updateUI(weather)
                    }),
                
                state.map { $0.shouldFetch }
                    .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            ]
            
            let events: [Signal<Event>] = [
                
                me.searchController.searchBar.rx.text.orEmpty
                    .asSignal(onErrorJustReturn: "")
                    .map(Event.cityNameChanged),
                
                triggerFetch(state)
            ]
            
            return Bindings(subscriptions: subscription, events: events)
        }
        
        Driver.system(initialState: State.empty,
                      reduce: State.reduce,
                      feedback: bindUI,
                      react(
                        request: { $0.shouldFetchCityWeather },
                        effects: { name in
                            return self.networkApi.getCurrentWeather(city: name)
                                .asSignal(onErrorJustReturn: CurrentWeather.empty)
                                .map(Event.response)
                      })
                )
                .drive()
                .disposed(by: disposeBag)
    }
}

