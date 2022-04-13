//
//  LinkURL.swift
//  buy-or-not
//
//  Created by leejunmo on 2022/04/13.
//

import SwiftUI

struct LinkURL: View {
    @Environment(\.openURL) private var openURL
    
    let url: String
    
    var body: some View {
        Image(systemName: "link")
            .onTapGesture {
                if let url = URL(string: url) {
                    openURL(url)
                }
            }
    }
}
