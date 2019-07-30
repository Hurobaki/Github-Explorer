//
//  HomeList.swift
//  Github Explorer
//
//  Created by THE3796 on 27/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct HomeList : View {
    
    var listViewItems = listViewItemsData
    
    var body: some View {
        
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Github Explorer").font(.largeTitle).fontWeight(.heavy)
                        Text("Sub presentation").color(.gray)
                    }
                    Spacer()
                }.padding(.leading, 70).padding(.bottom, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(listViewItems) { item in
                            PresentationLink(destination: item.destination) {
                                ListView(title: item.title, image: item.image, color: item.color)
                            }
                            
                            
                        }
                    }
                }.padding(.leading, 40)
                
                Spacer()
                
            }.padding(.top, 78.0)
    }
}


#if DEBUG
struct HomeList_Previews : PreviewProvider {
    static var previews: some View {
        HomeList()
    }
}
#endif
