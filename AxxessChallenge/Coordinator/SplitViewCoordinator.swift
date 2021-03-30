//
//  SplitViewCoordinator.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/28/21.
//

import UIKit

class SplitViewCoordinator: Coordinator {
    let splitVC: SplitViewController
    
    init(_ splitViewController: SplitViewController) {
        self.splitVC = splitViewController
    }
    
    func start() {
        let listVC = ListViewController()
        listVC.viewModel = ListViewModel()
        splitVC.primaryViewController = listVC
        let detailVC = DetailViewController()
        detailVC.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem
        detailVC.navigationItem.leftItemsSupplementBackButton = true
        splitVC.secondaryViewController = detailVC
    }
}
