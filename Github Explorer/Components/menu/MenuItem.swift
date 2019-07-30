//
//  MenuItem.swift
//  Github Explorer
//
//  Created by THE3796 on 30/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let image: String
}

let menuItemData = [
    MenuItem(title: "My account", image: "person.crop.circle")
]
