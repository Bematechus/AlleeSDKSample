//
//  OrdersStatusViewController.swift
//  AlleeSDKSample
//
//  Created by Rodrigo Busata on 12/12/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import UIKit
import AlleeSDK

class OrdersStatusViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var tableView: UITableView!
    
    var ordersIds: [String] = []
    var ordersStatus: [AlleeOrderBumpStatus] = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.visualEffectView.layer.cornerRadius = 9.0
        self.visualEffectView.clipsToBounds = true
        
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    func add(orderId: String) {
        self.ordersIds.append(orderId)
        self.tableView.reloadData()
    }
    
    
    func update(ordersStatus: [AlleeOrderBumpStatus]) {
        for orderStatus in ordersStatus {
            if let index = self.ordersStatus.firstIndex(where: {$0.id == orderStatus.id}) {
                self.ordersStatus[index] = orderStatus
                
            } else {
                self.ordersStatus.append(orderStatus)
            }
            
            if let status = self.status(byOrderId: orderStatus.id) {
                AppDelegate.showNotification(title: "Your order was updated",
                                             message: "The order #\(orderStatus.id ?? "") was changed to \(status)")
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func actionRefresh(_ sender: Any) {
        AlleeSDK.shared.requestOrdersStatus { (error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ordersIds.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderStatusCell
        let orderId = self.ordersIds[indexPath.row]
        cell.titleLb.text = "#\(orderId)"
        
        if let status = self.status(byOrderId: orderId) {
            cell.statusLb.text = status
            cell.statusLb.textColor = UIColor(named: "blue")
            
        } else {
            cell.statusLb.text = "UNKNOWN"
            cell.statusLb.textColor = .red
        }
        
        return cell
    }
    
    
    private func status(byOrderId orderId: String?) -> String? {
        if let status = self.ordersStatus.first(where: {$0.id == orderId})?.status {
            return status == .new ? "DOING" : status == .prepared ? "PREPARED" : "DELIVERED"
        }
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

class OrderStatusCell: UITableViewCell {
    
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var statusLb: UILabel!
}
