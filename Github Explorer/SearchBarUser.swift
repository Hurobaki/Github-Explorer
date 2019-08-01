//
//  SearchBarUser.swift
//  Github Explorer
//
//  Created by THE3796 on 31/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct SearchUserBar: View {
    @Binding var text: String
    @State var action: () -> Void
    let placerHolder: String
    
    
    var body: some View {
        
        ZStack {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(Color("Color5")).imageScale(.medium)
                TextField(placerHolder, text: $text)
                
                if !text.isEmpty {
                    Button(action: action) {
                        Image(systemName: "xmark.circle.fill").foregroundColor(Color("Color6")).padding(4)
                    }.padding()
                    
                }
                
            }.padding(.leading, 16)
            
        }.frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width - 10, minHeight: 0, maxHeight: 32).background(Color("Color4")).mask(RoundedRectangle(cornerRadius: 50.0))
    }
}

#if DEBUG
struct SearchBarUser_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserBar(text: .constant("pwet"), action: { print("## pwet") }, placerHolder: "pwet")
    }
}
#endif
