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
    func serviceLocation(Code: ManagerLocationError)
}

class ServiceLocation : NSObject{
    private var locationManager: CLLocationManager = CLLocationManager()
    var delegate: ServiceLocationDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    func getLocation() {
        locationManager.stopUpdatingLocation()
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
}

extension ServiceLocation :  CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        
        delegate?.serviceLocation(manager, didGetLocationByCoordinate: coordinate)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.serviceLocation(manager, didFailWithErrorToGetLocation: error )
        print("██░░░ L\(#line) 🚧🚧 error : \(error) 🚧🚧 ",String(describing: self),#function)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .notDetermined:
//                print("██░░░ L\(#line) 🚧🚧 User still thinking granting location access! 🚧🚧 \(#function) \n")
                manager.startUpdatingLocation() // this will access location automatically if user granted access manually. and will not show apple's request alert twice. (Tested)
                delegate?.serviceLocation(Code: .accessPending)
                break
            
            case .denied:
//                print("██░░░ L\(#line) 🚧🚧 Denied 🚧🚧",String(describing: self) ,#function)
                manager.stopUpdatingLocation()
                delegate?.serviceLocation(Code: .accessDenied)
                break
            
            case .authorizedWhenInUse:
//                print("██░░░ L\(#line) 🚧🚧 authorizedWhenInUse 🚧🚧\n \(#function)")
                manager.startUpdatingLocation() //Will update location immediately
                delegate?.serviceLocation(Code: .accessAuthorizedWhenInUse)
                break
            
            case .authorizedAlways:
//                print("██░░░ L\(#line) 🚧🚧 authorizedAlways 🚧🚧\n \(#function)")
                manager.startUpdatingLocation() //Will update location immediately
                delegate?.serviceLocation(Code: .accessAuthorizedAlways)
                break
            default:
                break
        }
    }
}
