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
        listVC.viewModel = ListViewModel(viewState: .none)
        splitVC.primaryViewController = listVC
        let detailVC = DetailViewController()
        detailVC.viewModel = DetailViewModel(viewState: .empty)
        listVC.lvcDelegate = detailVC.viewModel
        splitVC.secondaryViewController = detailVC
    }
}
