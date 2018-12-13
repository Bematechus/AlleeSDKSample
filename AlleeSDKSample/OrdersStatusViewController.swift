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
    
    var orders: [AlleeOrder] = []
    var ordersStatus: [AlleeOrderBumpStatus] = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.visualEffectView.layer.cornerRadius = 9.0
        self.visualEffectView.clipsToBounds = true
        
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    func add(order: AlleeOrder) {
        self.orders.append(order)
        self.tableView.reloadData()
    }
    
    
    func update(ordersStatus: [AlleeOrderBumpStatus]) {
        for orderStatus in ordersStatus {
            if let index = self.ordersStatus.firstIndex(where: {$0.id == orderStatus.id}) {
                self.ordersStatus[index] = orderStatus
                
            } else {
                self.ordersStatus.append(orderStatus)
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
        return self.orders.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderStatusCell
        let order = self.orders[indexPath.row]
        cell.titleLb.text = "#\(order.id ?? "")"
        
        if let status = self.status(byOrder: order) {
            cell.statusLb.text = status
            cell.statusLb.textColor = UIColor(named: "blue")
            
        } else {
            cell.statusLb.text = "UNKNOWN"
            cell.statusLb.textColor = .red
        }
        
        return cell
    }
    
    
    private func status(byOrder order: AlleeOrder) -> String? {
        if let status = self.ordersStatus.first(where: {$0.id == order.id})?.status {
            return status == .new ? "DOING" : status == .prepared ? "PREAPRED" : "DELIVERED"
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
