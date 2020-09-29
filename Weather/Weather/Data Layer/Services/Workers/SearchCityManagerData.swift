//
//  SearchCityManagerData.swift

import UIKit
import CoreData

class SearchCityManagerData {
  
  
  weak var fetchResultControllerDelegate: NSFetchedResultsControllerDelegate? // delegate view data for tableview
  
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
    let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let context : NSManagedObjectContext = container.viewContext
    
    if let cityDicts = translateJsonToDict() {
      context.perform {
        let insertRequest = NSBatchInsertRequest(entity: CityEntity.entity(), objects: cityDicts)
        do {
          try context.execute(insertRequest)
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
  
  
  func fetchLocalData(predicate:String?) -> NSFetchedResultsController<CityEntity>? {
    
    let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let context : NSManagedObjectContext = container.viewContext
    
    // fetch request local data
    let fetchRequest : NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
    
    // Apply several predicate to match with th research
    guard let predicate = predicate else { return nil }
    let predicate1 = NSPredicate(format: "name CONTAINS[c] %@", predicate) // name or
    let predicate2 = NSPredicate(format: "cp CONTAINS[c] %@", predicate) // code city
    // add them
    fetchRequest.predicate = NSCompoundPredicate(type: .or, subpredicates: [predicate1, predicate2])
    
    
    if let city = try? fetchRequest.execute().first {
      print("██░░ 🚧","city = \(city.name ?? "Rien") †",#line)
    }
    
    // Sort Result by
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
//    fetchRequest.fetchLimit = 1
    fetchRequest.fetchBatchSize = 50
    
    // execute the request
    
    
    let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                managedObjectContext: context,
                                                sectionNameKeyPath: nil, cacheName: nil)
    
    controller.delegate = fetchResultControllerDelegate // viewcontroller
    
    do {
      try controller.performFetch()
    } catch {
      fatalError("\(error)")
    }
    return controller
  }

}


public class Helper{
  static func pathSqlite() {
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    let pathFileSqlite = appdelegate.persistentContainer.persistentStoreDescriptions
    print("██░░ 🚧","pathFileSqlite : \(pathFileSqlite) †",#line)
  }
}

