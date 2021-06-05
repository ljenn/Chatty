//
//  AppDelegate.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/12/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//


import UIKit
import Parse



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let parseConfig = ParseClientConfiguration {
                //chatty database:
//                $0.applicationId = "5o9MYYvmbNvRXm8uCMHjBzOBog3mh9u1peUe1Gsu" // <- UPDATE
//                $0.clientKey = "1Lr2wWoX9mmFxIRDfwVmHOZdQGjfyNooRbVZxY0d" // <- UPDATE
            
                //Kite Database
                $0.applicationId = "2ZkozU59JsUF5aCVzD59u0CGmQUs55QWD3zV5ZUE" // <- UPDATE
                $0.clientKey = "pWklacdcyh9p659HdhEPNg0fF8O1DjGMUUA0vXrz" // <- UPDATE
                $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

