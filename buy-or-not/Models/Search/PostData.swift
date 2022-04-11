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

    var id = UUID()
    let title: String
    var description: String
    var votes: String
    var category: String
    var items: [Item]
}

struct Item: Codable, Hashable {
    var name: String
    var link: String
    var price: Int
    var ImageURL : String
    
}
