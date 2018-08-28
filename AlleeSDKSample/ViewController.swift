//
//  ViewController.swift
//  AlleeSDKSample
//
//  Created by Rodrigo Busata on 27/07/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import UIKit
import AlleeSDK

class ViewController: UIViewController {
    
    @IBOutlet weak var tfStoreKey: UITextField!
    @IBOutlet weak var tfPort: UITextField!
    @IBOutlet weak var tfStation: UITextField!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var segEnv: UISegmentedControl!
    @IBOutlet weak var lbVersion: UILabel!
    
    private var layouts = 8
    private var nextOrderId = arc4random_uniform(1000000 - 1) + 1
    
    private var destination = "DiningIn"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.tfStoreKey.text = AppDelegate.storeKey
        self.tfStoreKey.delegate = self
        
        self.tfPort.text = "\(AppDelegate.port)"
        self.tfPort.delegate = self
        
        self.tfStation.text = AppDelegate.kdsStation
        self.tfStation.delegate = self
        
        self.segEnv.selectedSegmentIndex = AppDelegate.env
        
        if let version = Bundle.main.releaseVersionNumber,
            let build = Bundle.main.buildVersionNumber {
            
            self.lbVersion.text = "v\(version) (\(build))"
            
        } else {
            self.lbVersion.text = ""
        }
    }
    
    
    private func sendOrder1() {
        let order = self.order(withItems: [
            self.item("Veggie Burger", qty: 1, condiments: [
                self.condiment("Lettuce"),
                self.condiment("Tomatoes"),
                self.condiment("Pickles"),
                self.condiment("Hot Pepper Relish")
                ], summary: self.summary("Soy burger", qty: 2)),
            
            self.item("French Fries", qty: 2, condiments: [
                self.condiment("Mayonnaise")
                ]),
            
            self.item("Coca-Cola 350ml", qty: 2, condiments: nil)
            ])
        
        self.send(order: order)
    }
    
    
    private func sendOrder2() {
        let order = self.order(withItems: [
            self.item("Grilled Chicken Sandwich", qty: 1, condiments: [
                self.condiment("Cheddar Cheese"),
                self.condiment("Natual Bacon")
                ]),
            
            self.item("Orange Organic Juice", qty: 2, condiments: nil),
            
            self.item("Caesar Salad", qty: 2, condiments: [
                self.condiment("Grilled Chicken")
                ]),
            
            self.item("Grilled Chicken Sandwich", qty: 1, condiments: [
                self.condiment("Cheddar Cheese"),
                self.condiment("Natual Bacon")
                ]),
            
            self.item("Orange Organic Juice", qty: 2, condiments: nil),
            
            self.item("Caesar Salad", qty: 2, condiments: [
                self.condiment("Grilled Chicken")
                ])
            ])
        
        self.send(order: order)
    }
    
    
    private func sendOrder3() {
        let order = self.order(withItems: [
            self.item("Grilled Chicken Sandwich", qty: 1, condiments: [
                self.condiment("Cheddar Cheese"),
                self.condiment("Natual Bacon")
                ]),
            
            self.item("Orange Organic Juice", qty: 2, condiments: nil),
            
            self.item("Caesar Salad", qty: 2, condiments: [
                self.condiment("Grilled Chicken")
                ])
            ])
        
        self.send(order: order)
    }
    
    
    private func sendOrder4() {
        let order = self.order(withItems: [
            self.item("Chicken Cheeseburger", qty: 1, condiments: [
                self.condiment("Tomato"),
                self.condiment("Lettuce"),
                self.condiment("Mayonnaise")
                ]),
            
            self.item("Grape Juice", qty: 1, condiments: nil)
            ])
        
        self.send(order: order)
    }
    
    
    private func sendOrder5() {
        let order = self.order(withItems: [
            self.item("Veggie Burger", qty: 1, condiments: [
                self.condiment("Lettuce")
                ])
            ])
        
        self.send(order: order)
    }
    
    
    private func sendOrder6() {
        let order = self.order(withItems: [
            self.item("Veggie Burger", qty: 1, condiments: [
                self.condiment("Lettuce"),
                self.condiment("Tomatoes"),
                self.condiment("Pickles"),
                self.condiment("Hot Pepper Relish")
                ]),
            
            self.item("French Fries", qty: 2, condiments: [
                self.condiment("Mayonnaise")
                ]),
            
            self.item("Coca-Cola 350ml", qty: 2, condiments: nil),
            
            self.item("Grilled Chicken Sandwich", qty: 1, condiments: [
                self.condiment("Cheddar Cheese"),
                self.condiment("Natual Bacon")
                ]),
            
            self.item("Orange Organic Juice", qty: 2, condiments: nil),
            
            self.item("Caesar Salad", qty: 2, condiments: [
                self.condiment("Grilled Chicken")
                ])
            ])
        
        self.send(order: order)
    }
    
    
    private func sendOrder7() {
        let order = self.order(withItems: [
            self.item("Beef burger", qty: 2, condiments: [
                self.condiment("Tomato"),
                self.condiment("Lettuce"),
                self.condiment("Pickles")
                ]),
            
            self.item("Bucket of Chips with Cheedar", qty: 2, condiments: [
                self.condiment("Cheedar")
                ]),
            
            self.item("Coke", qty: 3, condiments: nil)
            ])
        
        self.send(order: order)
    }
    
    
    private func sendOrder8() {
        let order = self.order(withItems: [
            self.item("Veggie Burger", qty: 1, condiments: [
                self.condiment("Lettuce"),
                self.condiment("Tomatoes"),
                self.condiment("Pickles"),
                self.condiment("Hot Pepper Relish")
                ]),
            
            self.item("French Fries", qty: 2, condiments: [
                self.condiment("Mayonnaise")
                ]),
            
            self.item("Coca-Cola 350ml", qty: 2, condiments: nil),
            
            self.item("Grilled Chicken Sandwich", qty: 1, condiments: [
                self.condiment("Cheddar Cheese"),
                self.condiment("Natual Bacon")
                ]),
            
            self.item("Orange Organic Juice", qty: 2, condiments: nil),
            
            self.item("Caesar Salad", qty: 2, condiments: [
                self.condiment("Grilled Chicken")
                ]),
            
            self.item("Cheese Breads", qty: 2, condiments: nil),
            
            self.item("Coffees With Milk", qty: 2, condiments: nil),
            
            self.item("Cup Cakes", qty: 5, condiments: [
                self.condiment("Cream Cheese"),
                self.condiment("Strawberries")
                ]),
            self.item("Veggie Burger", qty: 1, condiments: [
                self.condiment("Lettuce"),
                self.condiment("Tomatoes"),
                self.condiment("Pickles"),
                self.condiment("Hot Pepper Relish")
                ]),
            
            self.item("French Fries", qty: 2, condiments: [
                self.condiment("Mayonnaise")
                ]),
            
            self.item("Coca-Cola 350ml", qty: 2, condiments: nil),
            
            self.item("Grilled Chicken Sandwich", qty: 1, condiments: [
                self.condiment("Cheddar Cheese"),
                self.condiment("Natual Bacon")
                ]),
            
            self.item("Orange Organic Juice", qty: 2, condiments: nil),
            
            self.item("Caesar Salad", qty: 2, condiments: [
                self.condiment("Grilled Chicken")
                ]),
            
            self.item("Cheese Breads", qty: 2, condiments: nil),
            
            self.item("Coffees With Milk", qty: 2, condiments: nil),
            
            self.item("Cup Cakes", qty: 5, condiments: [
                self.condiment("Cream Cheese"),
                self.condiment("Strawberries")
                ]),
            
            self.item("Veggie Burger", qty: 1, condiments: [
                self.condiment("Lettuce"),
                self.condiment("Tomatoes"),
                self.condiment("Pickles"),
                self.condiment("Hot Pepper Relish")
                ]),
            
            self.item("French Fries", qty: 2, condiments: [
                self.condiment("Mayonnaise")
                ]),
            
            self.item("Coca-Cola 350ml", qty: 2, condiments: nil),
            
            self.item("Grilled Chicken Sandwich", qty: 1, condiments: [
                self.condiment("Cheddar Cheese"),
                self.condiment("Natual Bacon")
                ]),
            
            self.item("Orange Organic Juice", qty: 2, condiments: nil),
            
            self.item("Caesar Salad", qty: 2, condiments: [
                self.condiment("Grilled Chicken")
                ]),
            
            self.item("Cheese Breads", qty: 2, condiments: nil),
            
            self.item("Coffees With Milk", qty: 2, condiments: nil),
            
            self.item("Cup Cakes", qty: 5, condiments: [
                self.condiment("Cream Cheese"),
                self.condiment("Strawberries")
                ])
            ])
        
        self.send(order: order)
    }
    
    
    private func send(order: AlleeOrder) {
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        self.lbStatus.text = "Sending..."
        
        AlleeSDK.shared.send(order: order) { (error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            let alert = UIAlertController(title: "Order sent", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            if let error = error {
                print(error)
                self.lbStatus.text = error
                
            } else {
                print("SENT: \(order.id ?? "")")
                self.lbStatus.text = "Order \(order.id ?? "") was sent"
            }
        }
    }
    
    
    private func summary(_ name: String, qty: Int) -> AlleeSummary {
        let summary = AlleeSummary()
        summary.ingredientName = name
        summary.ingredientQuantity = qty
        
        return summary
    }
    
    
    private func condiment(_ name: String) -> AlleeCondiment {
        let condiment = AlleeCondiment()
        condiment.id = UUID().uuidString
        condiment.name = name
        
        return condiment
    }
    
    
    private func item(_ name: String, qty: Int, condiments: [AlleeCondiment]?,
                      summary: AlleeSummary?=nil) -> AlleeItem {
        
        let item = AlleeItem()
        item.id = UUID().uuidString
        item.name = name
        item.kDSStation = self.tfStation.text
        item.quantity = qty
        item.condiments = condiments
        item.summary = summary
        
        return item
    }
    
    
    private func order(withItems items: [AlleeItem]) -> AlleeOrder {
        let order = AlleeOrder()
        order.id = "\(nextOrderId)"
        order.items = items
        
        self.nextOrderId += 1
        
        return order
    }
    
    
    @IBAction func changeEnv(_ sender: UISegmentedControl) {
        AppDelegate.update(env: sender.selectedSegmentIndex)
        
        let alert = UIAlertController(title: "Change environment",
                                      message: "You need to reopen the App to apply this change", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            exit(EXIT_SUCCESS)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource,
        UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let btn = cell.subviews.first?.subviews.first as! UIButton
        btn.setTitle("Order \(indexPath.row + 1)", for: .normal)
        
        if btn.tag == 0 {
            btn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        }
        
        btn.tag = indexPath.row + 1
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.layouts
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.width / 4) - 8, height: 100)
    }
    
    
    @objc func buttonClicked(_ sender: UIButton?) {
        switch sender!.tag {
        case 1:
            self.sendOrder1()
            
        case 2:
            self.sendOrder2()
            
        case 3:
            self.sendOrder3()
            
        case 4:
            self.sendOrder4()
            
        case 5:
            self.sendOrder5()
            
        case 6:
            self.sendOrder6()
            
        case 7:
            self.sendOrder7()
            
        case 8:
            self.sendOrder8()
            
        default:
            break
        }
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.tfStation {
            AppDelegate.update(kdsStation: self.tfStation.text)
            
        } else if textField == self.tfPort {
            AppDelegate.update(port: Int(self.tfPort.text ?? "0") ?? 0)
            
        } else {
            AppDelegate.update(storeKey: self.tfStoreKey.text)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
