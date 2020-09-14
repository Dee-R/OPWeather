//
//  ConversionWorker.swift
//  Weather
//
//  Created by Eddy R on 14/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation

final class ConversionWorker {
    static func weatherCodeToPicture(conditionCode: Int?) -> String {
        guard let code = conditionCode else {
            return "?"
        }
        switch code {
            case let x where (x >= 200 && x <= 230) || (x >= 230 && x <= 232):
                return "Cloudy"
            case let x where (x == 800):
                return "sunny"
            default:
            return "?"
        }
    }
    
    
    /// convert kelvin to celsuis
    /// - Parameter temp: temperature
    /// - Returns: temperatur in celsuis
    static func tempToCelsuis(_ temp: Float) -> Float{
        return roundf(temp - 273.15)
    }
}
