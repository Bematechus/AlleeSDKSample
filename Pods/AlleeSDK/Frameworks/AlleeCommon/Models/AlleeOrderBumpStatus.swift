//
//  AlleeOrderBumpStatus.swift
//  KDS_IOS
//
//  Created by Rodrigo Busata on 11/12/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import Foundation

@objc open class AlleeOrderBumpStatus: NSObject, Codable {
    
    public var guid: String?
    public var id: String?
    public var status: AlleeBumpStatus?
}
