//
//  SearchConfigurator.swift
//  Weather
//
//  Created by Eddy R on 17/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation
class SearchBuilder {
    static func buildModule(arroundView view: SearchViewController) {
        let searchViewController = view
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        
        // cycle
        view.router = router
        view.interactor = interactor
        
        
        interactor.presenter = presenter
        presenter.view = searchViewController
    }
}
