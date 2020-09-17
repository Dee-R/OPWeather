//
//  SearchViewController.swift
//  Weather
//
//  Created by Eddy R on 17/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import UIKit

protocol SearchViewProtocol: class  {
    
}
class SearchViewController: UIViewController {
    
    var interactor: SearchInteractorProtocol?
    var presenter: SearchPresenterProtocol?
    var router: SearchRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
