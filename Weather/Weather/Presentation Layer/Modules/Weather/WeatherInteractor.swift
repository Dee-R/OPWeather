//  INTERACTOR
//  WeatherInteractor.swift

import Foundation
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
//        self.serviceLocation.delegate = self
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
    }
    
    func serviceLocation(_: CLLocationManager, didFailWithErrorToGetLocation: Error) {
        // MARK: -
        // TODO: Gere le cas il Service location n'arrive pas trouver une position
        // MARK: -
        print("Gere le cas il Service location n'arrive pas trouver une position")
    }
}

