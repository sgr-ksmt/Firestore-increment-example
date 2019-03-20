//
//  AppDelegate.swift
//  Firestore-increment-example
//
//  Created by suguru-kishimoto on 2019/03/20.
//  Copyright © 2019 Komerco. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
