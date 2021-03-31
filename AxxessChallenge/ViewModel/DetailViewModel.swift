//
//  DetailViewModel.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import Foundation

class DetailViewModel {
    enum ViewState {
        case empty
        case success(ChallengeData)
    }
    
    let viewStateBinding: Box<ViewState>
    
    init(viewState: ViewState) {
        viewStateBinding = Box(viewState)
    }
}

extension DetailViewModel: ListViewControllerDelegate {
    func didSelectItem(_ data: ChallengeData) {
        viewStateBinding.value = ViewState.success(data)
    }
}
