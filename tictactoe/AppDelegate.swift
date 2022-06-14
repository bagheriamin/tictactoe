//
//  AppDelegate.swift
//  tictactoe
//
//  Created by Amin  Bagheri  on 2022-05-28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UserDefaults.standard.set(true, forKey: "toggleState")
        
        return true
    }

}

