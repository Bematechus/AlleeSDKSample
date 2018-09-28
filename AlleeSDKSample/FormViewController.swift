//
//  FormViewController.swift
//  AlleeSDKSample
//
//  Created by Rodrigo Busata on 27/09/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var deleteView: UIView!
    
    var order: CustomOrder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeKeyboard)))
        
        if let order = order {
            self.textView.text = order.xml
            self.nameTf.text = order.name
            
            self.title = "Edit Order"
            
        } else {
            self.deleteView.isHidden = true
            self.textViewDidEndEditing(self.textView)
        }
        
        self.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: UIScreen.main.bounds.height / 2, right: 0)
    }
    
    @IBAction func actionSave(_ sender: Any) {
        if self.textView.text.isEmpty {
            let alert = UIAlertController(title: "Please fill the name",message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        var orders = UserDefaults.shared.dictionary(forKey: UserDefaults.ordersKey) as? [String: String] ?? [:]
        
        let order = self.order ?? CustomOrder(guid: UUID().uuidString, name: "", xml: "")
        order.xml = self.textView.text
        order.name = self.nameTf.text ?? ""
        orders[order.guid] = JsonUtil<CustomOrder>.toJson(order)
        
        UserDefaults.shared.set(orders, forKey: UserDefaults.ordersKey)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func closeKeyboard() {
        self.view.endEditing(false)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Order XML\n\nYou can use \(CustomOrder.Key.orderId.rawValue) to dynamic "
                + "order id \nand \(CustomOrder.Key.stationId.rawValue) to dynamic station id"
            
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func actionDelete(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete Order",
                                      message: "Are you sure to want to delete \(self.order?.name ?? "")?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            var orders = UserDefaults.shared.dictionary(forKey: UserDefaults.ordersKey) as? [String: String] ?? [:]
            orders.removeValue(forKey: self.order?.guid ?? "")
            
            UserDefaults.shared.set(orders, forKey: UserDefaults.ordersKey)
            
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
