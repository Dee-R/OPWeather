//
//  ConversionWorker.swift
//  Weather
//
//  Created by Eddy R on 14/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation
import UIKit


class ConversionWorker {
    
    
    enum ColorCondition: RawRepresentable {
        //01
        typealias RawValue = UIColor
        //02
        case sunny
        //04
        init?(rawValue: UIColor) {
            switch rawValue {
                default:
                    return nil
            }
        }
        
        // 03
        var rawValue: UIColor {
            switch self {
                case .sunny:
                    return UIColor.rgb(red: 129, green: 207, blue: 213)
            }
        }
  
    }
    
    static func weatherCodeToPicture(conditionCode: Int?) -> (String, UIColor) {
        guard let code = conditionCode else {
            return ("?", UIColor.red)
        }
        switch code {
            case let x where (x == 800):
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
            default:
                return ("",UIColor.green)
        }
    }
    
    
    /// convert kelvin to celsuis
    /// - Parameter temp: temperature
    /// - Returns: temperatur in celsuis
    static func tempToCelsuis(_ temp: Float) -> Float{
        return roundf(temp - 273.15)
    }
    
    
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
}
