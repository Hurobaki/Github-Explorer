//
//  EnvironmentConfiguration.swift
//  Github Explorer
//
//  Created by THE3796 on 22/07/2019.
//  Copyright © 2019 Firelabs. All rights reserved.
//

import Foundation


final class EnvironmentConfiguration {
    private let config: NSDictionary
    
    static let shared = EnvironmentConfiguration()
    
    private init(dictionary: NSDictionary) {
        config = dictionary
    }
    
    private convenience init() {
        let bundle = Bundle.main
        let configPath = bundle.path(forResource: "config", ofType: "plist")!
        let config = NSDictionary(contentsOfFile: configPath)!
        
        let dict = NSMutableDictionary()
        
        if let environment = bundle.infoDictionary!["ConfigEnvironment"] as? String {
            if let environmentConfig = config[environment] as? [AnyHashable: Any] {
                dict.addEntries(from: environmentConfig)
            }
        }
        
        self.init(dictionary: dict)
    }
    
}

extension EnvironmentConfiguration {
     var github_token: String {
        return config["GithubPersonalToken"] as! String
    }
    
    var github_api_url: String {
        return config["GithubApiUrl"] as! String
    }
    
    var email_support: String {
        return config["EmailSupport"] as! String
    }
}
