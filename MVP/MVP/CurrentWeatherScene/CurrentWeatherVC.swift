//
//  ViewController.swift
//  MVP
//
//  Created by alex on 09/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit


class CurrentWeatherVC: UIViewController {
    
    private let viewModel: CurrentWeatherVM
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tempLabel = ComponentLabel(props: .font(.normal, .custom(56)), .center)
    private let descrLabel = ComponentLabel(props: .font(.normal, .custom(42)), .center)
    private let nameLabel = ComponentLabel(props: .font(.bold, .custom(48)), .center)
    
    private let icon = UIImageView()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(model: CurrentWeatherVM) {
        viewModel = model
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.ready()
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
    
    private func updateUI(_ cityWeather: CurrentWeather) {
        
        let temp = round(cityWeather.main.temp)
        tempLabel.text = temp > 0 ? "+ \(temp)" : "- \(temp)"
        
        nameLabel.text = cityWeather.name
        descrLabel.text = cityWeather.weather.first?.description ?? ""
        
        
        let iconName = cityWeather.weather.first?.icon
        if let iconUrl = iconName {
            let url = URL(string: Configs.Network.iconBaseUrl + "\(iconUrl)@2x.png")!
            icon.kf.setImage(with: url)
        }
    }
}

extension CurrentWeatherVC: WeatherViewModelDelegate {
    func isDataLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
    }
    
    func didReceiveCurrentWeather(_ weather: CurrentWeather) {
        DispatchQueue.main.async { [weak self] in
            self?.updateUI(weather)
        }
    }
}

extension CurrentWeatherVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.didChangeCity(searchController.searchBar.text ?? "")
    }
}
