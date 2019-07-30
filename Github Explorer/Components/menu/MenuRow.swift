//
//  MenuRow.swift
//  Github Explorer
//
//  Created by THE3796 on 28/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct MenuRow : View {
    
    var image: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: image).imageScale(.large).frame(width: 32, height: 32).foregroundColor(Color.gray)
            Text(title).font(.headline).foregroundColor(.primary)
            Spacer()
        }
    }
}

#if DEBUG
struct MenuRow_Previews : PreviewProvider {
    static var previews: some View {
        MenuRow(image: "circle", title: "Circle")
    }
}
#endif
