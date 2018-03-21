//
//  ViewController.swift
//  ExampleApp
//
//  Created by Basil M Kuriakose on 27/12/17.
//  Copyright © 2018 Cashfree. All rights reserved.
//

import UIKit
import iosCashfreeSdk

class ViewController: UIViewController {
    
    // MARK: Step 1 - Set Variables (MUST NOT BE EMPTY)
    // Note - Please add the 3 keys (without the qoutes) in your project's "info.plist" file and set correct value for them
    
    // If you are testing in development, please set value of "CF_ENV" as "TEST" (without qoutes) in your project's Info.plist file.
    // Else if you are building your app for Production (Appstore), please set the value of "CF_ENV" to "PROD" (without qoutes) in your project's Info.plist file.
    
    let environment = Bundle.main.infoDictionary?["CF_ENV"] as! String  // MUST NOT BE EMPTY
    
    let url = Bundle.main.infoDictionary?["CF_URL"] as! String // MUST NOT BE NIL
    let appId = Bundle.main.infoDictionary?["CF_API_KEY"] as! String // MUST NOT BE NIL
    let merchantName = Bundle.main.infoDictionary?["CF_MERCHANT_NAME"] as! String // MUST NOT BE NIL
    
    // End of Step 1
    
    
    // MARK: Step 2 - Pass your variables (Eg: orderId, orderAmount etc)
    
    let orderId = "orderId"
    let orderAmount = "102.00"
    let customerEmail = "yourname@example.com"
    let customerPhone = "9876543210"
    let orderNote = "This is a test note" // Pass "" if you don't have a value.
    let customerName = "Firstname Lastname"
    let orderCurrency = "INR"
    
    var paymentReady = "" // MUST BE A VAR with the value ""
    // End of Step 2
    
    // Use below values for color1Hex and color2Hex if you want to use our example
    // let color1Hex = 255fdb
    // let color2Hex = 00ff6b
    
    let color1Hex = "7d559f"
    let color2Hex = "de97ec"
    
    // MARK: To present all Payment Options in a Tab Bar Controller
    @IBAction func payTabBarButton(_ sender: Any) {
        
        let myBundle = Bundle(for: PGTabBarViewController.self)
        let mainView: UIStoryboard = UIStoryboard(name: "CF", bundle: myBundle)
        
        let paymentVC = mainView.instantiateViewController(withIdentifier: "PGTabBar") as! PGTabBarViewController
        
        let payTab = PGTabBarViewController()
        payTab.createOrder(env: environment, url: url, merchantName: merchantName, appId: appId, orderId: orderId, orderAmount: orderAmount, customerEmail: customerEmail, customerPhone: customerPhone, paymentReady: paymentReady, orderNote: orderNote, customerName: customerName, color1Hex: color1Hex, color2Hex: color2Hex, orderCurrency: orderCurrency)
        
        self.present(paymentVC, animated: false, completion: nil)
    }
    // End of Showing all Payment Options in a Tab Bar Controller
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Step 4 Call the initPayment method on "viewDidLoad()"
        let cf = cardViewController()
        
        _ = cf.initPayment(url: url, appId: appId, orderId: orderId, orderAmount: orderAmount, customerEmail: customerEmail, customerPhone: customerPhone, orderCurrency: orderCurrency, completion: { output in
            self.paymentReady = (output)
        })
        
        // End of Step 4
    }
    
    
    // MARK: Step 5 - Below function is used for Tab Bar Controller contains the result after payment is completed by the user.
    
    override func viewDidAppear(_ animated: Bool) {
        let paymentVC = PGTabBarViewController()
        
        let transactionResult = paymentVC.getResult()
        print("The transaction result received in the Example App codebase is \(transactionResult)")
        
        if transactionResult != "" {
            UIAlertView.init(title: "Payment Response", message: "Payment Completed", delegate: self, cancelButtonTitle: "OK").show()
            //use "message: transactionResult" if you want to see the raw transaction response json string
        } else {
            print("No payment response received.")
        }
        
        
    }
    // End of function that contains the result after payment is completed by the user.

}
