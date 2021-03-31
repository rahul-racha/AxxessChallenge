//
//  DetailViewModel.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import Foundation

class DetailViewModel {
    let viewStateBinding: Box<ChallengeData?>
    
    init(data: ChallengeData?) {
        viewStateBinding = Box(data)
    }
}

extension DetailViewModel: ListViewControllerDelegate {
    func didSelectItem(_ data: ChallengeData) {
        viewStateBinding.value = data
    }
}
