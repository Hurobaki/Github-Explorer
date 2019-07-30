//
//  SearchBar.swift
//  Github Explorer
//
//  Created by THE3796 on 23/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            $text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
