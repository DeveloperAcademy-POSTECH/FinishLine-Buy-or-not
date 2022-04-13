//
//  questionItemData.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/07.
//

import Foundation

struct UserData: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case email
        case password
        case nickName
        case imageURL
        case favorites
    }

    var id = UUID()
    let email: String
    var password: String
    var nickName: String
    var imageURL: String
    var favorites: [String]
}
