//
//  SocketNotifyBump.swift
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

class SocketNotifyBump: BaseSocketMessage {
    
    init(guid: String, storeKey: String, deviceKey: String, deviceSerial: String) {
        super.init(guid: guid, storeKey: storeKey, deviceKey: deviceKey, type: TypeSocketMessage.notifyBump, originDeviceSerial: deviceSerial)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    override func toJson() -> String? {
        return JsonUtil<SocketNotifyBump>.toJson(self)
    }
    
    
    static func from(json: String) -> SocketNotifyBump? {
        return JsonUtil<SocketNotifyBump>.from(json: json)
    }
}

extension TypeSocketMessage {
    
    static var notifyBump: String {
        get {
            return "NOTIFY_BUMP"
        }
    }
}
