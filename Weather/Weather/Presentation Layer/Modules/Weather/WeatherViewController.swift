//  VM
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
    var interactor: WeatherInteractorProtocol?
    var presenter: WeatherPresenterProtocol?
    var router: WeatherRouterProtocol?
    
    // UI
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        print("\(#line) ▓▓▓▓▓▓▓▓ ( ˘ ³˘)♥ ▓▓▓▓▓▓▓▓ \(String(describing: self)) => func \(#function)")
        super.viewDidLoad()
        self.navigationController!.navigationBar.isHidden = true
        self.interactor?.viewDidLoad()
    }
}
extension WeatherViewController: WeatherViewProtocol {
    func setViewWith(_: WeatherPresenterProtocol, weatherViewModel object: WeatherViewModel) {
        self.tempLabel.text = object.temp
    }
}
