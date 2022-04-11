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
    
    var login: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            if login{
                Main()
            } else{
                LoginContentView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
                //패키지 초기화 작업 수행

        FirebaseApp.configure() //👍🏻

        return true
    }
}
