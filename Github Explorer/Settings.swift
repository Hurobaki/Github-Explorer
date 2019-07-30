//
//  Settings.swift
//  Github Explorer
//
//  Created by THE3796 on 29/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct Settings : View {
    
    @EnvironmentObject var store: ReposStore
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Toggle(isOn: $store.activateTouchID) {
                        Text("Activate TouchID")
                    }
                }
                
                Section(header: Text("Accessibility")) {
                    Toggle(isOn: $store.activateTouchID) {
                        Text("Activate TouchID")
                    }
                }
                
            }.navigationBarTitle("Settings")
        }
    }
}

#if DEBUG
struct Settings_Previews : PreviewProvider {
    static var previews: some View {
        Settings().environmentObject(ReposStore())
    }
}
#endif
