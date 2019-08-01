//
//  Home.swift
//  Github Explorer
//
//  Created by THE3796 on 26/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct Home : View {
    
    @State var show: Bool = false
    @ObservedObject var store: ReposStore
    
    var body: some View {
        
        ZStack {
            
            
            HomeList()
                .blur(radius: show ? 20 : 0)
                .animation(.easeInOut(duration: 0.6))
            
            
            MenuButton(store: store)
                .offset(x: -40, y: 80)
                .animation(.spring())
            
            MenuView(store: store)
            
           
            
        }
    }
}

#if DEBUG
struct Home_Previews : PreviewProvider {
    static var previews: some View {
        Home(store: ReposStore())
    }
}
#endif

struct MenuView : View {
    
    
    @ObservedObject var store: ReposStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Menu().environmentObject(store)
            Spacer()
        }
            .padding(.top, 20)
            .padding(30)
            .padding(.bottom, 50)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: UIScreen.main.bounds.height - 150)
            .background(BlurView(style: .systemThickMaterial))
            .cornerRadius(30)
            .padding(.trailing, 60)
            .shadow(radius: 20)
            .rotation3DEffect(Angle(degrees: store.showTest == MenuOpen.menu ? 0 : 60), axis: (x: 0, y: 10, z:0))
            .animation(.easeInOut(duration: 0.2))
            .offset(x: store.showTest == MenuOpen.menu ? 0 : -UIScreen.main.bounds.width)
            .onTapGesture {
                self.store.showTest = MenuOpen.none
            
        }
        
    }
}

struct MenuButton : View {
    
    @ObservedObject var store: ReposStore
    
    var body: some View {
        return ZStack(alignment: .topLeading) {
            Button(action: { self.store.showTest = MenuOpen.menu }) {
                HStack {
                    Spacer()
                    Image(systemName: "list.dash")
                        .foregroundColor(.primary)
                }
                .padding(.trailing, 20)
                    .frame(width: 90, height: 60)
                    .background(BlurView(style:.systemThickMaterial))
                    .cornerRadius(30)
                    .shadow(radius: 10)
                
            }
            Spacer()
            
        }
    }
}
