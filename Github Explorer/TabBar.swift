//
//  TabBar.swift
//  Github Explorer
//
//  Created by THE3796 on 28/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

/*
 RepositoryList().environmentObject(store).tabItem({
     Image(systemName: "magnifyingglass").imageScale(.large)
     Text("Search")
 }).tag(0)
 */

import SwiftUI

struct TabBar : View {
    
    @ObservedObject var store: ReposStore
    @State private var selection: Int = 1
    
    var body: some View {
        TabView(selection: $selection) {
            RepositoryList(store:store).tabItem({
                Image(systemName: "magnifyingglass").imageScale(.large)
                Text("Search")
            }).tag(0)
            
            Home(store: store).tabItem({
                Image(systemName: "house").imageScale(.large)
                Text("Home")
            }).tag(1)
            
            Settings(store: store).tabItem({
                Image(systemName: "gear").imageScale(.large)
                Text("Settings")
            }).tag(2).foregroundColor(Color.red)
            
            }.edgesIgnoringSafeArea(.top)
    }
}

#if DEBUG
struct TabBar_Previews : PreviewProvider {
    static var previews: some View {
        TabBar(store: ReposStore())
    }
}
#endif
