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
    func setViewPositionWith(color: UIColor)
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
    @IBOutlet weak var positionButton: UIButton!
    
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
    
    // MARK: - ACTION
    @IBAction func actionPositionButton(_ sender: UIButton) {
        positionButton.tintColor = UIColor.gray
        self.interactor?.startServiceLocation()
    }
    
    
    
}
extension WeatherViewController: WeatherViewProtocol {
    func setViewWith(_: WeatherPresenterProtocol, weatherViewModel object: WeatherViewModel) {
        self.tempLabel.text = object.temp
        self.cityLabel.text = object.name
    }
    
    func setViewPositionWith(color: UIColor) {
        self.positionButton.tintColor = color
    }
}
