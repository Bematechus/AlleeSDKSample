//
//  CustomOrder.swift
//  AlleeSDKSample
//
//  Created by Rodrigo Busata on 27/09/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import Foundation

@objc class CustomOrder: NSObject, Codable {
    
    @objc var guid: String
    @objc var name: String
    @objc var xml: String
    @objc var createTime: Int
    
    init(guid: String, name: String, xml: String) {
        self.guid = guid
        self.name = name
        self.xml = xml
        self.createTime = Int(Date().timeIntervalSince1970)
    }
    
    enum Key: String {
        case orderId = "[ORDER_ID]"
        case stationId = "[STATION_ID]"
    }
}
