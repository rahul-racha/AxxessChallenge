//
//  ChallengeService.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/28/21.
//

import Foundation

class ChallengeService {
    private init() {}
    static let shared = ChallengeService()
    
    /**
     Service layer that coordinates the network call and response between networking and view model
     */
    func getData(success: @escaping ([ChallengeData]?) -> Void,
                 failure: @escaping (Error?) -> Void) {
        NetworkCall().execute(method: .get, url: ApiUriConstants.challengeData) { (result: Result<[ChallengeData]?, Error>?) -> Void in
            guard let res = result else {
                failure(nil)
                return
            }
            switch res {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
