//  View
//  Weather
import UIKit

protocol SearchViewProtocol: class  {
    func setTableViewRowsWith(listResultFetched: [String]? )
}
class SearchViewController: UIViewController {
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    var listResult: [String]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.interactor?.search("")
        self.interactor?.getAllCity()
    }
}
extension SearchViewController: SearchViewProtocol {
    func setTableViewRowsWith(listResultFetched result: [String]?) {
        listResult = result
        print(listResult)
    }
}
