//
//  AppDelegate.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        applicationCoordinator = ApplicationCoordinator(window: window!)
        applicationCoordinator?.start()
        return true
    }
}

