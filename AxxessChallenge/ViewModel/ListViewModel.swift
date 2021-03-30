//
//  ListViewModel.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import Foundation

class ListViewModel {
    private(set) var challengeData = [ChallengeData]()
    
    enum ViewState {
        case loading
        case loadData
        case error(String)
        case none
    }
    
    enum UserIntent {
        case newData
    }
    
    let viewStateBinding: Box<ViewState>
    
    var intent: UserIntent? {
        didSet {
            guard let val = intent else { return }
            switch val {
            case .newData:
                viewStateBinding.value = .loading
                getDataViewState { [weak self] in self?.viewStateBinding.value = $0 }
            }
        }
    }
    
    init() {
        viewStateBinding = Box(ViewState.none)
    }
}

extension ListViewModel {
    func getDataViewState(completion: @escaping (ViewState) -> Void) {
        ChallengeService.shared.getData { [weak self] data in
            guard let weakSelf = self else { return }
            weakSelf.challengeData = data ?? []
            completion(.loadData)
        } failure: { error in
            let message = error?.localizedDescription ?? "Failed to retrieve data"
            completion(.error(message))
        }
    }
}
