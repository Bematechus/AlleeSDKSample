//
//  UserDefaults+Allee.swift
//  ShareExtension
//
//  Created by Rodrigo Busata on 27/09/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static var shared: UserDefaults {
        get {
            return UserDefaults(suiteName: "group.allee")!
        }
    }
    
    static var ordersKey: String {
        get {
            return "ordersKey"
        }
    }
}
