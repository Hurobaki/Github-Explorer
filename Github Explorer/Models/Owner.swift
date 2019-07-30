//
//  Owner.swift
//  Github Explorer
//
//  Created by THE3796 on 22/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI
import Combine

struct Owner: Decodable, Identifiable, Hashable {
    let id: Int
    let login: String
    
    
    init() {
        self.id = 1
        self.login = "pwet"
    }
}
