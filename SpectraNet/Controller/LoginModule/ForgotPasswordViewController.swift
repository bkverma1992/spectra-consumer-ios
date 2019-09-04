//
//  ForgotPasswordViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/17/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController,UITextFieldDelegate {
    
    let networkClass = CANetworkManager()
    var dataResponse = NSDictionary()
    var checkStatus = String()
    @IBOutlet var mobileTF: JVFloatLabeledTextField!
    @IBOutlet weak var transparantView: UIView!
    @IBOutlet weak var SubmitCanView: UIView!
    
    @IBOutlet var byCAnIDBTN: UIButton!
    @IBOutlet var byUserNameBTN: UIButton!
    @IBOutlet var lineBelowUsernameBTN: UILabel!
    @IBOutlet var lineBelowCanBTN: UILabel!
    @IBOutlet var lblHeaderStatus: UILabel!
    @IBOutlet var showCanIDBTN: UIButton!
    
    @IBOutlet var imgShowCanInfo: UIImageView!
    @IBOutlet var btnCanInfoHide: UIButton!
    var postWithKey = String()
    @IBOutlet var submitPswdView: UIView!
    @IBOutlet var successPswdView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        placeholderTextColor(textfeildName: mobileTF, placeHolderText: "CAN ID", withColor: UIColor.gray)
        
        SubmitCanView.isHidden = true
        showAndHideView(bool: true)
        
        setBelowlineColor(below1stTabLine: lineBelowCanBTN, withColor: .bgColors, below2ndTabLine: lineBelowUsernameBTN, withColor2: UIColor.white, btn1stTab: byCAnIDBTN, with1stBtnTabColor: .bgColors, btn2ndTab: byUserNameBTN, with2ndBtnTabColor: UIColor.darkGray, setstatus: AlertViewMessage.enterCanIDForgot, toLabel: lblHeaderStatus)
        
        setCornerRadiusView(radius: Float(submitPswdView.frame.height/2), color: UIColor.cornerBGFullOpack, view: submitPswdView)
        setCornerRadiusView(radius: Float(successPswdView.frame.height/2), color: UIColor.cornerBGFullOpack, view: successPswdView)


    }
    
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if UIScreen.main.sizeType == .iPhone5
        {
            ViewUpanimateMoving(up: true, upValue: 150)
        }
        else if UIScreen.main.sizeType == .iPhone6
        {
            ViewUpanimateMoving(up: true, upValue: 60)
        }
        else if UIScreen.main.sizeType == .iPhoneX_XS
        {
           ViewUpanimateMoving(up: true, upValue: 20)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if UIScreen.main.sizeType == .iPhone5
        {
            ViewUpanimateMoving(up: false, upValue: 150)
        }
        if UIScreen.main.sizeType == .iPhone6
        {
            ViewUpanimateMoving(up: false, upValue: 60)
        }
        else if UIScreen.main.sizeType == .iPhoneX_XS
        {
           ViewUpanimateMoving(up: false, upValue: 20)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if postWithKey == "canID"
        {
            if textField == mobileTF {
                if string == "" {
                    return true
                }
                
                if let characterCount = textField.text?.count {
                    // CHECK FOR CHARACTER COUNT IN TEXT FIELD
                    if characterCount >= 6
                    {
                        return textField.resignFirstResponder()
                    }
                }
            }
        }
       
        return true
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func submitBTN(_ sender: Any)
    {
        mobileTF.resignFirstResponder()
        
        if ConnectionCheck.isConnectedToNetwork() == true
        {
             ServiceTypeForgotPasswrd()
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
    }
    
    func ServiceTypeForgotPasswrd()
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.forgotPassword, forKey: "Action")
        dict .setValue(mobileTF.text, forKey: postWithKey)
        dict .setValue(UserAuthKEY.authKEY, forKey: "Authkey")
        print(dict)
        networkClass.requestApi(serviceName: ServiceMethods.serviceBaseURL, method: kHTTPMethod.POST, postData: dict as! Dictionary<String, AnyObject>) { (response, error) in
            
            print(response as Any)
            if response != nil
            {
                self.dataResponse = response as! NSDictionary
                self.checkStatus = self.dataResponse.value(forKey: "status") as! String
            
                if self.checkStatus == "success"
                {
                  self.SubmitCanView.isHidden = false
                  self.transparantView.isHidden = false
                }
                else
                {
                  self.showAlertC(message: self.dataResponse.value(forKey: "message") as! String)
                }
            }
        }
    }
    
    @IBAction func showCanIdDetalsBTN(_ sender: Any) {
        
        showAndHideView(bool: false)
    }
    
    @IBAction func submitCanBTN(_ sender: Any) {
     self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func clickByCanIdBN(_ sender: Any) {
       
        mobileTF.resignFirstResponder()
        setBelowlineColor(below1stTabLine: lineBelowCanBTN, withColor: .bgColors, below2ndTabLine: lineBelowUsernameBTN, withColor2: UIColor.white, btn1stTab: byCAnIDBTN, with1stBtnTabColor: .bgColors, btn2ndTab: byUserNameBTN, with2ndBtnTabColor: UIColor.darkGray, setstatus: AlertViewMessage.enterCanIDForgot, toLabel: lblHeaderStatus)
         placeholderTextColor(textfeildName: mobileTF, placeHolderText: "CAN ID", withColor: UIColor.gray)
        mobileTF.keyboardType = UIKeyboardType.phonePad
        showCanIDBTN.isHidden = false
        postWithKey = "canID"
    }
    
    @IBAction func clickByUserNameBTN(_ sender: Any)
    {
         mobileTF.resignFirstResponder()
        setBelowlineColor(below1stTabLine: lineBelowCanBTN, withColor: UIColor.white, below2ndTabLine: lineBelowUsernameBTN, withColor2: .bgColors, btn1stTab: byCAnIDBTN, with1stBtnTabColor: UIColor.darkGray, btn2ndTab: byUserNameBTN, with2ndBtnTabColor: .bgColors, setstatus: AlertViewMessage.enterUsernameForgot, toLabel: lblHeaderStatus)
        placeholderTextColor(textfeildName: mobileTF, placeHolderText: "Username", withColor: UIColor.gray)
        mobileTF.keyboardType = UIKeyboardType.emailAddress
         showCanIDBTN.isHidden = true
        postWithKey = "username"

    }
    @IBAction func hideCanInfoBTN(_ sender: Any)
    {
        showAndHideView(bool: true)
    }
    
    func showAndHideView(bool: Bool)
    {
        transparantView.isHidden = bool
        imgShowCanInfo.isHidden = bool
        btnCanInfoHide.isHidden = bool
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}



