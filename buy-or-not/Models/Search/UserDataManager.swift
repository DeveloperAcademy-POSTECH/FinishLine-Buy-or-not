//
//  DataManager2.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/12.
//

import Foundation

struct UserDataManager {
    var json = [UserData]()
    
    init() {
        load()
    }
    
    // Read the sample JSON file
    mutating func load() {
        guard let url = Bundle.main.url(forResource: "UserJSON", withExtension: "json")
        else {
            print("JSON file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let results = try? JSONDecoder().decode([UserData].self, from: data!)
        
//        if let localResults = results {
//            self.json = localResults
//        }
        self.json = results!
    }
    
    mutating func reLoad() {
        guard let url = Bundle.main.url(forResource: "UserJSON", withExtension: "json")
        else {
            print("JSON file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let results = try? JSONDecoder().decode([UserData].self, from: data!)
        
        self.json += results!
    }
}

