//
//  Repository.swift
//  Github Explorer
//
//  Created by THE3796 on 20/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI
import Foundation

struct Repository: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let fork: Bool
    let language: Language?
    let owner: Owner
    let description: String?
    let stars: Int
    let created: String
    let updated: String

    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, name, fork, language, owner, description
        case stars = "stargazers_count"
        case created = "created_at"
        case updated = "updated_at"
    }
    
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.language = .javascript
        self.fork = false
        self.owner = Owner()
        self.description = "Repository description for Github repository"
        self.stars = 0
        self.created = ""
        self.updated = ""
    }
    
    
    func image() -> String {
        var image = "Default"
        
        if let language = self.language {
            let imageName = self.getImageName(language.rawValue)
            
            if let _ = UIImage(named: imageName) {
                image = imageName
            }
        }
        
        return image
    }
    
    func getDate(from date: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = df.date(from: date)!
        df.dateFormat = "dd/MM/yyyy"
        return df.string(from: date)
    }
    
    private func getImageName(_ language: String) -> String {
        language.lowercased().capitalizingFirstLetter()
    }
    
    enum Language: String, CaseIterable, Codable, Hashable {
        case javascript = "JavaScript"
        case java = "Java"
        case dart = "Dart"
        case shell = "Shell"
        case csharp = "C#"
        case css = "CSS"
        case php = "PHP"
        case html = "HTML"
        case pyhton = "Python"
        case emacs = "Emacs Lisp"
        case objc = "Objective-C"
        case haskell = "Haskell"
        case ruby = "Ruby"
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
