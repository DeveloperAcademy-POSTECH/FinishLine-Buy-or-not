//
//  UserData.swift
//  buy-or-not
//
//  Created by 이지원 on 2022/04/12.
//

import Foundation


struct UserData: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case name
        case comment
        case email
        case password
        case imageURL
        case interested
    }
    var id = UUID()
    let name: String
    var comment: String
    var email: String
    var password: String
    var imageURL: String
    var interested: String
}
