//
//  SearchViewControllerTest.swift
//  SearchViewControllerTest
//
//  Created by Eddy R on 17/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import XCTest
import UIKit
@testable import Weather

class SearchViewControllerTest: XCTestCase {
  
//  // qu'est ce que veux qu'il arrive / what do we want to happen ?
  var view : SearchViewController! = nil
  override func setUpWithError() throws {
    view = SearchViewController(nibName: "SearchView", bundle: nil)
    SearchBuilder.buildModule(arroundView: view)
  }
  
  
  
  func test_ViewControllerIsTapped() {
    
    view.interactor?.getDataCityOnce(completionHandler: nil)
    
    
  }
  
  
  
//  func test_SearchViewController_GetListCity_WhenSearchTextWith_NoChar_Get_nil() throws {
////    let sut = SearchViewController()
////    sut.interactor?.search("")
////    XCTAssertEqual(sut.listResult, nil)
//  }
//  //    func test_Search_GetListCity_WhenSearchTextWith_A1_Get_A1() {
//  //        sut.interactor?.search("A1")
//  //        XCTAssertEqual(sut.listResult, ["A1"])
//  //    }
//  //    func test_Search_GetListCity_WhenSearchTextWith_P_Get_SomeResult() {
//  //        sut.interactor?.search("P")
//  //
//  //        let expectatin = expectation(description: "download ok")
//  //
//  //
//  //        DispatchQueue.global(qos: .userInteractive).sync {
//  //            do {
//  //                let city = try [City](filename: "city.list.min")
//  //                _ =  city.map { (cityresult) in
//  //                    if cityresult.name.contains("P") {
//  //
//  //                        print(cityresult.name)
//  //                    }
//  //
//  //                }
//  //                expectatin.fulfill()
//  //            } catch {}
//  //        }
//  //
//  //
//  //
//  //        waitForExpectations(timeout: 10.0) { (error) in
//  //            print("██░░░ L\(#line) 🚧🚧 timeOut 🚧🚧",String(describing: self) ,#function)
//  //        }
//  //    }
//
//
//  func test_Search_GetListCity_WhenSearchTextWith_P_Get_SomeResult() {
//    sut.interactor?.search("P")
//
//    sut.interactor?.getAllCity()
//    XCTAssertTrue(sut.listResult?.count ?? 0 >= 1)
//  }
}
