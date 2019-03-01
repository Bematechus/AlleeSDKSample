//
//  BumpStatus.swift
//  KDS_IOS
//
//  Created by Rodrigo Busata on 11/12/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import Foundation

/*
 When prep station make a bump the status will be PREPARED.
 When expeditor station make a bump the status will be DONE.
 */

@objc public enum AlleeBumpStatus: Int16, Codable {
    
    case new = 0
    case prepared = 1
    case done = 2
}
