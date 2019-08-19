//
//  RepositoryStore.swift
//  Github Explorer
//
//  Created by THE3796 on 22/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI
import Combine
import RealmSwift

enum MenuOpen {
    case menu
    case profile
    case favorites
    case none
}

enum UIStatus {
    case loading
    case done
}

class ReposStore: ObservableObject {
    
    private var cancellable: AnyCancellable? = nil
    private var showLoader: AnyCancellable? = nil
    private var searchCancellable: AnyCancellable? = nil
    
    /// Constructor with EnvironmentConfiguration parameter
    /// - Parameter config: NSDictionary from config.plist file
    init() {
        /// Listener for searchText variable use with SearchBar
        cancellable = AnyCancellable(
            $searchText
                .removeDuplicates()
                .debounce(for: 0.8, scheduler: DispatchQueue.main)
                .sink { _ in
                    self.searchUser()
                    self.searchUserRepositories()
        })
        
        showLoader = AnyCancellable($searchText.removeDuplicates().sink { _ in
            self.repositories = []
            self.uiStatus = .loading
            self.errorMessage = ""
            
        })
        
        favoriteRepositories = RealmService.shared.foo(of: Repository.self)
    }
    
    @Published var uiStatus: UIStatus = .done
    
    @Published var searchText: String = "Hurobaki"
    
    @Published var user: User? = nil
    
    @Published var repositories: [Repository] = []
    
    @Published var favoriteRepositories: [Repository] = []
    
    @Published var errorMessage: String = ""
    
    @Published var activateTouchID: Bool = false
    
    @Published var showTest: MenuOpen = .none
    
    @Published var test: Bool = false
    
    private var searchReposCancellable: AnyCancellable?
    
    deinit {
        searchCancellable?.cancel()
        searchReposCancellable?.cancel()
        cancellable?.cancel()
    }
    
    func searchUser() {
        /*
         guard !searchText.isEmpty else {
         return repos = []
         }
         */
        var urlComponents = URLComponents(string: "https://api.github.com/users/\(searchText)")!
        
         urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: EnvironmentConfiguration.shared.github_token)
         ]
         
        
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        searchCancellable = URLSession.shared.send(request: request)
            .decode(type: User.self, decoder: JSONDecoder())
            .map { $0 }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.user, on: self)
    }
    
    
    
    func searchUserRepositories() {
        
        guard !searchText.isEmpty else {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.uiStatus = .done
            }
            
            return repositories = []
        }
        
        searchText = searchText.cleaningIllegalCharacter()
        
        var urlComponents = URLComponents(string: "https://api.github.com/users/\(searchText)/repos")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: EnvironmentConfiguration.shared.github_token)
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        searchCancellable = URLSession.shared.send(request: request)
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.uiStatus = .done
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("### received error: ", error)
                    let error = getErrorType(error: error)
                    self.errorMessage = error.errorDescription!
                   
                }
            }, receiveValue: { repositories in
                self.repositories = repositories
            })
    }
}

func getErrorType(error: Error) -> APIError {
    if let error = error as? DecodingError {
        var errorToReport = error.localizedDescription
        
        switch error {
        case .dataCorrupted(let context):
            let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
            errorToReport = "\(context.debugDescription) - (\(details))"
        case .typeMismatch(let type, let context), .valueNotFound(let type, let context):
            let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
            errorToReport = "\(context.debugDescription) (type: \(type), \(details))"
        case .keyNotFound(let key, let context):
            let details = context.underlyingError?.localizedDescription ?? context.codingPath.map { $0.stringValue }.joined(separator: ".")
            errorToReport = "\(context.debugDescription) (key: \(key), \(details))"
        @unknown default:
            break
        }
        return APIError.parserError(reason: errorToReport)
        
    } else if let error = error as? URLSessionError {
        var errorToReport = error.localizedDescription
    
        switch error {
        case .serverErrorMessage(let status, _):
            if status == 404 {
                errorToReport = "User not found."
            } else {
                errorToReport = "Need to unwrap data"
            }
        case .invalidResponse:
            print("### Invalid Response")
            errorToReport = "Invalid Response"
        case .urlError(_):
            print("### URL Error")
            errorToReport = "URL Error"
        }
        return APIError.apiError(reason: errorToReport)
    } else {
        return APIError.apiError(reason: error.localizedDescription)
    }
}

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String), parserError(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason), .parserError(let reason):
            return reason
        }
    }
}
