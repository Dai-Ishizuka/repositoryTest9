//
//  UserDataManager.swift
//  Learning
//
//  Created by Playground, Inc. on 2018/11/04.
//  Copyright © 2018 Playground, Inc.. All rights reserved.
//

import UIKit

enum UserDataKey: String {
    case XXXX
    
}

class UserDataManager {
    // Save
    static func saveXXXX(_ value: String) {
        UserDefaults.standard.set(value, forKey: UserDataKey.XXXX.rawValue)
    }
    
    // Load
    static func loadXXXX() -> String? {
        return UserDefaults.standard.string(forKey: UserDataKey.XXXX.rawValue)
    }
    
}
