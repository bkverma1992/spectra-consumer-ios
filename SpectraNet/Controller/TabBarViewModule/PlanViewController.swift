//
//  PlanViewController.swift
//  SpectraNet
//
//  Created by Yugasalabs-28 on 24/07/2019.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class PlanViewController: UIViewController {

    let realm = try? Realm()
    var userResult:Results<UserCurrentData>? = nil
    var networkClass = CANetworkManager()
    var appd = AppDelegate()
    
    var dataResponse = NSDictionary()
    var checkStatus = String()
    var pckgID = String()
    var planDict = NSDictionary()
    var totalAmountArr = NSArray()
    var totalAmt = String()
    var finalAmount = Float()
    
    
    
    @IBOutlet var planView: UIView!
    @IBOutlet var lblPlanName: UILabel!
    @IBOutlet var lblChargesAmt: UILabel!
    @IBOutlet var lblTotalData: UILabel!
    @IBOutlet var lblSpeed: UILabel!
    @IBOutlet var lblFrequency: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appd = UIApplication.shared.delegate as! AppDelegate
        
        userResult = self.realm!.objects(UserCurrentData.self)
        if let userActData = userResult?[0]
        {
            pckgID = userActData.Product
            lblSpeed.text = userActData.Speed
            lblFrequency.text = userActData.BillFrequency
            lblTotalData.text = userActData.planDataVolume
        }
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            ServiceTypeRatePlane()
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
        
        planView.isHidden = true
        finalAmount = 0

    }
    func ServiceTypeRatePlane() {
        let dict = NSMutableDictionary()
        dict.setValue(ActionKeys.getRatePlan, forKey: "Action")
        dict.setValue(UserAuthKEY.authKEY, forKey: "Authkey")
        dict.setValue(pckgID, forKey: "pkgID")
        print(dict)
        networkClass.requestApi(serviceName: ServiceMethods.serviceBaseURL, method: kHTTPMethod.POST, postData: dict as! Dictionary<String, AnyObject>) { (response, error) in
            
            print(response as Any)
            if response != nil
            {
                self.dataResponse = response as! NSDictionary
                self.checkStatus = self.dataResponse.value(forKey: "status") as! String
            
                if self.checkStatus == "success"
            {
                self.planDict = self.dataResponse.value(forKey: "response") as! NSDictionary
                print(self.planDict)
                self.lblPlanName.text = (self.planDict.value(forKey: "planName") as! String)
                self.totalAmountArr = self.planDict.value(forKey: "rcCharge") as! NSArray
                for i in 0 ..< self.totalAmountArr.count
                {
                    self.totalAmt = (self.totalAmountArr[i] as AnyObject).value(forKey: "amount") as? String ?? "0"
                    let myFloat = (self.totalAmt as NSString).floatValue
                    self.finalAmount = myFloat + self.finalAmount
                }
                self.lblChargesAmt.text = String(format: "%.2f", self.finalAmount)
                
                self.planView.isHidden = false
            }
          }
        }

    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
