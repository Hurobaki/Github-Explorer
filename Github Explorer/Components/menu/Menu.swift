//
//  Menu.swift
//  Github Explorer
//
//  Created by THE3796 on 30/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct Menu : View {
    
    @EnvironmentObject var store: ReposStore
    
    var body: some View {
        ForEach(menuItemData) { item in
            MenuRow(image: item.image, title: item.title).onTapGesture {
                self.store.showTest = .favorites
            }
        }
    }
}

#if DEBUG
struct Menu_Previews : PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
#endif
