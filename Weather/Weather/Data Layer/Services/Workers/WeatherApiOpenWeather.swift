//  API
//  WeatherApiOpenWeather.swift
//  Weather
//
//  Created by Eddy R on 07/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation
protocol WeatherApiOpenWeatherProtocol {
    func getTemp() -> Float
}
class WeatherApiOpenWeather : WeatherApiOpenWeatherProtocol {
    func getTemp() -> Float{
        return 32.5
    }
}
