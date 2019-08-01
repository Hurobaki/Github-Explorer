//
//  User.swift
//  Github Explorer
//
//  Created by THE3796 on 31/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import Foundation
import SwiftUI

struct User: Hashable, Identifiable, Decodable {
    var id: Int
    var login: String
    var avatar_url: URL
    var name: String?
}
