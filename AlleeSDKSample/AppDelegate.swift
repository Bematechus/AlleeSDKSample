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
    static var port: Int = 1111
    static var env: Int = 0
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //This block will show the crash error
        NSSetUncaughtExceptionHandler { (exception) in
            print("******************************************************")
            print("FatalError: \(exception)")
            for i in exception.callStackSymbols {
                print("\n\(i)")
            }
            print("******************************************************")
        }
        
        
        AppDelegate.storeKey = UserDefaults.standard.string(forKey: "storeKey")
        AppDelegate.kdsStation = UserDefaults.standard.string(forKey: "kdsStation")
        
        let port = UserDefaults.standard.integer(forKey: "port")
        if port > 0 {
            AppDelegate.port = port
        }
        
        AppDelegate.env = UserDefaults.standard.integer(forKey: "env")
        
        AlleeSDK.shared.start(withStoreKey: AppDelegate.storeKey ?? "", andPort: AppDelegate.port,
                              env: AlleeSDK.Environment(rawValue: AppDelegate.env)!)
    
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
    
    
    static func update(env: Int) {
        AppDelegate.env = env
        
        UserDefaults.standard.set(env, forKey: "env")
        
        
    }
    
    
    static func update(port: Int) {
        AppDelegate.port = port
        
        do {
            try AlleeSDK.shared.update(port: port)
            UserDefaults.standard.set(port, forKey: "port")
            
        } catch {
            print("Failed on change port")
        }
    }
}

extension Bundle {
    
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
