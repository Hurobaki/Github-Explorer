//
//  GithubService.swift
//  Github Explorer
//
//  Created by THE3796 on 22/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import Foundation

class GithubService {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let config: EnvironmentConfiguration
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init(), config: EnvironmentConfiguration = .init()) {
        self.session = session
        self.decoder = decoder
        self.config = config
    }
    
    func getUserRepositories(matching user: String, handler: @escaping (Result<[Repository], Error>) -> Void) {
        
        let githubToken: String = config.github_token
        
        guard var urlComponents = URLComponents(string: "\(self.config.github_api_url)/users/\(user)/repos") else {
            preconditionFailure("Can't create url components ...")
        }
        
        urlComponents.queryItems =  [
            URLQueryItem(name: "access_token", value: githubToken)
        ]
        
        guard let url = urlComponents.url else {
            preconditionFailure("Can't create url from url components ...")
        }
        
        self.session.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) -> Data in
                return data
            }
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .sink { (content: [Repository]) -> Void in
                handler(.success(content))
                print(content)
            }
    }
}
