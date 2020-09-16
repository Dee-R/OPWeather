//  PRESENTER
//  WeatherPresenter.swift
//  Weather
//
//  Created by Eddy R on 07/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherPresenterProtocol {
    func interactor(_ interactor: WeatherInteractorProtocol, didRetrieveTemp: WeatherEntity)
    func interactor(_ interactor: WeatherInteractorProtocol, DidFailedConnectionLocalization: UIColor)
    func interactor(_ interactor: WeatherInteractorProtocol, DidSuccessConnectionLocalization: UIColor)
    func interactor(_ interactor: WeatherInteractorProtocol, DidGetCurrentTime: String)
}
class WeatherPresenter {
    weak var view: WeatherViewProtocol?
}
extension WeatherPresenter: WeatherPresenterProtocol {
    func interactor(_ : WeatherInteractorProtocol, didRetrieveTemp object: WeatherEntity) {
        let tempFormated = "\(object.temp)°C"
        let tempMaxFormated = "\(object.tempMax)°C"
        let descriptionFormated = "\(object.weatherCondition2.icon) \(object.description)"
        
        let weatherViewModel =  WeatherViewModel(temp: tempFormated, name: object.name, weatherCondition: object.weatherCondition, tempMax: tempMaxFormated, sunrise: object.sunrise, sunset: object.sunset, description: descriptionFormated)
        self.view?.setViewWith(self, weatherViewModel: weatherViewModel)
    }
    func interactor(_ interactor: WeatherInteractorProtocol, DidSuccessConnectionLocalization color: UIColor) {
        self.view?.setViewPositionWith(color: color)
    }
    func interactor(_ interactor: WeatherInteractorProtocol, DidFailedConnectionLocalization color: UIColor) {
        self.view?.setViewPositionWith(color: color)
    }
    func interactor(_ interactor: WeatherInteractorProtocol, DidGetCurrentTime currentTime: String) {
        self.view?.setViewTimeWith(time: currentTime)
    }
}

// Presenter Structure
struct WeatherViewModel {
    let temp: String
    let name: String
    let weatherCondition:(String, UIColor)
    let tempMax: String
    let sunrise: String
    let sunset: String
    let description: String
}
