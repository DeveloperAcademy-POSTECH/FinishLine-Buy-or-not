//
//  UserManager.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/08.
//

import Foundation

class UserManager: ObservableObject {
    @Published var json = [UserData]()
    
    init() {
        load()
    }
    
    // Read the sample JSON file
    func load() {
        guard let url = Bundle.main.url(forResource: "UserJSON", withExtension: "json")
        else {
            print("JSON file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let results = try? JSONDecoder().decode([UserData].self, from: data!)
        
        self.json = results!
    }
}
