//
//  PayNowViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 8/12/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import Razorpay


class PayNowViewController: UIViewController {
    var appd = AppDelegate()
    private var razorpay:Razorpay?
    
    @IBOutlet var lblOutstandinAmount: UILabel!
    @IBOutlet var outStandingTF: UITextField!
    @IBOutlet var proceedBTN: UIButton!
    @IBOutlet var proceedBTNView: UIView!
    var payNowVC = String()
    var outStandingAmt = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appd = UIApplication.shared.delegate as! AppDelegate
        razorpay = Razorpay.initWithKey("rzp_test_FYCQAsmKTFF8FR", andDelegate: self)
        
      
        if outStandingAmt == ""
        {
            lblOutstandinAmount.text = "0"
            outStandingTF.text = "0"
        }
        else
        {
            lblOutstandinAmount.text = outStandingAmt
            outStandingTF.text = outStandingAmt
        }
        
        setCornerRadiusView(radius: Float(proceedBTNView.frame.height/2), color: UIColor.cornerBGFullOpack, view: proceedBTNView)

    }
    
    @IBAction func proceedClick(_ sender: Any)
    {
        razorpayMethod()
    }
    
    func razorpayMethod()  {
        
        let options: [String:Any] = [
            
            "UID" : "cust_app",
            "Passcode": "C!7$uT@99#",
            
//            "amount" : "100", //mandatory in paise like:- 1000 paise ==  10 rs
//
//            "description": "purchase description",
//
//            //  "image": "ss",
//
//            "name": "Paramount",
//
//            "prefill": [
//
//                "contact": "9205726030",
//
//                "email": "bhoopendra.yugasa@gmail.com"
//
//            ],
//
//            "theme": [
//
//                "color": "#0000ff"
//
//            ]
//
       ]
        
        razorpay?.open(options)
    }
    @IBAction func backBTN(_ sender: Any) {
        
        if payNowVC=="payNW"
        {
            self.navigationController?.popViewController(animated: false)
        }
        else
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.customTabIdentifier) as? CustomTabViewController
            self.navigationController?.pushViewController(vc!, animated: false)
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
extension PayNowViewController: RazorpayPaymentCompletionProtocol {
    
    func onPaymentSuccess(_ payment_id: String) {
        
        let alert = UIAlertController(title: "Paid", message: "Payment Success", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func onPaymentError(_ code: Int32, description str: String) {
        
        let alert = UIAlertController(title: "Error", message: "\(code)\n\(str)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}




