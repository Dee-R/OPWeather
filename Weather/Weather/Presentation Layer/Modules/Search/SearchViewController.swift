//  View
//  Weather
import UIKit
import Foundation

class CustomViewCell: UITableViewCell {
  static var xibName: String = "CustomView"
  
}

protocol SearchViewProtocol: class  {
  func setTableViewRowsWith(listResultFetched: [String]? )
}

class SearchViewController: UIViewController {
  //VIP
  var interactor: SearchInteractorProtocol?
  var router: SearchRouterProtocol?
  
  var listResult: [String]? = nil
  @IBOutlet weak var tableview: UITableView!
  @IBOutlet weak var searchTextField: UITextField!
  // UI
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nib = UINib(nibName: "searchTableViewCell", bundle: nil)
    tableview.register(nib, forCellReuseIdentifier: "celll")

    
    tableview.register(CustomViewCell.self, forCellReuseIdentifier: "celll")
    setUpIconSearchTextField ()  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //        self.interactor?.search("")
    //self.interactor?.getAllCity()
    
  }
}

extension SearchViewController: SearchViewProtocol {
  func setTableViewRowsWith(listResultFetched result: [String]?) {
    listResult = result
    print(listResult)
  }
}

extension SearchViewController {
  func setUpIconSearchTextField () {
    let imageView = UIImageView(frame: CGRect(x: 6, y: 2, width: 15, height: 15))
    let image = UIImage(systemName: "magnifyingglass")
    imageView.image = image
    
    let iconViewContainner: UIView = UIView(frame: CGRect(x:0, y: 0, width: 20, height: 20))
    iconViewContainner.addSubview(imageView)
    
    searchTextField.leftView = iconViewContainner
    searchTextField.leftViewMode = .always
    searchTextField.tintColor = .lightGray
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "celll", for: indexPath)
    cell.textLabel?.text = "coucou"
    return cell
  }
  
}

//if cell == nil {
//  tableView.registerNib(UINib(nibName: "CustomOneCell", bundle: nil), forCellReuseIdentifier: identifier)
//  cell = tableView.dequeueReusableCellWithIdentifier(identifier,forIndexPath:indexPath ) as? CustomOneCell
//}
//cell.addOnName.text = items[indexPath.row]
//cell.addOnPrice.text = "£0.0"`
