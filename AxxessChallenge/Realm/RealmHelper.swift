//
//  RealmHelper.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/31/21.
//

import Foundation
import RealmSwift

class RealmHelper {
    static func save<T:Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object)
            }
        } catch (let error) {
            NSLog("error \(error)")
        }
    }
    
    static func saveAll<T:Object>(_ objects: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(objects)
            }
        } catch (let error) {
            NSLog("error \(error)")
        }
    }
    
    static func deleteAll<T>(type: T.Type) where T: Object {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.delete(realm.objects(type))
            }
        } catch (let error) {
            NSLog("error \(error)")
        }
    }
    
    static func getAll<T:Object>(type: T.Type) -> [T] {
        do {
            let realm = try Realm()
            let objs = realm.objects(type)
            return Array(objs)
        } catch (let error) {
            NSLog("error \(error)")
        }
        return []
    }
}
