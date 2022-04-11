//
//  SelectedCategory.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/11.
//

import Foundation

class SelectedCategory: ObservableObject {
    @Published var selectedCategory: String
    
    init(category: String) {
        self.selectedCategory = category
    }

    func select(category: String) {
        self.selectedCategory = category
    }

}
