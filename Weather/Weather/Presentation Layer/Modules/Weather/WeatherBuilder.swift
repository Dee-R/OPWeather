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
        
        let router = WeatherRouter()
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        
        // VIP cycle
        view.router = router
        view.interactor = interactor // view knows interactor
        
        interactor.presenter = presenter
        presenter.view = view
        
        // pass navigation Flow
        router.navigationController = view.navigationController
    }
}
