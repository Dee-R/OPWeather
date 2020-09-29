//
//  SearchCityManagerData.swift

import UIKit
import CoreData

class SearchCityManagerData {
  lazy var container:  NSPersistentContainer = {
    return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
  }()
  lazy  var context : NSManagedObjectContext = {
    return container.viewContext
  }()
  
  /** export list city in dictionnary from json loacl file. */
  func translateJsonToDict() -> [[String: Any]]? {
    // get url locally
    var cityDict = [[String: Any]]()
    
    guard let url = Bundle.main.url(forResource: "test", withExtension: "json") else { return nil }
    do {
      let data = try Data(contentsOf: url)
      let result = try JSONDecoder().decode([SearchDecodable].self, from:data)
      
      let resultMapped = result.map { (objet) -> [String:Any] in
        if let name = objet.name, let cp = objet.cp{
          return [
            "name":name,
            "cp": cp
          ]
        }
        else {
          return [
            "name":"_",
            "cp":"_"
          ]
        }
      }
      cityDict.append(contentsOf: resultMapped)
    } catch  {
      print(error)
    }
    return cityDict
  }
 
  
  // Ìnsert Json Into CoreData Via Batch Request and Using NSFetchRequest Controller for the TableView
  func insertLocalData() {
    // inserting in core data
    
    if let cityDicts = translateJsonToDict() {
      context.perform {
        let insertRequest = NSBatchInsertRequest(entity: CityEntity.entity(), objects: cityDicts)
        do {
          try self.context.execute(insertRequest)
        } catch let error as NSError{
          print(error.userInfo)
        }
      }
    }
  }
  func deleteAllLocalData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let _ = UIApplication.shared.delegate as! AppDelegate
    
    let requestFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CityEntity")
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: requestFetch)
    var resultBatchDelete: NSBatchDeleteResult
    do {
      resultBatchDelete =  try context.execute(batchDeleteRequest) as! NSBatchDeleteResult
      print(resultBatchDelete)
    } catch let error as NSError {
      print("██░░░ L\(#line) 🚧🚧 err : \(error), \(error.userInfo) 🚧🚧 ",String(describing: self),#function)
    }
  }

}


public class Helper{
  static func pathSqlite() {
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    let pathFileSqlite = appdelegate.persistentContainer.persistentStoreDescriptions
    print("██░░ 🚧","pathFileSqlite : \(pathFileSqlite) †",#line)
  }
}

