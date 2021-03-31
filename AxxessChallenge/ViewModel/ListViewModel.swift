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
            let copy = weakSelf.challengeData.map { $0.copy() as? ChallengeData ?? ChallengeData() }
            DispatchQueue.global(qos: .utility).async {
                RealmHelper.deleteAll(type: ChallengeData.self)
                RealmHelper.saveAll(copy)
            }
            completion(.loadData)
        } failure: { [weak self] error in
            guard let weakSelf = self else { return }
            if error as? NetworkError != nil {
                let objs = RealmHelper.getAll(type: ChallengeData.self)
                weakSelf.challengeData = objs
                completion(.loadData)
                return
            }
            let message = error?.localizedDescription ?? "Failed to retrieve data"
            completion(.error(message))
        }
    }
}
