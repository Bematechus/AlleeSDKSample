//
//  ViewController.swift
//  AlleeSDKSample
//
//  Created by Rodrigo Busata on 27/07/18.
//  Copyright © 2018 Bematech. All rights reserved.
//

import UIKit
import AlleeSDK
import FloatingPanel

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tfStoreKey: UITextField!
    @IBOutlet weak var tfPort: UITextField!
    @IBOutlet weak var tfStation: UITextField!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var segEnv: UISegmentedControl!
    
    private var floatPanel: FloatingPanelController!
    
    private var layouts = 4
    private var customOrders: [CustomOrder] = []
    
    private var nextOrderId = arc4random_uniform(1000000 - 1) + 1
    
    private var ordersStatusVc: OrdersStatusViewController!
    
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
        
        NotificationCenter.default
            .addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { _ in
                self.load()
        }
        
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        AlleeSDK.shared.ordersBumpStatusDelegate = self
        
        self.setupPanel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.load()
    }
    
    private func setupPanel() {
        if !AppDelegate.isPhone() {
            return
        }
        
        self.floatPanel = FloatingPanelController()
        self.ordersStatusVc = self.storyboard!
            .instantiateViewController(withIdentifier: "OrdersStatusViewController") as? OrdersStatusViewController
        
        self.floatPanel.delegate = self
        self.floatPanel.surfaceView.backgroundColor = .clear
        self.floatPanel.surfaceView.cornerRadius = 9.0
        self.floatPanel.surfaceView.shadowHidden = false
        self.floatPanel.set(contentViewController: self.ordersStatusVc)
        self.floatPanel.track(scrollView: self.ordersStatusVc.tableView)
        
        self.floatPanel.addPanel(toParent: self)
    }
    
    
    private func load() {
        self.customOrders = []
        for (_, value) in UserDefaults.shared.dictionary(forKey: UserDefaults.ordersKey) ?? [:] {
            if let order = JsonUtil<CustomOrder>.from(json: value as? String ?? "") {
                self.customOrders.append(order)
            }
        }
        
        self.customOrders.sort(by: {$0.createTime < $1.createTime})
        
        self.collectionView.reloadData()
    }
    
    
    private func sendOrder1() {
        let order = self.order(withItems: [
            self.item("Veggie Burger", qty: 1, condiments: [
                self.condiment("Lettuce"),
                self.condiment("Tomatoes"),
                self.condiment("Pickles"),
                self.condiment("Hot Pepper Relish")
                ], summary: self.summary("Soy burger", qty: 2), recipe: self.recipe()),
            
            self.item("French Fries", qty: 2, condiments: [
                self.condiment("Mayonnaise")
                ]),
            
            self.item("Coca-Cola 350ml", qty: 2, condiments: nil)
            ])
        
        let customer = AlleeCustomer()
        customer.id = UUID().uuidString
        customer.name = "Robert"
        customer.phone = "1111111111"
        customer.phone2 = "222222222"
        customer.address = "USA"
        customer.address2 = "North America"
        customer.city = "New York City"
        customer.country = "NY"
        customer.email = "contact@bematechus.com"
        customer.webmail = "bematechus.com"
        customer.zip = "99999"
        
        order.customer = customer
        
        order.items?[0].preparationTime = 10
        order.items?[0].condiments?[1].preparationTime = 5
        order.items?[1].set(itemType: .fire)
        
        order.items?[0].category = "Burger"
        
        self.send(order: order)
    }
    
    
    private func sendOrder2() {
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
    
    
    private func sendOrder3() {
        let order = self.order(withItems: [
            self.item("Veggie Burger", qty: 1, condiments: [
                self.condiment("Lettuce")
                ])
            ])
        
        self.send(order: order)
    }
    
    
    private func sendOrder4() {
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
    
    
    private func cantSend() -> Bool {
        if UIApplication.shared.isNetworkActivityIndicatorVisible {
            return true
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        self.lbStatus.text = "Sending..."
        return false
    }
    
    
    private func send(order: AlleeOrder) {
        if self.cantSend() { return }
        
        AlleeSDK.shared.send(order: order, callback: self.callback)
    }
    
    
    private func sendCustomOrder(_ sender: UIButton?) {
        if self.cantSend() { return }
        
        let order = self.customOrders[sender!.tag - self.layouts - 1]
        var xml = order.xml.replacingOccurrences(of: CustomOrder.Key.orderId.rawValue, with: "\(self.nextOrderId)")
        xml = xml.replacingOccurrences(of: CustomOrder.Key.stationId.rawValue, with: "\(self.tfStation.text ?? "")")
        
        AlleeSDK.shared.send(orderXML: xml, callback: self.callback)
        
        self.nextOrderId += 1
    }
    
    
    private func summary(_ name: String, qty: Int) -> AlleeSummary {
        let summary = AlleeSummary()
        summary.ingredientName = name
        summary.ingredientQuantity = qty
        
        return summary
    }
    
    
    private func recipe() -> AlleeItemRecipe {
        let recipe = AlleeItemRecipe()
        recipe.image = "https://bit.ly/2I9dkxH"
        recipe.ingredients = ["1/2 medium yellow onion, chopped", "3/4 c. panko bread crumbs", "1 tomato, sliced"]
        recipe.steps = ["In a food processor, pulse black beans, onion, and garlic until finely chopped.",
                        "Transfer to a large bowl and combine with egg, 2 tablespoons mayo, and panko. Season generously with salt and pepper and form the mixture into 4 patties. Refrigerate until firm, about 15 minutes.",
                        "In a large skillet over medium heat, heat oil. Add patties and cook until golden and warmed through, about 5 minutes per side."]
        
        return recipe
    }
    
    
    private func condiment(_ name: String) -> AlleeCondiment {
        let condiment = AlleeCondiment()
        condiment.id = UUID().uuidString
        condiment.name = name
        
        return condiment
    }
    
    
    private func item(_ name: String, qty: Int, condiments: [AlleeCondiment]?,
                      summary: AlleeSummary?=nil, recipe:AlleeItemRecipe?=nil) -> AlleeItem {
        
        let item = AlleeItem()
        item.id = UUID().uuidString
        item.name = name
        item.kDSStation = self.tfStation.text
        item.quantity = qty
        item.condiments = condiments
        
        item.summary = summary
        item.itemRecipe = recipe
        
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
    
    
    private func callback(error: String?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        if let error = error {
            print(error)
            self.lbStatus.text = error
            
        } else {
            print("SENT")
            self.lbStatus.text = "Order was sent"
            
            self.ordersStatusVc.add(orderId: "\(self.nextOrderId - 1)")
        }
    }
    
    @IBAction func actionToggleKey(_ sender: UIButton) {
        self.tfStoreKey.isSecureTextEntry.toggle()
        sender.setTitle(self.tfStoreKey.isSecureTextEntry ? "Show" : "Hide", for: .normal)
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let btn = cell.subviews.first?.subviews.first as! UIButton
        
        if indexPath.row >= self.layouts {
            btn.setTitle(self.customOrders[indexPath.row - self.layouts].name, for: .normal)
            btn.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.6862745098, blue: 0.9647058824, alpha: 1)
            
        } else {
            btn.setTitle("Default \(indexPath.row + 1)", for: .normal)
            btn.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4823529412, blue: 0.9647058824, alpha: 1)
        }
        
        if btn.tag == 0 {
            btn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            btn.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(buttonLongClicked)))
        }
        
        btn.tag = indexPath.row + 1
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.layouts + customOrders.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 90, height: 100)
    }
    
    
    @objc func buttonLongClicked(_ gesture: UILongPressGestureRecognizer?) {
        if gesture?.state == .began {
            let index = gesture?.view?.tag ?? 0
            if index <= self.layouts {
                return
            }
            
            self.performSegue(withIdentifier: "toForm", sender: self.customOrders[index - self.layouts - 1])
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FormViewController {
            vc.order = sender as? CustomOrder
            
        } else if let vc = segue.destination as? OrdersStatusViewController {
            self.ordersStatusVc = vc
            
            vc.view.layer.shadowColor = UIColor.black.cgColor
            vc.view.layer.shadowOpacity = 0.15
            vc.view.layer.shadowOffset = .zero
            vc.view.layer.shadowRadius = 9
        }
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
            
        default:
            self.sendCustomOrder(sender)
        }
    }
}


extension ViewController: OrdersBumpStatusDelegate {
    
    func updated(ordersBumpStatus: [AlleeOrderBumpStatus]) {
        self.ordersStatusVc.update(ordersStatus: ordersBumpStatus)
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

extension ViewController: FloatingPanelControllerDelegate {
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return PanelLayout()
    }
    
    class PanelLayout: FloatingPanelLayout {
        
        var initialPosition: FloatingPanelPosition {
            return .tip
        }
        
        public var supportedPositions: Set<FloatingPanelPosition> {
            return [.full, .tip]
        }
        
        public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
            switch position {
            case .full: return 16
            case .tip: return 100
            default: return nil
            }
        }
    }
}
