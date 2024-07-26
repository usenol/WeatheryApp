//
//  WeatherService.swift
//  WeatheryApp
//
//  Created by Umut Şenol on 25.07.2024.
//

import Foundation

struct Weather {
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%0.f", temperature)
    }
}

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(_ weatherService: WeatherService, weather: Weather)
}

struct WeatherService {
    
    weak var delegate: WeatherServiceDelegate?
    
    func fetchWeather(cityName: String) {
        let weather = Weather(cityName: "Hong Kong", temperature: 33)
        delegate?.didFetchWeather(self, weather: weather)
    }
}
