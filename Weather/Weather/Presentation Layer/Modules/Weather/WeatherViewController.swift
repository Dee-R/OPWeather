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
    func setViewCacheOffLocationForAnimation(animated: Bool )
    
    
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
    @IBOutlet weak var conditionImageConstraintCenter: NSLayoutConstraint!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cacheOffLocationView: UIView!
    
    // Location
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationController()
        self.interactor?.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // set animation before view will appear
        self.conditionImageConstraintCenter.constant -= view.bounds.width + conditionImage.bounds.width / 2
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        self.view.layoutIfNeeded()
        // launch the animation
        AnimationFactory.slideUpToTheRight(mainView: self.view, view: conditionImage, constant: conditionImageConstraintCenter).startAnimation()
        AnimationFactory.scaleUpandDown(view: conditionImage)
        
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
        print("██░░░ L\(#line) 🚧🚧 click button location 🚧🚧",String(describing: self) ,#function)
        positionButton.tintColor = UIColor.gray
        self.interactor?.startServiceLocation()
    }
    @IBAction func actionChangeCity(_ sender: UIButton) {
        print("██░░░ L\(#line) 🚧🚧📐 \(String(describing: self)) 🚧\(#function)🚧 ")
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
        self.descriptionLabel.text = object.description
    }
    func setViewPositionWith(color: UIColor) {
        self.positionButton.tintColor = color
    }
    func setViewTimeWith(time: String) {
        dateLabel.text = time
    }
    func setViewCacheOffLocationForAnimation(animated: Bool) {
        print("██░░░ L\(#line) 🚧🚧📐 \(String(describing: self)) 🚧\(#function)🚧 ")
//        // animation
//        cacheOffLocationView.isHidden = false
        let hideView = UIViewPropertyAnimator(duration: 0.3, curve: .linear)
        hideView.addAnimations ({
            self.cacheOffLocationView.isHidden = false
            self.cacheOffLocationView.alpha = 0
        }, delayFactor: 1)
        hideView.startAnimation()
    }
}


// --
