//
//  HomeList.swift
//  Github Explorer
//
//  Created by THE3796 on 27/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

// padding(.leading, 70).padding(.bottom, 30)

/*
 VStack {
 HStack {
 VStack(alignment: .leading) {
 Text(verbatim: "Github Explorer").font(.largeTitle).fontWeight(.heavy)
 Text(verbatim: "Sub presentation").foregroundColor(Color.gray)
 }
 Spacer()
 }.padding()
 */

/*

 */

struct HomeList : View {
    
    var listViewItems = listViewItemsData
    
    @State var show = false
    @State var view: AnyView = AnyView(Text(""))
    
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Github Explorer").font(.system(size: 22)).fontWeight(.bold).lineLimit(nil)
                    Text("Sub presentation").foregroundColor(Color.gray).lineLimit(nil)
                }
                Spacer()
            }.padding(.leading, 60).padding(.bottom, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(listViewItems) { item in
                        GeometryReader { geometry in
                            Button(action: {
                                self.show.toggle()
                                self.view = item.destination
                            }) {
                                ListView(title: item.title, image: item.image, color: item.color, destination: item.destination)
                                    .rotation3DEffect(Angle(degrees: Double((geometry.frame(in: .global).minX - 30) / -30)), axis: (x: 0, y: 10, z: 0))
                            }
                        }.frame(width: 246, height: 360)
                    }
                }.padding(30)
                Spacer()
            }.frame(width: UIScreen.main.bounds.width, height: 480)
                .sheet(isPresented: self.$show, content: { self.view })
            
        }.padding(.top, 65)
    }
}

//.padding(.leading, 40)

#if DEBUG
struct HomeList_Previews : PreviewProvider {
    static var previews: some View {
        HomeList()
    }
}
#endif
