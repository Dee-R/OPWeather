//
//  ServiceLocation.swift

import Foundation
import CoreLocation

protocol ServiceLocationDelegate {
    func serviceLocation(_ : CLLocationManager, didGetLocationByCoordinate: CLLocationCoordinate2D )
    func serviceLocation(_ : CLLocationManager, didFailWithErrorToGetLocation: Error )
}

class ServiceLocation : NSObject{
    private var locationManager: CLLocationManager = CLLocationManager()
    var delegate: ServiceLocationDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    func getLocation() {
        //Reflexion🏙🏝 👾👯‍♀️👙🙍🏻‍♀️👄😺🏖🏞  renvoyer une erreur si pas de location
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
}

extension ServiceLocation :  CLLocationManagerDelegate {
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        delegate?.serviceLocation(manager, didGetLocationByCoordinate: coordinate)
        print("██░░░ -- L\(#line) \(#function) ⭐️⭐️ \(coordinate) ⭐️⭐️\n")
    }
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.serviceLocation(manager, didFailWithErrorToGetLocation: error )
        print("██░░░ -- L\(#line) \(#function) ⭐️⭐️ error : \(error.localizedDescription) ⭐️⭐️\n")
    }
}
