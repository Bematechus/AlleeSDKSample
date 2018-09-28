//
//  JsonUtil.swift
//  BLocalSync
//
//  Created by Rodrigo Busata on 31/07/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import Foundation

public struct JsonUtil<T: Codable>  {
    
    public static func from(json: String, ignoreError:Bool=false) -> T? {
        if let jsonData = json.data(using: .utf8) {
            let jsonDecoder = JSONDecoder()
            
            do {
                return try jsonDecoder.decode(T.self, from: jsonData)
                
            } catch {
                if !ignoreError {
                    print(error)
                }
            }
        }
        
        return nil
    }
    
    public static func toJson(_ obj: T, ignoreError:Bool=false) -> String? {
        let jsonEncoder = JSONEncoder()
        
        do {
            let jsonData = try jsonEncoder.encode(obj)
            return String(data: jsonData, encoding: String.Encoding.utf8)
            
        } catch {
            if !ignoreError {
                print(error)
            }
            return nil
        }
    }
}
