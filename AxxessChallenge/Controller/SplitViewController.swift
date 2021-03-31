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
        delegate = self
        if #available(iOS 14, *) {
            preferredDisplayMode = .oneBesideSecondary
        } else {
            preferredDisplayMode = .allVisible
        }
        preferredPrimaryColumnWidthFraction = 0.4
        sVC.navigationItem.leftBarButtonItem = displayModeButtonItem
        sVC.navigationItem.leftItemsSupplementBackButton = true
    }
}

extension SplitViewController: UISplitViewControllerDelegate {
//    @available(iOS 14.0, *)
//    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
//        guard let navigationController = secondaryViewController as? UINavigationController,
//              let detailVC = navigationController.topViewController as? DetailViewController else {
//            return .primary
//        }
//        return detailVC.someData == nil ? .primary : .secondary
//    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
      collapseSecondary secondaryViewController: UIViewController,
      onto primaryViewController: UIViewController) -> Bool {

      guard let navigationController = secondaryViewController as? UINavigationController,
            let detailVC = navigationController.topViewController as? DetailViewController else {
        return true
      }
        return detailVC.viewModel.viewStateBinding.value == nil
    }
}
