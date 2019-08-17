//
//  ViewController.swift
//  MVC
//
//  Created by alex on 17/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class CurrentWeatherVC: UIViewController {
    
    private let service = NetworkService()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let validator = ThrottledTextFieldValidator()
    
    // views
    private let tempLabel = ComponentLabel(props: .font(.normal, .custom(56)), .center)
    private let descrLabel = ComponentLabel(props: .font(.normal, .custom(42)), .center)
    private let nameLabel = ComponentLabel(props: .font(.bold, .custom(48)), .center)
    
    private let icon = UIImageView()


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
        startFetching(withCity: "Moscow")
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
    
    private func startFetching(withCity name: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        service.getCurrentWeather(city: name) { [weak self] weather in
            guard let sSelf = self else { return }
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                sSelf.updateUI(weather)
            }
        }
    }
    
    private func didChangeCity(_ city: String) {
        validator.validate(query: city) { [weak self] city in
            guard let sSelf = self, let city = city else { return }
            sSelf.startFetching(withCity: city)
        }
    }
}

extension CurrentWeatherVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        didChangeCity(searchController.searchBar.text ?? "")
    }
}
