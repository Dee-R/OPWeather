//  INTERACTOR
//  WeatherInteractor.swift
//  Weather
//
//  Created by Eddy R on 07/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation
protocol WeatherInteractorProtocol {
    func viewDidLoad()
}
class WeatherInteractor {
    // MARK: - 🉑 VIP
    var presenter: WeatherPresenterProtocol?
    let weatherService = WeatherApiOpenWeather()
    
    // weather var
    private var temp: Float = 0
}

extension WeatherInteractor: WeatherInteractorProtocol {
    func viewDidLoad() {
        self.temp = weatherService.getTemp() // call service
        
        let entity = WeatherEntity(temp: temp) // structure the data
        
        self.presenter?.interactor(self, didRetrieveTemp: entity) // call back presenter
    }
}
