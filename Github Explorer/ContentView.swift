//
//  ContentView.swift
//  Github Explorer
//
//  Created by THE3796 on 20/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @EnvironmentObject var networkManager: NetworkManager
    
    var body: some View {
        VStack {
            Button(action: {
                self.networkManager.getAllRepositories()
            }, label: {
                Text("Get All Courses")
            })
            
            List(networkManager.repositories) {
                Text($0.name)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(NetworkManager())
    }
}
#endif
