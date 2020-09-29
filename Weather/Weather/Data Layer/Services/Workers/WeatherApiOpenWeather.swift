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
//    func getDataWeatherByCity( completion: @escaping (WeatherDecodable)->() )
    func getDataWeatherByLatAndLon(coordinates: CLLocationCoordinate2D, completion:@escaping(Dictionary<String, Any>)->())
}
struct WeatherApiOpenWeather : WeatherApiOpenWeatherProtocol {
    // manage request for
    fileprivate let urlPath = "http://api.openweathermap.org/data/2.5/weather?q=paris&appid=ea95f1643b48eebf14e1ec6b10f3ea62"
    fileprivate func requestUrlByCity(city:String) -> URL? {
        guard var components = URLComponents(string:urlPath) else { fatalError("need to configurate an url")}
        let appId = getTokenID()
        components.queryItems = [
            URLQueryItem(name:"q", value: city),
            URLQueryItem(name:"appid", value:appId),
        ]
        //        print("🌟 \(components.url) 🌟")
        return components.url
    }
    fileprivate func requestUrlByLontitudeAndLatitude(coordinates:CLLocationCoordinate2D ) -> URL? {
        //https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=439d4b804bc8187953eb36d2a8c26a02
        guard var components = URLComponents(string:urlPath) else { fatalError("need to configurate an url")}
        let appId = getTokenID()
        
        
        components.queryItems = [
            URLQueryItem(name:"lat", value: String(coordinates.latitude)),
            URLQueryItem(name:"lon", value: String(coordinates.longitude)),
            URLQueryItem(name:"appid", value:appId),
        ]
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
//    func getDataWeatherByCity(completion:@escaping(WeatherDecodable)->()) {
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//
//        guard let url = requestUrlByCity(city:"Paris") else { fatalError("url no provided") }
//
//        let task = session.dataTask(with: url) { (data, response, error)  in
//            guard let data = data else { fatalError("json Serialization failed")}
//            guard let json = try? JSON(data: data) else { fatalError("no data")}
//
//            guard let temperature = json["main"]["temp"].float,
//                let nameCity = json["name"].string else { fatalError("impossible to fetch key in json object")}
//
//            let realTemp = roundf(temperature - 273.15) // Kelvin to celsius
//
//            // send
//            let entity = WeatherDecodable(temp: realTemp, name: nameCity, idWeather: nil)
//            completion(entity)
//        }
//        task.resume()
//    }
    func getDataWeatherByLatAndLon(coordinates: CLLocationCoordinate2D, completion:@escaping(Dictionary<String, Any>)->()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard let url = requestUrlByLontitudeAndLatitude(coordinates: coordinates) else { fatalError("Status: Url creation has failed")}
        
        let task = session.dataTask(with: url) { (data, response, error)  in
            guard let data = data else { fatalError("json Serialization failed")}
            guard let json = try? JSON(data: data) else { fatalError("no data")}
            
            guard let temperature = json["main"]["temp"].float,
                  let nameCity = json["name"].string,
                  let idWeather = json["weather"][0]["id"].int,
                  let temperatureMax = json["main"]["temp_max"].float,
                  let sunriseTime = json["sys"]["sunrise"].int,
                  let sunsetTime =  json["sys"]["sunset"].int,
                  let description = json["weather"][0]["description"].string else { fatalError("impossible to fetch key in json object")}

            
            let weatherDict: [String: Any] = ["temp":temperature,
                                              "city": nameCity,
                                              "idWeather": idWeather,
                                              "temperatureMax": temperatureMax,
                                              "sunrise":sunriseTime,
                                              "sunset":sunsetTime,
                                              "description": description
            ]
            completion(weatherDict) // send back data fetched
        }
        task.resume()
    }
}
