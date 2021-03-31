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
    
    override init() {
        super.init()
    }
    
    init(id: String?, type: String?, date: String?, data: String?) {
        self.id = id
        self.type = type
        self.date = date
        self.data = data
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return ChallengeData(id: id, type: type, date: date, data: data)
    }
}
