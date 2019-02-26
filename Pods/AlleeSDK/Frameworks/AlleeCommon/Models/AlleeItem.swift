//
//  AlleeItem.swift
//  KDS_IOS
//
//  Created by Rodrigo Busata on 20/07/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import Foundation

@objc open class AlleeItem: NSObject, Codable {
    
    @objc open var id: String?
    @objc open var name: String?
    @objc open var buildCard: String?
    @objc open var trainingVideo: String?
    @objc open var preModifier: [String]?
    @objc open var quantity: Int = 1
    @objc open var kDSStation: String?
    @objc open var category: String?
    
    @objc open var condiments: [AlleeCondiment]?
    
    @objc open var summary: AlleeSummary?
    @objc open var itemRecipe: AlleeItemRecipe?
    
    var itemType: ItemType = .regular
    
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
    
    
    @objc open func set(itemType: AlleeItemType) {
        switch itemType {
        case .regular:
            self.itemType = .regular
            
        case .fire:
            self.itemType = .fire
        }
    }
    
    
    @objc public enum AlleeItemType: Int {
        case regular, fire
    }
    
    
    enum ItemType: String, Codable {
        case regular = "REGULAR"
        case fire = "FIRE"
    }
}
