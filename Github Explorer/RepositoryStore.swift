//
//  RepositoryStore.swift
//  Github Explorer
//
//  Created by THE3796 on 22/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI
import Combine

enum MenuOpen {
    case menu
    case profile
    case none
}

class ReposStore: BindableObject {
    
    private let config: EnvironmentConfiguration
    private let service: GithubService
    private var cancellable: AnyCancellable? = nil
    
    let didChange = PassthroughSubject<Void, Never>()
    
    init(config: EnvironmentConfiguration = .init(), service: GithubService = .init()) {
        self.config = config
        self.service = service
        
        cancellable = AnyCancellable($searchText
            .removeDuplicates()
            .debounce(for: 0.8, scheduler: DispatchQueue.main)
            .sink { repoUserName in
                self.service.getUserRepositories(matching: repoUserName) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                            case .success(let repos): self?.repos = repos
                            case .failure(let error): self?.error = error.localizedDescription
                        }
                    }
                }
            }
        )
    }
    
    @Published var searchText: String = ""
    
    var repos: [Repository] = [Repository(id: 1, name: "Pwet")] {
        didSet {
            didChange.send()
        }
    }
    
    var error: String = "" {
        didSet {
            didChange.send()
        }
    }
    
    var activateTouchID: Bool = false {
        didSet {
            didChange.send()
        }
    }
    
    var showTest: MenuOpen = .none {
        didSet {
            didChange.send()
        }
    }
}


    /*
 
    
    func getUserRepositories(matching user: String, handler: @escaping (Result<[Repository], Error>) -> Void) {
        
        let githubToken: String = config.github_token
        
        guard var urlComponents = URLComponents(string: "https://api.github.com/users/hurobaki/repos") else {
            preconditionFailure("Can't create url components ...")
        }
        
        urlComponents.queryItems =  [
            URLQueryItem(name: "access_token", value: githubToken)
        ]
        
        guard let url = urlComponents.url else {
            preconditionFailure("Can't create url from url components ...")
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, res, error in
            
            if let error = error {
                handler(.failure(error))
            } else {
                
                if let httpResponse = res as? HTTPURLResponse {
                    if httpResponse.statusCode > 200 {
                        handler(.failure(NSError(domain:"", code:httpResponse.statusCode, userInfo:nil)))
                    }
                }
                
                do {
                    if let data = data {
                        let response = try JSONDecoder().decode([Repository].self, from: data)
                        handler(.success(response ?? [] ))
                    } else {
                        preconditionFailure("Can't create url from url components ...")
                    }
                    
                } catch {
                    handler(.failure(error))
                }
            }
            
        }.resume()
        
    }
 
 */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    enum APIError: Error, LocalizedError {
        case unknown, apiError(reason: String)
        
        var errorDescription: String? {
            switch self {
            case .unknown:
                return "Unknown error"
            case .apiError(let reason):
                return reason
            }
        }
    }
    
   
    
    
    /*
     func fetch(_ name: String) -> AnyPublisher<Data, Never> {
     
     let request = URLRequest(url: URL(string: "https://api.github.com/users/hurobaki/repos")!)
     
     return URLSession.DataTaskPublisher(request: request, session: .shared)
     .tryMap { data, response in
     guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
     throw APIError.unknown
     }
     print("RESPONSE \(httpResponse)")
     return data
     }
     .mapError { error in
     if let error = error as? APIError {
     return error
     } else {
     return APIError.apiError(reason: error.localizedDescription)
     }
     }
     .eraseToAnyPublisher()
     }
     */
   


