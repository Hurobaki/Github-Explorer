//
//  Extensions.swift
//  Github Explorer
//
//  Created by THE3796 on 31/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift

enum URLSessionError: Error {
    case invalidResponse
    case serverErrorMessage(statusCode: Int, data: Data)
    case urlError(URLError)
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func cleaningIllegalCharacter() -> String {
        return filter { !" \n\t\r".contains($0) }
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    mutating func cleanIllegalCharacter() {
        self = self.cleaningIllegalCharacter()
    }
}

extension URLSession {
    
    func send(request: URLRequest) -> AnyPublisher<Data, URLSessionError> {
        dataTaskPublisher(for: request)
            .mapError { URLSessionError.urlError($0) }
            .flatMap { data, response -> AnyPublisher<Data, URLSessionError> in
                guard let response = response as? HTTPURLResponse else {
                    print("### FLAG2")
                    return .fail(.invalidResponse)
                }
                
                guard 200..<300 ~= response.statusCode else {
                    print("### FLAG3")
                    return .fail(.serverErrorMessage(statusCode: response.statusCode,
                                                     data: data))
                }
                
                return .just(data)
        }.eraseToAnyPublisher()
    }
}

extension Publisher {

    static func empty() -> AnyPublisher<Output, Failure> {
        return Empty()
            .eraseToAnyPublisher()
    }

    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }

    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        let array = Array(self) as! [T]
        return array
    }
}
