//
//  CurrentCityWeather.swift
//  VIPER
//
//  Created by alex on 13/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    
    let id: Int
    let name: String
    
    static let empty = CurrentWeather(
        coord: Coord(lon: 0.0, lat: 0.0),
        weather: [Weather(description: "", icon: "")],
        main: Main(temp: 0.0, pressure: 0.0, humidity: 0),
        wind: Wind(speed: 0.0, deg: nil),
        clouds: Clouds(all: 0),
        sys: Sys(country: "", sunrise: Date(), sunset: Date()),
        id: 0, name: ""
    )
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Double?
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let country: String
    let sunrise: Date
    let sunset : Date
}
