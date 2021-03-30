//
//  DetailViewModel.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import Foundation

class DetailViewModel {
    enum ViewState {
        case success
        case empty
    }
    let viewStateBinding: Box<ChallengeData?>
    
    init() {
        viewStateBinding = Box(nil)
    }
}
