//
//  ViewController.swift
//  Reactor
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import ReactorKit
import Nuke

final class CurrentWeatherVC: UIViewController, View {
    
    let searchController = UISearchController(searchResultsController: nil)
    var disposeBag = DisposeBag()
    
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
    }
    
    func bind(reactor: CurrentWeatherReactor) {
        // states
        reactor.state.map { $0.loading }
            .distinctUntilChanged()
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.currentWeather }
            .subscribe(onNext: { [weak self] weather in
                guard let sSelf = self else { return }
                sSelf.updateUI(weather)
            })
            .disposed(by: disposeBag)
        
        // actions
        rx.viewWillAppear
            .map { CurrentWeatherReactor.Action.ready }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.orEmpty
            .throttle(1.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { CurrentWeatherReactor.Action.newCity(name: $0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
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
            Nuke.loadImage(with: url, into: icon)
        }
    }
}
