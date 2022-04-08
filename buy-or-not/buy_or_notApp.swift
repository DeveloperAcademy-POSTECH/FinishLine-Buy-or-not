//
//  buy_or_notApp.swift
//  buy-or-not
//
//  Created by Noah's Ark on 2022/04/06.
//

import SwiftUI

@main
struct buy_or_notApp: App {
    
    var login: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if login == true {
//                ContentView()
//                Main()
                UserView()
            } else {
                LogInPage()
            }
        }
    }
}
