//  INTERACTOR
//  WeatherInteractor.swift

import Foundation
import UIKit
import CoreLocation

protocol WeatherInteractorProtocol {
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
    func startServiceLocation() {
        print("██░░░ -- L\(#line) \(#function) ⭐️⭐️ service location ⭐️⭐️\n")
        serviceLocation.getLocation() // use service to get location and call back some method with the delegate
    }
}

/** manage call back for the location. */
extension WeatherInteractor: ServiceLocationDelegate {
    func serviceLocation(_: CLLocationManager, didGetLocationByCoordinate: CLLocationCoordinate2D) {
        print("██░░░ -- L\(#line) \(#function) ⭐️⭐️ did get location : \(didGetLocationByCoordinate) ⭐️⭐️\n")
        //Reflexion🏙🏝 👾👯‍♀️👙🙍🏻‍♀️👄😺🏖🏞  get weather
        let EtrechyGPS = CLLocationCoordinate2D(latitude: 48.5, longitude: 2.2)
//        weatherService.getDataWeatherByLatAndLon(coordinates : didGetLocationByCoordinate) { (WeatherEntity) in
//            print("  💟",WeatherEntity,"💟")
//        }
        weatherService.getDataWeatherByLatAndLon(coordinates : EtrechyGPS) { (weatherEntity) in
            print("██░░░ -- L\(#line) \(#function) ⭐️⭐️ \(weatherEntity) ⭐️⭐️\n")
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

