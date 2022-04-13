//
//  questionItemData.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/07.
//

import Foundation

struct QuestionItemData: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case author
        case title
        case timeStamp
        case category
        case items
    }

    var id = UUID()
    let author: String
    var title: String
    var category: String
    var items: [Options]
    var timeStamp: String
}

struct Options: Codable, Hashable {
    var name: String
    var itemURL: String
    var cost: String
    var imageURL: String
    var votes: [String]
}
