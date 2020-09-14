//  INTERACTOR
//  WeatherInteractor.swift

import Foundation
import UIKit
import CoreLocation

protocol WeatherInteractorProtocol {
    func viewDidLoad()
    func startServiceLocation()
}

class WeatherInteractor: NSObject {
    // MARK: - 🉑 VIP
    var presenter: WeatherPresenterProtocol?
    let weatherService = WeatherApiOpenWeather()
    private var temp: Float = 0// weather var
    private var serviceLocation: ServiceLocation
    
    override init() {
        self.serviceLocation = ServiceLocation()
        super.init()
        self.serviceLocation.delegate = self
    }
}

extension WeatherInteractor: WeatherInteractorProtocol {
    func viewDidLoad() {
        self.startServiceLocation()
        self.getTime()
    }
    func startServiceLocation() {
        serviceLocation.getLocation() // use service to get location and call back some method with the delegate
    }
    func getTime() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .full
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let dateString = dateFormatter.string(from: currentDate) //14 September 2020
        self.presenter?.interactor(self, DidGetCurrentTime: dateString)
    }
}

/** manage call back for the location. */
extension WeatherInteractor: ServiceLocationDelegate {
    func serviceLocation(_: CLLocationManager, didGetLocationByCoordinate coordinates: CLLocationCoordinate2D) {
        print("██░░░ -- L\(#line) \(#function) ⭐️⭐️ did get location : \(coordinates) ⭐️⭐️\n")
        //Reflexion🏙🏝 👾👯‍♀️👙🙍🏻‍♀️👄😺🏖🏞  get weather
//        let EtrechyGPS = CLLocationCoordinate2D(latitude: 48.5, longitude: 2.2)

        weatherService.getDataWeatherByLatAndLon(coordinates : coordinates) { (weatherDict) in
            print("  💟",weatherDict,"💟")
            // temperature
            guard let temp = weatherDict["temp"] as? Float else { fatalError("temperature is optionnal")}
            let temperature = ConversionWorker.tempToCelsuis(temp)
            // city
            guard let city = weatherDict["city"] as? String else { fatalError(" city is optionnal") }
            let idWeatherCode = weatherDict["idWeather"] as? Int
            let weatherCondition = ConversionWorker.weatherCodeToPicture(conditionCode: idWeatherCode)
            
            
            let weatherEntity = WeatherEntity(temp: temperature, name: city, weatherCondition: weatherCondition)
            
            DispatchQueue.main.async {
                self.presenter?.interactor(self, didRetrieveTemp: weatherEntity)
            }
        }
        // MARK: -
        // TODO: Need to refactor that name of function
        // MARK: -
        self.presenter?.interactor(self, DidFailedConnectionLocalization: UIColor.white) // not failed
    }
    
    
    func serviceLocation(_: CLLocationManager, didFailWithErrorToGetLocation: Error) {
        // MARK: -
        // TODO: Gere le cas il Service location n'arrive pas trouver une position
        // MARK: -
        print("Localization Status : Failed ")
        print("Gere le cas il Service location n'arrive pas trouver une position")
        
        self.presenter?.interactor(self, DidFailedConnectionLocalization: UIColor.red)
    }
}


// sun.max
// cloud
// cloud.sun

