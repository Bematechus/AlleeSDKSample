//
//  SocketOrdersBumpResponse.swift
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

class SocketOrdersBumpResponse: BaseSocketMessage {
    
    var ordersBumpStatus: [AlleeOrderBumpStatus]?
    var lastUpdateTime: Double?
    
    
    init(guid: String, storeKey: String, deviceKey: String, ordersBumpStatus: [AlleeOrderBumpStatus]?, lastUpdateTime: Double?, deviceSerial: String) {
        super.init(guid: guid, storeKey: storeKey, deviceKey: deviceKey, type: TypeSocketMessage.ordersBumpResponse, originDeviceSerial: deviceSerial)

        self.lastUpdateTime = lastUpdateTime
        self.ordersBumpStatus = ordersBumpStatus
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case ordersBumpStatus, lastUpdateTime
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ordersBumpStatus = try container.decode([AlleeOrderBumpStatus]?.self, forKey: .ordersBumpStatus)
        self.lastUpdateTime = try container.decode(Double?.self, forKey: .lastUpdateTime)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(ordersBumpStatus, forKey: .ordersBumpStatus)
        try container.encode(lastUpdateTime, forKey: .lastUpdateTime)
        try super.encode(to: encoder)
    }
    
    
    override func toJson() -> String? {
        return JsonUtil<SocketOrdersBumpResponse>.toJson(self)
    }
    
    
    static func from(json: String) -> SocketOrdersBumpResponse? {
        return JsonUtil<SocketOrdersBumpResponse>.from(json: json)
    }
}

extension TypeSocketMessage {
    
    static var ordersBumpResponse: String {
        get {
            return "ORDER_BUMP_RESPONSE"
        }
    }
}
