//
//  AppDelegate.swift
//  AlleeSDKSample
//
//  Created by Rodrigo Busata on 27/07/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import UIKit
import AlleeSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static var storeKey: String?
    static var kdsStation: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let storeKey = UserDefaults.standard.string(forKey: "storeKey") {
            AppDelegate.storeKey = storeKey
            
        } else {
            AppDelegate.storeKey = "2bc66783-b168-4968-8a50-906b15dfbcf8"
            UserDefaults.standard.set(AppDelegate.storeKey!, forKey: "storeKey")
        }
        
        if let kdsStation = UserDefaults.standard.string(forKey: "kdsStation") {
            AppDelegate.kdsStation = kdsStation
        }
        
        AlleeSDK.shared.start(withStoreKey: AppDelegate.storeKey ?? "")
    
        return true
    }
    
    
    static func update(storeKey: String?) {
        AppDelegate.storeKey = storeKey
        
        UserDefaults.standard.set(storeKey, forKey: "storeKey")
        AlleeSDK.shared.update(storeKey: storeKey ?? "")
    }
    
    
    static func update(kdsStation: String?) {
        AppDelegate.kdsStation = kdsStation
        
        UserDefaults.standard.set(kdsStation, forKey: "kdsStation")
    }
}

