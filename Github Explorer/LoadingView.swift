//
//  LoadingView.swift
//  Github Explorer
//
//  Created by THE3796 on 31/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI

struct LoadingView : UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    func makeUIView(context: UIViewRepresentableContext<LoadingView>) -> LoadingView.UIViewType {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: LoadingView.UIViewType, context: UIViewRepresentableContext<LoadingView>) {
        //Todo
    }
}
