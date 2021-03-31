//
//  ApplicationCoordinator.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/28/21.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    var splitViewCoordinator: SplitViewCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    /**
     Main Application Coordinator start() that sets roots view for a  window and makes it available
     */
    func start() {
        let splitViewController = SplitViewController()
        splitViewCoordinator = SplitViewCoordinator(splitViewController)
        splitViewCoordinator?.start()
        window.rootViewController = splitViewController
        window.makeKeyAndVisible()
    }
}
