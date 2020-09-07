//
//  WeatherBuilder.swift
//  Weather
//
//  Created by Eddy R on 07/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation
class WeatherBuilder {
    class func buildModule(arroundView view: WeatherViewController) {
        // MARK: - init component
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        
        // VIP cycle
        view.interactor = interactor // view knows interactor
        view.router = WeatherRouter() // view knows router
        
        interactor.presenter = presenter
        
        presenter.view = view
        
    }
}
