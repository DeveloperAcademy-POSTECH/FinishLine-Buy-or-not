//
//  buy_or_notApp.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/06.
//

import SwiftUI
import Firebase

@main
struct buy_or_notApp: App {
    
    var login: Bool = true
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
           Main()
        }
    }
}
