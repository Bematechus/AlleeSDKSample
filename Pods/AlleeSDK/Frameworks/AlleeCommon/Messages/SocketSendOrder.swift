//
//  SocketSendOrder.swift
//  KDS_IOS
//
//  Created by Rodrigo Busata on 20/07/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import Foundation
import BSocketHelper

class SocketSendOrder: BaseSocketMessage {
    
    var order: AlleeOrder?
    var orderXML: String?
    
    
    init(guid: String, storeKey: String, order: AlleeOrder?, orderXML: String?, deviceSerial: String) {
        super.init(guid: guid, storeKey: storeKey, type: TypeSocketMessage.sendOrder, originDeviceSerial: deviceSerial)
        self.order = order
        self.orderXML = orderXML
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case order, orderXML
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.order = try container.decode(AlleeOrder?.self, forKey: .order)
        self.orderXML = try container.decode(String?.self, forKey: .orderXML)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
        try container.encode(orderXML, forKey: .orderXML)
        try super.encode(to: encoder)
    }
    
    
    override func toJson() -> String? {
        return JsonUtil<SocketSendOrder>.toJson(self)
    }
    
    
    static func from(json: String) -> SocketSendOrder? {
        return JsonUtil<SocketSendOrder>.from(json: json)
    }
}

extension TypeSocketMessage {
    
    static var sendOrder: String {
        get {
            return "SEND_ORDER"
        }
    }
}
