//
//  WeatherRouter.swift
//  Weather
//
//  Created by Eddy R on 07/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import UIKit
protocol WeatherRouterProtocol{
    var navigationController: UINavigationController? { get }
    func routeToSearch()
}

class WeatherRouter : WeatherRouterProtocol{
    var navigationController: UINavigationController?
    
    //func routeToSearch(with id: String) pass data if needed in the protocol
    func routeToSearch() {
        let searchViewController = SearchViewController()
        SearchBuilder.buildModule(arroundView: searchViewController)
        navigationController?.pushViewController(searchViewController, animated: true)
//        navigationController?.present(searchViewController, animated: true, completion: nil)
        
    }
}

