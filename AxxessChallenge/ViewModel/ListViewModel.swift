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
        case sort(Bool)
    }
    
    let viewStateBinding: Box<ViewState>
    
    var intent: UserIntent? {
        didSet {
            guard let val = intent else { return }
            switch val {
            case .newData:
                viewStateBinding.value = .loading
                getDataViewState { [weak self] in self?.viewStateBinding.value = $0 }
            case .sort(let isAsc):
                isAscending = isAsc
                sortData(isAscending: isAscending)
                viewStateBinding.value = ViewState.loadData
            }
        }
    }
    
    var isAscending: Bool {
        get {
            return UserDefaults.standard.object(forKey: "ascending") as? Bool ?? true
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "ascending")
        }
    }
    
    init() {
        viewStateBinding = Box(ViewState.none)
    }
}

extension ListViewModel {
    func sortData(isAscending: Bool) {
        let temp: [ChallengeData]
        if isAscending {
            temp = challengeData.sorted { $0.type ?? "" < $1.type ?? "" }
        } else {
            temp = challengeData.sorted { $0.type ?? "" > $1.type ?? "" }
        }
        challengeData = temp
    }
    
    func sortedData(data: [ChallengeData], isAscending: Bool) -> [ChallengeData] {
        if isAscending {
            return data.sorted { $0.type ?? "" < $1.type ?? "" }
        }
        return data.sorted { $0.type ?? "" > $1.type ?? "" }
    }
    
    func getDataViewState(completion: @escaping (ViewState) -> Void) {
        ChallengeService.shared.getData { [weak self] data in
            guard let weakSelf = self else { return }
            weakSelf.challengeData = weakSelf.sortedData(data: data ?? [],
                                                         isAscending: weakSelf.isAscending)
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
                weakSelf.challengeData = weakSelf.sortedData(data: objs,
                                                             isAscending: weakSelf.isAscending)
                completion(.loadData)
                return
            }
            let message = error?.localizedDescription ?? "Failed to retrieve data"
            completion(.error(message))
        }
    }
}
