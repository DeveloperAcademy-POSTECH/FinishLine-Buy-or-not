//
//  PostData.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/12.
//

import Foundation

struct PostData: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case title
        case description
        case votes
        case category
        case items
    }
    
    init(){
        self.title = ""
        self.description = ""
        self.votes = ""
        self.category = ""
        self.items = [Item]()
    }
    
    var id = UUID()
    var title: String
    var description: String
    var votes: String
    var category: String
    var items: [Item]
    
   
    mutating func addData(title: String, description: String, category: String){
        self.title = title
        self.description = description
        self.category = category
    }
    
    mutating func addItem(parameter:[Item]){
        self.items = parameter
        
    }
}

struct Item: Codable, Hashable {
    var name: String
    var link: String
    var price: Int
    //var ImageURL : String

}
