//
//  Repository.swift
//  Github Explorer
//
//  Created by THE3796 on 20/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import SwiftUI
import Foundation
import Combine
import RealmSwift
import Realm



class Repository: Object, Decodable, Identifiable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var fork: Bool = false
    
    @objc dynamic private var privateLanguage: String? = Language.none.rawValue
    var language: Language? {
        get { return Language(rawValue: privateLanguage ?? Language.none.rawValue) }
        set { privateLanguage = newValue?.rawValue ?? Language.none.rawValue }
    }
    
    @objc dynamic var owner: Owner? = Owner()
    @objc dynamic var desc: String? = nil
    @objc dynamic var stars: Int = 0
    @objc dynamic var created: String = ""
    @objc dynamic var updated: String = ""
    var isFavorite: Bool = false {
        didSet {
            if self.isFavorite {
                print("### DID SET TRUE \(self.isFavorite)")
                RealmService.shared.add(object: self)
            } else {
                
                print("### DID SET FALSE \(self.isFavorite)")
                RealmService.shared.delete(object: self, id: id)
                
            }
            
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, fork, owner
        case stars = "stargazers_count"
        case created = "created_at"
        case updated = "updated_at"
        case desc = "description"
        case privateLanguage = "language"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init (id: Int, name: String, isFavorite: Bool, fork: Bool, language: String?, owner: Owner?, description: String?, stars: Int, created: String, updated: String) {
        self.init()
        self.id = id
        self.name = name
        self.privateLanguage = language
        self.fork = fork
        self.owner = owner
        self.desc = description
        self.stars = stars
        self.created = created
        self.updated = updated
        self.isFavorite = isFavorite
    }
    
    convenience init (id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let fork = try container.decode(Bool.self, forKey: .fork)
        let owner = try container.decode(Owner?.self, forKey: .owner)
        let description = try container.decode(String?.self, forKey: .desc)
        let language = try container.decode(String?.self, forKey: .privateLanguage)
        let created = try container.decode(String.self, forKey: .created)
        let updated = try container.decode(String.self, forKey: .updated)
        let stars = try container.decode(Int.self, forKey: .stars)
        
        let isFavorite: Bool = RealmService.shared.isPresent(type: Repository.self, id: id)
        
        
        self.init(id: id, name: name, isFavorite: isFavorite, fork: fork, language: language, owner: owner, description: description, stars: stars, created: created, updated: updated)
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
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
        case swift = "Swift"
        case cpp = "C++"
        case vimscript = "Vim script"
        case webass = "WebAssembly"
        case c = "C"
        case perl = "Perl"
        case none = "None"
    }
}

extension Repository {
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
}
