//  Interactor
//  Weather

import Foundation

protocol SearchInteractorProtocol {
  func search(_ : String)
  func getAllCity()
  func test()
  func getDataCityOnce(completionHandler:(()->Void)?)
}
class SearchInteractor {
  // Cycle property
  var presenter: SearchPresenterProtocol?
  var listResult: [String] = [] // Result Search
}
extension SearchInteractor: SearchInteractorProtocol {
  func test () {
    print("██░░ 🚧","test †",#line)
  }
  func getAllCity() {
    DispatchQueue.global(qos: .userInteractive).sync {
      do {
        let city = try [City](filename: "CIty")
        
        _ = city.map { (c) in
          listResult.append(c.name)
        }
        
        //                DispatchQueue.main.async {
        //                    self.presenter?.interactor(self, didSearchWithResult: self.listResult)
        //                }
      } catch {}
      
      DispatchQueue.main.async {
        self.presenter?.interactor(self, didSearchWithResult: self.listResult)
      }
    }
  }
   
  func search(_ something: String) {
    listResult.append(something)
    
    DispatchQueue.global(qos: .userInteractive).sync {
      do {
        let city = try [City](filename: "city.list.min")
        _ =  city.map { (cityresult) in
          if cityresult.name.contains(something) {
            listResult.append(cityresult.name)
            print(cityresult.name)
          }
        }
        DispatchQueue.main.async {
          self.presenter?.interactor(self, didSearchWithResult: self.listResult)
        }
      } catch {}
    }
  }

  
  func getDataCityOnce(completionHandler: (() -> Void)? ) {
    // some stuff
//    CityManagerData().delete()
//    CityManagerData().insertLocalData()
    //Reflexion🏙🏝 👾👯‍♀️👙🙍🏻‍♀️👄😺🏖🏞
    _ = SearchCityManagerData().translateJsonToDict()
    _ = SearchCityManagerData().insertLocalData()
    completionHandler?()
  }
}



