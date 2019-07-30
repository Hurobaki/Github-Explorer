//
//  ListView.swift
//  Github Explorer
//
//  Created by THE3796 on 30/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI


struct ListView : View {
    
    var title: String
    var image: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .color(.white)
                .padding(25)
                .lineLimit(4)
                .padding(.trailing, 30)
            Spacer()
            Image(image)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width: 246, height: 150)
                .padding(.bottom, 30)
        }
        .background(color)
        .cornerRadius(30)
        .frame(width: 246, height: 360)
        .padding(.trailing, 16)
        
    }
}

struct ListViewItem: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var color: Color
    var destination: AnyView
}

let listViewItemsData = [
    ListViewItem(title: "See all of your repositories", image: "Repos", color: Color("Card2"), destination: AnyView(Text("pwet"))),
    ListViewItem(title: "What can you do ?", image: "Javascript", color: Color("Card1"), destination: AnyView(InformationView())),
    ListViewItem(title: "Most starred Github repositories", image: "Javascript", color: Color.gray, destination: AnyView(Text("pwet3")))
]

#if DEBUG
struct ListView_Previews : PreviewProvider {
    static var previews: some View {
        ListView(title: "pwet", image: "star", color: Color.blue)
    }
}
#endif
