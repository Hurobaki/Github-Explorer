//
//  UserCard.swift
//  Github Explorer
//
//  Created by THE3796 on 01/08/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

/*
 URLImage(user.avatar_url)
 .resizable().frame(width: 50, height: 50)
 */

import SwiftUI
import URLImage
//.frame(width: 124, height: 124)
struct UserCard: View {
    @State var show = false
    @State private var cornerRadius:CGFloat = 30
    var user: User
    
    var body: some View {
        Button(action: {
            withAnimation(.easeOut(duration: 0.5)) {
                self.cornerRadius = self.cornerRadius == 30 ? 100 : 30
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.show.toggle()
                })
            }
        }) {
            VStack {
                HStack {
                    URLImage(user.avatar_url).resizable().renderingMode(.original).frame(width: 124, height: 124).padding().shadow(radius: 10)
                    VStack {
                        Text(user.login).font(.headline).fontWeight(.bold).foregroundColor(Color.white)
                        Text(user.name ?? "").font(.subheadline).foregroundColor(Color.white)
                    }
                    
                }.frame(width: UIScreen.main.bounds.width - 10, height: 150).background(Color("Color7"))
                
            }
        }.cornerRadius(cornerRadius).shadow(color: Color.gray, radius: 5, x: 0, y: 1).padding(.bottom, 5).sheet(isPresented: $show, content: { Text("User info") })
    }
}

#if DEBUG
struct UserCard_Previews: PreviewProvider {
    static var previews: some View {
        UserCard(user: User(id: 1, login: "Pwet", avatar_url: URL(string: "pwet")!, name: "pwet pwet"))
    }
}
#endif
