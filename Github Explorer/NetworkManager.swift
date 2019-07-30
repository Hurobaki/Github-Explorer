//
//  NetworkManager.swift
//  Github Explorer
//
//  Created by THE3796 on 20/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI
import Combine

class NetworkManager: BindableObject {
    let didChange = PassthroughSubject<NetworkManager, Never>()
    
    var repositories = [Repository]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        self.getAllRepositories()
    }
    
    func getAllRepositories() {
        guard let url = URL(string: "https://api.github.com/users/hurobaki/repos") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let repositories = try JSONDecoder().decode([Repository].self, from: data!)
                
                DispatchQueue.main.async {
                    self.repositories = repositories
                }
            } catch {
                print("Failed To decode: ", error)
            }
        }.resume()
    }
}
