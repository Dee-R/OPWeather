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
    func setViewTimeWith(time: String)
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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    // Location
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        self.interactor?.viewDidLoad()
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
        self.tempLabel.text = object.temp // temperature
        self.cityLabel.text = object.name // City
        self.view.backgroundColor = object.weatherCondition.1 // color Condition
        self.conditionImage.image = UIImage(named: object.weatherCondition.0) // image Conditino
        self.tempMaxLabel.text = object.tempMax
        self.sunriseLabel.text = object.sunrise
        self.sunsetLabel.text = object.sunset
        
    }
    func setViewPositionWith(color: UIColor) {
        self.positionButton.tintColor = color
    }
    func setViewTimeWith(time: String) {
        dateLabel.text = time
    }
}


// --
