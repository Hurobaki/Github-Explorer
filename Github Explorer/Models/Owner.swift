//
//  Owner.swift
//  Github Explorer
//
//  Created by THE3796 on 22/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI
import Combine
import RealmSwift
import Realm

class Owner: Object, Decodable, Identifiable {
    @objc dynamic var id: Int = 0
    @objc dynamic var login: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, login: String) {
        self.init()
        self.id = id
        self.login = login
        
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
           super.init(value: value, schema: schema)
       }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
