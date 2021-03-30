//
//  SplitViewController.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/28/21.
//

import UIKit

class SplitViewController: UISplitViewController {
    var primaryViewController: UIViewController?
    var secondaryViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pVC = primaryViewController, let sVC = secondaryViewController else {
            return
        }
        let primaryNavController = UINavigationController(rootViewController: pVC)
        let secNavController = UINavigationController(rootViewController: sVC)
        viewControllers = [primaryNavController, secNavController]
        if #available(iOS 14, *) {
            preferredDisplayMode = .oneBesideSecondary
        } else {
            preferredDisplayMode = .allVisible
        }
        preferredPrimaryColumnWidthFraction = 0.4
        delegate = self
    }
}

extension SplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController,
      collapseSecondary secondaryViewController: UIViewController,
      onto primaryViewController: UIViewController) -> Bool {

      guard let navigationController = secondaryViewController as? UINavigationController,
            let detailVC = navigationController.topViewController as? DetailViewController else {
        return true
      }
        return detailVC.someData == nil
    }
}
