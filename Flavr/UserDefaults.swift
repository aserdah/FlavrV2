//
//  UserDefaults.swift
//  UserDefaultsExample
//
//  Created by Training on 12/2/17.
//  Copyright © 2017 example. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    public struct Keys {
        static let username = "username"
        static let password = "password"
    }
    
    // NSCoding
    
    var app_username: String! {
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.username)
        }
        get {
            return UserDefaults.standard.value(forKey: Keys.username) as? String
        }
    }
    
    var app_password: String! {
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.password)
        }
        get {
            return UserDefaults.standard.value(forKey: Keys.password) as? String
        }
    }
    
    
    
}


