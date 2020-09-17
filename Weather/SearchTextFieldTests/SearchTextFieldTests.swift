//
//  SearchTextFieldTests.swift
//  SearchTextFieldTests
//
//  Created by Eddy R on 17/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import XCTest

class SearchTextFieldTests: XCTestCase {

    func test_start_with_noSearch() {
        let spy = Spy()
        let myResultdataBase = ["Pa","Paris"]
        let sut = FlowSearch(spyRouter: spy, myletters: "", resultDataBase: myResultdataBase) // arrange
        sut.startSearch() // when
        XCTAssertEqual(spy.resultSearch, "") // assert
    }
    
    func test_start_with_P_Search() {
        let spy = Spy()
        let myResultdataBase = ["Pa"]
        let sut = FlowSearch(spyRouter: spy, myletters: "P", resultDataBase: myResultdataBase)
        sut.startSearch()
        XCTAssertEqual(spy.resultSearchArray, ["Pa"])
    }
    //
    func test_start_with_Pa_Search() {
        let spy = Spy()
        let myResultdataBase = ["Pa"]
        let sut = FlowSearch(spyRouter: spy, myletters: "Pa", resultDataBase: myResultdataBase)
        sut.startSearch()
        XCTAssertEqual(spy.resultSearchArray, ["Pa"])
    }
    func test_start_with_Pa_Search_Get2elements() {
        let spy = Spy()
        let myResultdataBase = ["Pa","Paris"]
        let sut = FlowSearch(spyRouter: spy, myletters: "P", resultDataBase: myResultdataBase)
        
        sut.startSearch()
        XCTAssertEqual(spy.resultSearchArray, ["Pa", "Paris"])
    }
    func test_start_with_P_Search_Get2elements_on3() {
        let spy = Spy()
        let myResultdataBase = ["Pa","Paris","Australia"]
        let sut = FlowSearch(spyRouter: spy, myletters: "P", resultDataBase: myResultdataBase)
        
        sut.startSearch()
        XCTAssertEqual(spy.resultSearchArray, ["Pa", "Paris"])
    }
    func test_start_with_Pa_Search_Get2elements_on4() {
        let spy = Spy()
        let myResultdataBase = ["Pa","Paris","Australia","Pouligny"]
        let sut = FlowSearch(spyRouter: spy, myletters: "Pa", resultDataBase: myResultdataBase)
        
        sut.startSearch()
        XCTAssertEqual(spy.resultSearchArray, ["Pa", "Paris"])
    }
    func test_start_with_Pao_Search_GetNoelements_on4() {
        let spy = Spy()
        let myResultdataBase = ["Pa","Paris","Australia","Pouligny"]
        let sut = FlowSearch(spyRouter: spy, myletters: "Pao", resultDataBase: myResultdataBase)
        
        sut.startSearch()
        XCTAssertEqual(spy.resultSearchArray, [])
    }
    
    
    
    
    // Pilote
    class Spy: SpyRouter {
        var resultSearch: String = ""
        var resultSearchArray: [String] = []
        
        func request(response: [String]) {
            resultSearchArray = response
        }
    }
}
