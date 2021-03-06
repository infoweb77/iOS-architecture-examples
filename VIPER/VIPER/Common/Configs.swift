//
//  Configs.swift
//  VIPER
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

struct Configs {
    
    struct App {
        static var myApiKey = "bcea494556c8601713e4a88fae8fe324"
    }
    
    struct Network {
        static let loggingEnabled = false
        static let apiBaseUrl = "http://api.openweathermap.org/data/2.5"
        static let iconBaseUrl = "http://openweathermap.org/img/wn/"
    }
    
    struct Path {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        static let Tmp = NSTemporaryDirectory()
    }
}
