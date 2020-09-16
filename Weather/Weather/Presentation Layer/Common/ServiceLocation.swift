//
//  ServiceLocation.swift

import Foundation
import CoreLocation
import os.log

enum ManagerLocationError {
    case accessPending
    case accessDenied
    case accessAuthorizedWhenInUse
    case accessAuthorizedAlways
}

protocol ServiceLocationDelegate {
    func serviceLocation(_ : CLLocationManager, didGetLocationByCoordinate: CLLocationCoordinate2D )
    func serviceLocation(_ : CLLocationManager, didFailWithErrorToGetLocation: Error )
    
    func serviceLocationError(errorCode: ManagerLocationError)
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
        print("██░░░ L\(#line) 🚧🚧🚧🚧\n \(#function)")
        
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
        print("██░░░ -- L\(#line) \(#function) 👺 ERROR : \(error.localizedDescription) ⭐️⭐️\n")
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .notDetermined:
                os_log("User still thinking granting location access!", log: OSLog.default, type: .debug)
                manager.startUpdatingLocation() // this will access location automatically if user granted access manually. and will not show apple's request alert twice. (Tested)
                delegate?.serviceLocationError(errorCode: .accessPending)
                break
            case .denied:
                os_log("User denied location access request!!", log: OSLog.default, type: .debug)
                
                // show text on label
//                label.text = "To re-enable, please go to Settings and turn on Location Service for this app."
                manager.stopUpdatingLocation()
                delegate?.serviceLocationError(errorCode: .accessDenied)
                break
            
            case .authorizedWhenInUse:
                os_log("authorizedWhenInUse", log: OSLog.default, type: .debug)
                // clear text
//                label.text = ""
                manager.startUpdatingLocation() //Will update location immediately
                delegate?.serviceLocationError(errorCode: .accessAuthorizedWhenInUse)
                break
            
            case .authorizedAlways:
                // clear text
//                label.text = ""
                os_log("authorizedAlways", log: OSLog.default, type: .debug)
                manager.startUpdatingLocation() //Will update location immediately
                delegate?.serviceLocationError(errorCode: .accessAuthorizedAlways)
                break
            default:
                break
        }
    }
}
