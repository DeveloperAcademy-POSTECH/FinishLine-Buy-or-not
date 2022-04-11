//
//  CategorySelector.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/11.
//

import Foundation

class CategorySelector: ObservableObject {
    @Published var category: String
    
    init() {
        self.category = "모두보기"
    }
    
    func select(name: String) {
        self.category = name
    }
}
