//  Presenter
//  SearchPresenter.swift

import Foundation
protocol SearchPresenterProtocol {
    func interactor(_:SearchInteractorProtocol, didSearchWithResult: [String]?)
}
class SearchPresenter {
    weak var view: SearchViewProtocol?
}
extension SearchPresenter: SearchPresenterProtocol {
    func interactor(_: SearchInteractorProtocol, didSearchWithResult result: [String]?) {
        print("██░░░ L\(#line) 🚧🚧📐 \(String(describing: self)) 🚧\(#function)🚧 ")
        self.view?.setTableViewRowsWith(listResultFetched: result)
    }
}
