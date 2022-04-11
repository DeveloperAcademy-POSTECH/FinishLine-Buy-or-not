//
//  Post.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/11.
//

import Foundation

struct Post {
    let id = UUID()
    
    // author will handle the creator's email information
    let author: String
    let title: String
    let description: String
    
    // Need to be String to calculate date difference like "2일 전"
    // Check Controllers/DateCalculator for your reference
    let createdAt: String
    let category: String
    let options: [Option]
    let votes: [Vote]
}

struct Option {
    let productName: String
    let price: Int?
    let productImageURL: String?
    let hyperLink: String?
}

struct Vote {
    let email: String
    let productSelected: String
}
