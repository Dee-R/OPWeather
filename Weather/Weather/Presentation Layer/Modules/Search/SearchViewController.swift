//  View
//  Weather
import UIKit
import CoreData

class CustomViewCell: UITableViewCell {
  static var xibName: String = "CustomView"
}

protocol SearchViewProtocol: class  {
  func setTableViewRowsWith(listResultFetched: [String]? )
}

class SearchViewController: UIViewController, NSFetchedResultsControllerDelegate {
  //VIP
  var interactor: SearchInteractorProtocol?
  var router: SearchRouterProtocol?
  // data dataSource
  var listResult: [String]? = nil
  // filter when fetch data
  var predicateValue = ""
  // UI
  @IBOutlet weak var tableview: UITableView!
  @IBOutlet weak var searchTextField: UITextField!
  // Animation
  private lazy var spinner: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView.init(style: .large)
    indicator.color = .gray
    indicator.hidesWhenStopped = true
    return indicator
  }()
  // FetchResultController
  private lazy var searchCityManagerData : SearchCityManagerData = {
    let searchCityManagerData = SearchCityManagerData()
    searchCityManagerData.fetchResultControllerDelegate = self
    return searchCityManagerData
  }()
  
  // Cycle Life app
  override func viewDidLoad() {
    super.viewDidLoad()
    // register uitableViewCell
    let nib = UINib(nibName: "searchTableViewCell", bundle: nil)
    tableview.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
    // add icon search in uitextfield
    setUpIconSearchTextField ()
    busyIn()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if spinner.superview == nil, let superView = tableview.superview {
      superView.addSubview(spinner)
      superView.bringSubviewToFront(spinner)
      spinner.translatesAutoresizingMaskIntoConstraints = false
      spinner.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
      spinner.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.interactor?.getDataCityOnce() {
      DispatchQueue.main.async {
        self.busyOut()
        self.predicateValue = "e"
        self.tableview.reloadData()
      }
    }
  }
  
  
  // Action
  @IBAction func cancelAction(_ sender: Any) {
//    self.dismiss(animated: true, completion: nil)
    navigationController?.popToRootViewController(animated: true)
  }
}

// MARK: - SearchViewController
extension SearchViewController: SearchViewProtocol {
  func setTableViewRowsWith(listResultFetched result: [String]?) {
    listResult = result
  }
}

// MARK: - TextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
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
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if let text = textField.text,
      let textRange = Range(range, in: text) {
      let updatedText = text.replacingCharacters(in: textRange,
                                                 with: string)
      
      print(updatedText)

      predicateValue = updatedText
      tableview.reloadData()
      // 📢 : reload tableView.
      
    }
    return true
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let c = searchCityManagerData.fetchLocalData(predicate: predicateValue) else { return 0 }
    print(c.fetchedObjects?.count)
//    return c.fetchedObjects?.count ?? 0
    return c.fetchedObjects?.count ?? 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
//    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath)
//    cell.textLabel?.text = "coucou"
//    return cell
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
    guard let c = searchCityManagerData.fetchLocalData(predicate: predicateValue) else { return UITableViewCell() }
    if let name = c.fetchedObjects?[indexPath.row].name,let cp = c.fetchedObjects?[indexPath.row].cp {
      cell.nameCity.text = name
//      cell.name.text = name + " " + cp
    } else {
//      cell.name.text = "_"
      cell.nameCity.text = "_"
    }
    
    
    return cell
  }
}

// MARK: - AnimationSpinner
extension SearchViewController {
  func busyIn() {
    spinner.startAnimating()
  }
  func busyOut() {
    spinner.stopAnimating()
  }
}



////tableview
//func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//  let t = tableView.cellForRow(at: indexPath) as! CityTableViewCell
//  //    print("██░░ 🚧","var \(t.name.text) †",#line)
//  //    let detailsViewController = DetailsCityController()
//  //    detailsViewController.nameCity = t.name.text ?? ""
//  //    self.present(detailsViewController, animated: true, completion: nil)
//  
//  let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsCityController") as! DetailsCityController
//  present(vc, animated: true, completion: nil)
//  vc.nameCity = t.name.text ?? ""
//  
//  
//  // presentViewController
//}
