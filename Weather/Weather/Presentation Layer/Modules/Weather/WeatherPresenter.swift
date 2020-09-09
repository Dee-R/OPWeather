//  PRESENTER
//  WeatherPresenter.swift
//  Weather
//
//  Created by Eddy R on 07/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation
protocol WeatherPresenterProtocol {
    func interactor(_ interactor: WeatherInteractorProtocol, didRetrieveTemp: WeatherEntity)
}
class WeatherPresenter {
    weak var view: WeatherViewProtocol?
}
extension WeatherPresenter: WeatherPresenterProtocol {
    func interactor(_ : WeatherInteractorProtocol, didRetrieveTemp object: WeatherEntity) {
        let tempFormated = "\(object.temp)°C"
        let nameFormated = object.name
        
        let weatherViewModel =  WeatherViewModel(temp: tempFormated, name: nameFormated)
        self.view?.setViewWith(self, weatherViewModel: weatherViewModel)
    }
}

// Presenter Structure
struct WeatherViewModel {
    let temp: String
    let name: String
}
