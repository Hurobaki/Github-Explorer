//
//  TabBar.swift
//  Github Explorer
//
//  Created by THE3796 on 28/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct TabBar : View {
    
    @EnvironmentObject var store: ReposStore
    //@State private var selection = 1
    
    var body: some View {
        TabbedView {
            RepositoryList().environmentObject(store).tabItem({
                Image(systemName: "magnifyingglass").imageScale(.large)
                Text("Search")
            }).tag(0)
            
            Home().environmentObject(store).tabItem({
                Image(systemName: "house").imageScale(.large)
                Text("Home")
            }).tag(1)
            
            Settings().environmentObject(store).tabItem({
                Image(systemName: "gear").imageScale(.large)
                Text("Settings")
            }).tag(2)
            
        }.edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct TabBar_Previews : PreviewProvider {
    static var previews: some View {
        TabBar().environmentObject(ReposStore())
    }
}
#endif
