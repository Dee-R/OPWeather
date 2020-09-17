//
//  EngineSearch.swift
//  SearchTextFieldTests
//
//  Created by Eddy R on 17/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation

protocol SpyRouter {
    func request(response: [String])
}

//Engine
class FlowSearch {
    let spyRouter: SpyRouter // type can have  many implentation from any device
    var letters: String = ""
    var result:[String] = []
    var dataBase: [String] = []
    
    init(spyRouter: SpyRouter, myletters: String, resultDataBase: [String]) {
        self.spyRouter = spyRouter
        self.letters = myletters
        self.dataBase = resultDataBase
    }
    
    func startSearch(){
        if !letters.isEmpty {
            for i in 0..<dataBase.count{
                if dataBase[i].contains(letters) {
                    result.append(dataBase[i])
                }
            }
            spyRouter.request(response: result)
        }
    }
}
