//
//  UserData.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/08.
//

import Foundation
import SwiftUI

struct UserData: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case email
        case password
        case userName
        case nickName
        case imageURL
        case favorites
    }

    var id = UUID()
    
    let email: String
    var password: String
    var userName: String
    var nickName: String
    var imageURL: String
    var favorites: [Favorites]
}

struct Favorites: Codable, Hashable {
    var category: String
    var checked: Bool
    var awarded: Bool
    
    func pressedToggle(checked: inout Bool) {
        checked = !checked
    }
}

