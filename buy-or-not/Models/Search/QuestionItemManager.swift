//
//  QuestionItemManager.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/07.
//

import Foundation

class QuestionItemManager: ObservableObject {
    @Published var json = [QuestionItemData]()
    
    init() {
        load()
    }
    
    // Read the sample JSON file 
    func load() {
        guard let url = Bundle.main.url(forResource: "SampleJSON", withExtension: "json")
        else {
            print("JSON file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let results = try? JSONDecoder().decode([QuestionItemData].self, from: data!)
        
        self.json = results!
    }
}

