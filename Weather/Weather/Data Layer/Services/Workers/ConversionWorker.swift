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
        case sunny, snowy, cloudy, rainy, thunderstormy, misty, none
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
                case .snowy:
                    return UIColor.rgb(red: 132, green: 0, blue: 181)
                case .cloudy:
                    return UIColor.rgb(red: 237, green: 102, blue: 99)
                case .rainy:
                    return UIColor.rgb(red: 16, green: 124, blue: 255)
                case .thunderstormy:
                    return UIColor.rgb(red: 252, green: 66, blue: 100)
                case .misty:
                    return UIColor.rgb(red: 0, green: 45, blue: 51)
                case .none:
                    return UIColor.rgb(red: 1, green: 147, blue: 168)
            }
        }
  
    }
    
    static func weatherCodeToPicture(conditionCode: Int?) -> (String, UIColor) {
        guard let code = conditionCode else {
            return ("", ConversionWorker.ColorCondition.none.rawValue)
        }

        
        switch code {
            case let x where (x >= 200 && x <= 202) || (x >= 230 && x <= 232):
                return ("thunderstormy",ConversionWorker.ColorCondition.thunderstormy.rawValue)
//                return "⛈"
            case let x where x >= 210 && x <= 211:
                return ("thunderstormy",ConversionWorker.ColorCondition.thunderstormy.rawValue)
//                return "🌩"
            case let x where x >= 212 && x <= 221:
                return ("thunderstormy",ConversionWorker.ColorCondition.thunderstormy.rawValue)
//                return "⚡️"
            case let x where x >= 300 && x <= 321:
                return ("misty",ConversionWorker.ColorCondition.misty.rawValue)
//                return "🌦"
            case let x where x >= 500 && x <= 531:
                return ("rainy",ConversionWorker.ColorCondition.rainy.rawValue)
//                return "🌧"
            case let x where x >= 600 && x <= 602:
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
//                return "☃️"
            case let x where x >= 603 && x <= 622:
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
//                return "🌨"
            case let x where x >= 701 && x <= 771:
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
//                return "🌫"
            case let x where x == 781 || x == 900:
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
//                return "🌪"
            case let x where x == 800:
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
//                return isDayTime ? "☀️" : "🌕"
            case let x where x == 801:
                return ("cloudy",ConversionWorker.ColorCondition.cloudy.rawValue)
//                return "🌤"
            case let x where x == 802:
                return ("cloudy",ConversionWorker.ColorCondition.cloudy.rawValue)
//                return "⛅️"
            case let x where x == 803:
                return ("cloudy",ConversionWorker.ColorCondition.cloudy.rawValue)
//                return "🌥"
            case let x where x == 804:
                return ("cloudy",ConversionWorker.ColorCondition.cloudy.rawValue)
//                return "☁️"
            case let x where x >= 952 && x <= 956 || x == 905:
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
//                return "🌬"
            case let x where x >= 957 && x <= 961 || x == 771:
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
//                return "💨"
            case let x where x == 901 || x == 902 || x == 962:
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
//                return "🌀"
            case let x where x == 903:
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
//                return "❄️"
            case let x where x == 904:
                return ("snowy",ConversionWorker.ColorCondition.snowy.rawValue)
//                return "🌡"
            case let x where x == 962:
                return ("sunny",ConversionWorker.ColorCondition.sunny.rawValue)
//                return "🌋"
            default:
                return ("",ConversionWorker.ColorCondition.none.rawValue)
//                return "❓"
        }
        
    }
    
    
    /// convert kelvin to celsuis
    /// - Parameter temp: temperature
    /// - Returns: temperatur in celsuis
    static func tempToCelsuis(_ temp: Float) -> Float{
        return roundf(temp - 273.15)
    }
    
    static func date(_ t: Int ) -> String? {
//        var calendar = Calendar.current
        //            let currentTimeDateComponents = calendar.dateComponents([.hour, .minute, .second], from: Date())
        let heureSunerise = Date(timeIntervalSince1970: TimeInterval(t))
        
        let tFormated = DateFormatter()
        tFormated.defaultDate = heureSunerise
//        tFormated.dateFormat = "HH:MM:ss"
        tFormated.dateFormat = "HH:MM"
        return tFormated.string(from: heureSunerise)
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}





/**
 
 switch code {
 case let x where (x >= 200 && x <= 202) || (x >= 230 && x <= 232):
 return "⛈"
 case let x where x >= 210 && x <= 211:
 return "🌩"
 case let x where x >= 212 && x <= 221:
 return "⚡️"
 case let x where x >= 300 && x <= 321:
 return "🌦"
 case let x where x >= 500 && x <= 531:
 return "🌧"
 case let x where x >= 600 && x <= 602:
 return "☃️"
 case let x where x >= 603 && x <= 622:
 return "🌨"
 case let x where x >= 701 && x <= 771:
 return "🌫"
 case let x where x == 781 || x == 900:
 return "🌪"
 case let x where x == 800:
 return isDayTime ? "☀️" : "🌕"
 case let x where x == 801:
 return "🌤"
 case let x where x == 802:
 return "⛅️"
 case let x where x == 803:
 return "🌥"
 case let x where x == 804:
 return "☁️"
 case let x where x >= 952 && x <= 956 || x == 905:
 return "🌬"
 case let x where x >= 957 && x <= 961 || x == 771:
 return "💨"
 case let x where x == 901 || x == 902 || x == 962:
 return "🌀"
 case let x where x == 903:
 return "❄️"
 case let x where x == 904:
 return "🌡"
 case let x where x == 962:
 return "🌋"
 default:
 return "❓"
 }
 */
