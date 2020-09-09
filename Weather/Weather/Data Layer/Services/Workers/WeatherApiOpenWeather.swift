//  API
//  WeatherApiOpenWeather.swift
//  Weather
//
//  Created by Eddy R on 07/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

protocol WeatherApiOpenWeatherProtocol {
    func getDataWeather( completion: @escaping (WeatherEntity)->() )
}
struct WeatherApiOpenWeather : WeatherApiOpenWeatherProtocol {
    // manage request for
    fileprivate let urlPath = "http://api.openweathermap.org/data/2.5/weather?q=paris&appid=ea95f1643b48eebf14e1ec6b10f3ea62"
    fileprivate func requestUrlByCity() -> URL? {
        guard var components = URLComponents(string:urlPath) else { fatalError("need to configurate an url")}
        let appId = getTokenID()
        components.queryItems = [
            URLQueryItem(name:"q", value:"paris"),
            URLQueryItem(name:"appid", value:appId),
        ]
        //        print("🌟 \(components.url) 🌟")
        return components.url
    }
    fileprivate func getTokenID() -> String{
        // access to TokenId for api Open Weather
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")
        guard let filePathok = filePath else { fatalError("do not have access to Info.plist") }
        let parameters = NSDictionary(contentsOfFile: filePathok)
        guard let params = parameters  else { fatalError("do not have access to parameters from")}
        let appId = params["OpenWeatherAppId"] as! String //ea95f1643b48eebf14e1ec6b10f3ea62
        return appId
    }
    
    // Data Crud
    func getDataWeather(completion:@escaping(WeatherEntity)->()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        guard let url = requestUrlByCity() else { fatalError("url no provided") }
        let task = session.dataTask(with: url) { (data, response, error)  in
            guard let data = data else { fatalError("json Serialization failed")}
            guard let json = try? JSON(data: data) else { fatalError("no data")}
            
            guard let temp = json["main"]["temp"].float,
                let name = json["name"].string else { fatalError("impossible to fetch key in json object")}
            
            let realTemp = roundf(temp - 273.15) // Kelvin to celsius
            
            // send
            let entity = WeatherEntity(temp: realTemp, name: name)
            completion(entity)
        }
        task.resume()
    }
    
    
    
}
