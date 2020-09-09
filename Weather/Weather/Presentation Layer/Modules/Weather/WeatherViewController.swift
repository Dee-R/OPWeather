//  VC
//  WeatherViewController.swift
//  Weather
//
//  Created by Eddy R on 07/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.

import Foundation
import UIKit

protocol WeatherViewProtocol: class {
    func setViewWith(_:WeatherPresenterProtocol, weatherViewModel: WeatherViewModel)
}
class WeatherViewController: UIViewController {
    // MARK: - 🉑 Setting
    // VIP
    var interactor: WeatherInteractorProtocol?
    var presenter: WeatherPresenterProtocol?
    var router: WeatherRouterProtocol?
    
    // UI
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    // Location
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        self.interactor?.startServiceLocation()
    }
    
    // MARK: - configuration
    func configNavigationController() {
        self.navigationController!.navigationBar.isHidden = true
    }
    func configRequestForLocation() {
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.requestAlwaysAuthorization()
    }
}
extension WeatherViewController: WeatherViewProtocol {
    func setViewWith(_: WeatherPresenterProtocol, weatherViewModel object: WeatherViewModel) {
        self.tempLabel.text = object.temp
        self.cityLabel.text = object.name
    }
}
