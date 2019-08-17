//
//  ViewController.swift
//  MVVM-Subjects-Observables
//
//  Created by alex on 14/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher

final class CurrentWeatherVC: UIViewController {
    
    var viewModel: CurrentWeatherVM!
    private let disposeBag = DisposeBag()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // views
    private let tempLabel = ComponentLabel(props: .font(.normal, .custom(56)), .center)
    private let descrLabel = ComponentLabel(props: .font(.normal, .custom(42)), .center)
    private let nameLabel = ComponentLabel(props: .font(.bold, .custom(48)), .center)
    
    private let icon = UIImageView()
    
    
    init(model: CurrentWeatherVM) {
        super.init(nibName: nil, bundle: nil)
        viewModel = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = nil
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        
        setupUI()
        bindViewModel()
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
            let url = URL(string: Configs.Network.iconUrl + "\(name)@2x.png")!
            icon.kf.setImage(with: url)
        }
    }
    
    private func bindViewModel() {
        // bind
        rx.viewVillAppear
            .asObservable()
            .bind(to: viewModel.viewWillAppearSubject)
            .disposed(by: disposeBag)
        
        searchController.searchBar.rx.text.orEmpty
            .asObservable()
            .bind(to: viewModel.newCitySubject)
            .disposed(by: disposeBag)
        
        // drive
        viewModel.currentWeather
            .drive(onNext: { [weak self] weather in
                guard let sSelf = self else { return }
                sSelf.updateUI(weather)
            })
            .disposed(by: disposeBag)
        
        viewModel.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
    }
}

