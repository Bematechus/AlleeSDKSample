//
//  SocketOrdersBumpRequest.swift
//  KDS_IOS
//
//  Created by Rodrigo Busata on 12/12/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import Foundation
#if os(tvOS)
import BSocketHelper_tvOS
#else
import BSocketHelper
#endif

class SocketOrdersBumpRequest: BaseSocketMessage {
    
    var lastUpdateTime: Double?
    
    
    init(guid: String, storeKey: String, deviceKey: String, lastUpdateTime: Double?, deviceSerial: String) {
        super.init(guid: guid, storeKey: storeKey, deviceKey: deviceKey, type: TypeSocketMessage.ordersBumpRequest, originDeviceSerial: deviceSerial)
        self.lastUpdateTime = lastUpdateTime
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case lastUpdateTime
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lastUpdateTime = try container.decode(Double?.self, forKey: .lastUpdateTime)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lastUpdateTime, forKey: .lastUpdateTime)
        try super.encode(to: encoder)
    }
    
    
    override func toJson() -> String? {
        return JsonUtil<SocketOrdersBumpRequest>.toJson(self)
    }
    
    
    static func from(json: String) -> SocketOrdersBumpRequest? {
        return JsonUtil<SocketOrdersBumpRequest>.from(json: json)
    }
}

extension TypeSocketMessage {
    
    static var ordersBumpRequest: String {
        get {
            return "ORDERS_BUMP_REQUEST"
        }
    }
}
