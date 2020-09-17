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
    
    private var dataByLocationFetched = false
    private var isAccessLocalization = false
    
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
        print("██░░░ L\(#line) 🚧🚧 DID getLOCATION 🚧🚧",String(describing: self) ,#function)
        //Reflexion🏙🏝 👾👯‍♀️👙🙍🏻‍♀️👄😺🏖🏞  get weather
//        let EtrechyGPS = CLLocationCoordinate2D(latitude: 48.5, longitude: 2.2)
        weatherService.getDataWeatherByLatAndLon(coordinates : coordinates) { (weatherDict) in
            print("██░░░ L\(#line) 🚧🚧",weatherDict,"🚧🚧\n \(#function)")
            guard let weatherCity           = weatherDict["city"] as? String else { fatalError(" city is optionnal") }
            guard let temp                  = weatherDict["temp"] as? Float else { fatalError("temperatur is optionnal")}
                  let weatherConditionCode  = weatherDict["idWeather"] as? Int
            guard let tempMax               = weatherDict["temperatureMax"] as? Float else { fatalError("temperaturMax is optionnal")}
            guard let sunriseTime = weatherDict["sunrise"] as? Int else { fatalError("sunrise is optionnal")}
            guard let sunsetTime  = weatherDict["sunset"] as? Int else { fatalError("sunsetTime is optionnal")}
            guard let description = weatherDict["description"] as? String else { fatalError("description is optionnal")}
            
            self.dataByLocationFetched = true
            
            // -- handled
            let weatherConditionHandled = ConversionWorker.weatherCodeToPicture(conditionCode: weatherConditionCode)
            let weatherConditionHandled2 = ConversionWorker.weatherIconDescriptonBy(conditionCode: weatherConditionCode)
            let temperatureHandled = ConversionWorker.tempToCelsuis(temp)
            let temperatureMaxHandled = ConversionWorker.tempToCelsuis(tempMax)
            let sunriseTimeHandled = ConversionWorker.date(sunriseTime) ?? "__:__"
            let sunsetTimeHandled = ConversionWorker.date(sunsetTime) ?? "__:__"
                        
            //Reflexion🏙🏝 👾👯‍♀️👙🙍🏻‍♀️👄😺🏖🏞
            print("  💟",weatherConditionHandled2,"💟")
            
            
            // -- entity send thru
            let weatherEntity = WeatherEntity(temp: temperatureHandled, name: weatherCity, weatherCondition: weatherConditionHandled, weatherCondition2: weatherConditionHandled2, tempMax: temperatureMaxHandled,sunrise: sunriseTimeHandled, sunset: sunsetTimeHandled, description:  description)
            // -- refresh
            DispatchQueue.main.async {

                if (self.dataByLocationFetched &&  self.isAccessLocalization) {
                    self.presenter?.interactor(self, DidGetStatusConnection: self.isAccessLocalization) // animation
                    self.presenter?.interactor(self, didRetrieveTemp: weatherEntity) // send data
                }
                
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
        print("██░░░ L\(#line) 🚧🚧 Localization Status : Failed; Gere le cas il Service location n'arrive pas trouver une position  🚧🚧",String(describing: self) ,#function)
        
        self.presenter?.interactor(self, DidFailedConnectionLocalization: UIColor.red)
    }
    func serviceLocation(Code: ManagerLocationError) {
        print("██░░░ L\(#line) 🚧🚧📐 \(String(describing: self)) 🚧\(#function)🚧 ")
        
        switch Code {
            case .accessPending:
                print("██░░░ L\(#line) 🚧🚧 accessPending 🚧🚧")
                isAccessLocalization = false
                break
            case .accessDenied:
                print("██░░░ L\(#line) 🚧🚧 accessDenied 🚧🚧")
                isAccessLocalization = false
                break
            case .accessAuthorizedAlways:
                print("██░░░ L\(#line) 🚧🚧 accessAuthorizedAlways 🚧🚧")
                isAccessLocalization = true
                break
            case .accessAuthorizedWhenInUse:
                print("██░░░ L\(#line) 🚧🚧 accessAuthorizedWhenInUse 🚧🚧")
                isAccessLocalization = true
                break
            //Reflexion🏙🏝 👾👯‍♀️👙🙍🏻‍♀️👄😺🏖🏞
        }
    }
}
