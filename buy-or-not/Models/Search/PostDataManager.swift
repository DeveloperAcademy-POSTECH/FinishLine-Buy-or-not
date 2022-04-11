//
//  DataManager2.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/12.
//

import Foundation

struct PostDataManager {
    var json = [PostData]()
    
    init() {
        load()
    }
    
    // Read the sample JSON file
    mutating func load() {
        guard let url = Bundle.main.url(forResource: "PostJSON", withExtension: "json")
        else {
            print("JSON file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let results = try? JSONDecoder().decode([PostData].self, from: data!)
        
//        if let localResults = results {
//            self.json = localResults
//        }
        self.json = results!
    }
    
    mutating func reLoad() {
        guard let url = Bundle.main.url(forResource: "PostJSON", withExtension: "json")
        else {
            print("JSON file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let results = try? JSONDecoder().decode([PostData].self, from: data!)
        
        self.json += results!
    }
}

