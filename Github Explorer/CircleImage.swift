//
//  CircleImage.swift
//  swiftui-playground
//
//  Created by THE3796 on 15/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI


struct CircleImage: View {
    var image: Image
    
    var body: some View {
        
        image.resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50).clipShape(Circle()).overlay(Circle().stroke(Color.gray, lineWidth: 4)).shadow(radius: 5)
    }
}


struct CircleImage_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            CircleImage(image: Image("Default"))
            CircleImage(image: Image("Javascript"))
        }
    }
}
