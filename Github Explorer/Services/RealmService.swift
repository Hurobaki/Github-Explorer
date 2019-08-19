//
//  RealmService.swift
//  Github Explorer
//
//  Created by THE3796 on 03/08/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    public static let shared = RealmService()
   
    
    let defaultConfig = Realm.Configuration(
    schemaVersion: 8,
    migrationBlock: { migration, oldSchemaVersion in
      if (oldSchemaVersion < 1) {
      }
    })
    
    
    func add<T: Object> (object: T) {
        let realm = try! Realm(configuration: defaultConfig)
        
        do {
            try realm.write {
                realm.create(Repository.self, value: object, update: .all)
            }
        } catch let error as NSError {
            print("### ERROR ADD \(error.localizedDescription)")
        }
    }
    
    func isPresent<T:Object> (type: T.Type, id: Int) -> Bool {
        do {
            let realm = try! Realm(configuration: defaultConfig)
            return realm.objects(type).filter("id = %@", id).first != nil
        } catch let error as NSError {
            print("### ERROR isPresent \(error.localizedDescription)")
            return false
        }
    }
    
    func update<T: Object> (of type: T.Type, id: Int, for dictionary: [String: Any?]) {
        let realm = try! Realm(configuration: defaultConfig)
        
        let objects = realm.objects(Repository.self).filter("id = %@", id).first
        
        do {
            if let obj = objects {
                try realm.write {
                    for (key, value) in dictionary {
                        obj[key] = value!
                    }
                }
            }
        } catch let error as NSError {
            print("### ERROR Update \(error.localizedDescription)")
        }
    }
    
    func delete<T: Object> (object: T, id: Int) {
        let realm = try! Realm(configuration: defaultConfig)
        
        do {
            let objectToDelete = realm.objects(Repository.self).filter("id = %@", id).first
            if let obj = objectToDelete {
                try realm.write {
                    realm.delete(obj)
                }
            }
            
        } catch let error as NSError {
            print("### ERROR Delete \(error.localizedDescription)")
        }
    }
    
    func deleteAll<T: Object>(of type: T.Type) {
        let realm = try! Realm(configuration: defaultConfig)
        
        do {
            try realm.write {
                realm.delete(realm.objects(type))
            }
        } catch let error as NSError {
            print("### EROOR DeleteAll \(error.localizedDescription)")
        }
    }
    
    func printObjects<T: Object> (of type: T.Type) {
        let realm = try! Realm(configuration: defaultConfig)
        
        print("### PRINT OBJECTS \(realm.objects(type)))")
    }
    
    func foo<T: Object> (of type: T.Type) -> [T] {
        let realm = try! Realm(configuration: defaultConfig)

        return realm.objects(Repository.self).toArray(ofType: type)
    }
}


