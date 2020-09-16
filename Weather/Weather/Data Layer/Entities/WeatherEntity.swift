//
//  WeatherEntity.swift
//  Weather
//
//  Created by Eddy R on 07/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation
import UIKit

struct WeatherEntity {
    let temp: Float
    let name: String
    let weatherCondition: (String, UIColor)
    let tempMax: Float
    let sunrise: String
    let sunset: String
    let description: String
}
