//
//  questionItemData.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/07.
//

import Foundation
import SwiftUI

struct QuestionItemData: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case author
        case title
        case votes
        case comments
        case imageURL
        case options
    }

    var id = UUID()
    let author: String
    var title: String
    var votes: Int
    var comments: Int
    var imageURL: String
    var options: [Options]
}

struct Options: Codable, Hashable {
    var name: String
    var pressed: Bool
    
    func pressedToggle(pressed: inout Bool) {
        pressed = !pressed
    }
}
