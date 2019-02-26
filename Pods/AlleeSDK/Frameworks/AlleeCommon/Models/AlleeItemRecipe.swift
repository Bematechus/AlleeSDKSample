//
//  AlleeItemRecipe.swift
//  KDS_IOS
//
//  Created by Rodrigo Busata on 09/25/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import Foundation
#if os(tvOS)
import BSocketHelper_tvOS
#else
import BSocketHelper
#endif

@objc open class AlleeItemRecipe: NSObject, Codable {
    
    @objc open var image: String?
    @objc open var ingredients: [String]?
    @objc open var steps: [String]?

    
    @objc open var transType: AlleeTransType = .insert
    
    
    public override init() {
    }
    
    
    func toJson() -> String? {
        return JsonUtil<AlleeItemRecipe>.toJson(self)
    }
    
    
    static func from(json: String) -> AlleeItemRecipe? {
        return JsonUtil<AlleeItemRecipe>.from(json: json)
    }
}
