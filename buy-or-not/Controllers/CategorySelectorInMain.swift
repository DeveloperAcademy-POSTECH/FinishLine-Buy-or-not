//
//  CategorySelectorInMain.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/11.
//

import Foundation

class CategorySelectorInMain: ObservableObject {
    @Published var category: String
    
    init(name: String) {
        self.category = name
    }
    
    func select(name: String) {
        self.category = name
    }
}
