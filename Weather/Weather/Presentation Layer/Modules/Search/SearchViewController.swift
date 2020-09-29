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
  // data dataSource
  var listResult: [String]? = nil
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
    //        self.interactor?.search("")
    //self.interactor?.getAllCity()
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
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath)
    cell.textLabel?.text = "coucou"
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

