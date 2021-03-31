//
//  ListViewModel.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import Foundation

class ListViewModel {
    private(set) var challengeData: [ChallengeData]
    
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
    
    init(viewState: ViewState, data: [ChallengeData] = []) {
        challengeData = data
        viewStateBinding = Box(viewState)
    }
}

extension ListViewModel {
    /**
    ChallengeData is sorted either in ascending or descending order
     
     - parameters:
        - isAscending: true if the sorted order must be ascending else false
     */
    func sortData(isAscending: Bool) {
        let temp: [ChallengeData]
        if isAscending {
            temp = challengeData.sorted { $0.type ?? "" < $1.type ?? "" }
        } else {
            temp = challengeData.sorted { $0.type ?? "" > $1.type ?? "" }
        }
        challengeData = temp
    }
    
    /**
     Returns a new sorted array of ChallengeData
      
     - returns:
        A sorted array of ChallengeData objects
     - parameters:
            - data: the input array whose contents are to be sorted
            - isAscending: true if the sorted order must be ascending else false
     */
    func sortedData(data: [ChallengeData], isAscending: Bool) -> [ChallengeData] {
        if isAscending {
            return data.sorted { $0.type ?? "" < $1.type ?? "" }
        }
        return data.sorted { $0.type ?? "" > $1.type ?? "" }
    }
    
    /**
     Handles API endpoint response and returns a ViewState through completion handler.
     Persists new response to Realm database.
     */
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

extension ListViewModel.ViewState: Equatable {
    static func ==(lhs: ListViewModel.ViewState, rhs: ListViewModel.ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.loading, .loading):
            return true
        case (.loadData, .loadData):
            return true
        case (.error(let text1), .error(let text2)):
            return text1 == text2
        default:
            return false
        }
    }
}
