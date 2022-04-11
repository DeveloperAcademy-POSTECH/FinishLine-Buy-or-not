//
//  User.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/11.
//

import Foundation

struct User {
    let id = UUID()
    let email: String
    let password: String
    let userName: String
    let imageURL: String?
    let favorites: [Favorite]
    let myQuestions: [String]
    let myAnswers: [String]
}

struct Favorite {
    let category: String
    let checked: Bool
}
