//
//  QuestionItemManager.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/07.
//

import Foundation

struct QuestionItemManager {
    var json = [QuestionItemData]()
    
    init() {
        load()
    }
    
    // Read the sample JSON file 
    mutating func load() {
        guard let url = Bundle.main.url(forResource: "SampleJSON", withExtension: "json")
        else {
            print("JSON file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let results = try? JSONDecoder().decode([QuestionItemData].self, from: data!)
        
//        if let localResults = results {
//            self.json = localResults
//        }
        self.json = results!
    }
    mutating func reLoad() {
        guard let url = Bundle.main.url(forResource: "SampleJSON", withExtension: "json")
        else {
            print("JSON file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let results = try? JSONDecoder().decode([QuestionItemData].self, from: data!)
        
        self.json += results!
    }
}

