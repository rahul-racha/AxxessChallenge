//
//  ChallengeData.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import Foundation
import RealmSwift

class ChallengeData: Object, Decodable, NSCopying {
    @objc dynamic var id: String?
    @objc dynamic var type: String?
    @objc dynamic var date: String?
    @objc dynamic var data: String?
    
    func copy(with zone: NSZone? = nil) -> Any {
        let new = ChallengeData()
        new.id = id
        new.type = type
        new.date = date
        new.data = data
        return new
    }
}
