//
//  AlleeCondiment.swift
//  KDS_IOS
//
//  Created by Rodrigo Busata on 20/07/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import Foundation

@objc open class AlleeCondiment: NSObject, Codable {
    
    @objc open var id: String?
    @objc open var name: String?
    @objc open var preModifier: [String]?
    
    private var preparationTime_: Double?
    @objc open var preparationTime: NSNumber? {
        set {
            self.preparationTime_ = newValue?.doubleValue
        }
        
        get {
            return NSNumber.init(value: self.preparationTime_ ?? 0)
        }
    }
    
    @objc open var transType: AlleeTransType = .insert
    
    
    public override init() {
    }
}
