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
        case votes
        case comments
        case imageURL
        case originatedDate
        case options
    }

    var id = UUID()
    let author: String
    var title: String
    var votes: Int
    var comments: Int
    var imageURL: String
    var originatedDate: String
    var options: [Options]
}

struct Options: Codable, Hashable {
    var name: String
    var pressed: Bool
    var itemURL: String
    var cost: Int
    
    func pressedToggle(pressed: inout Bool) {
        pressed = !pressed
    }
}
