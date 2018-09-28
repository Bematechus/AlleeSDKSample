//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Rodrigo Busata on 27/09/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
    
    lazy var configItem: SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem()
        item?.title = "You will create the Order \(self.orders.count + 5)"
        return item!
    }()
    
    lazy var orders: [String:String] = {
        return UserDefaults.shared.dictionary(forKey: UserDefaults.ordersKey) as? [String: String] ?? [:]
    }()

    override func isContentValid() -> Bool {
        return true
    }

    override func didSelectPost() {
        var contentText: String = self.contentText
        
        if let content = extensionContext?.inputItems.first as? NSExtensionItem {
            if let attachment = content.attachments?.first {
                attachment.loadItem(forTypeIdentifier: "", options: nil) { (data, error) in
                    if error == nil {
                        contentText = String(data: data as! Data, encoding: .utf8) ?? contentText
                    }
                }
            }
        }
        
        let order = CustomOrder(guid: UUID().uuidString, name: "Order \(orders.count + 5)", xml: contentText)
        self.orders[order.guid] = JsonUtil<CustomOrder>.toJson(order)
        
        UserDefaults.shared.set(self.orders, forKey: UserDefaults.ordersKey)
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        return [self.configItem]
    }
    
}
