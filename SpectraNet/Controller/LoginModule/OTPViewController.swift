//
//  OTPViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/11/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class OTPViewController: UIViewController,UITextFieldDelegate {
   
    let realm = try? Realm()
    var userResult:Results<OTPData>? = nil
    
    var appd = AppDelegate()
    var networkClass = CANetworkManager()
    var dataResponse = NSDictionary()
    var checkStatus = String()
    
    @IBOutlet var lblPrefieldMobileNmbr: UILabel!
    // object variables
    @IBOutlet var submitButtonView: UIView!
    @IBOutlet var otpDigit1TF: UITextField!
    @IBOutlet var otpDigit2TF: UITextField!
    @IBOutlet var otpDigit3TF: UITextField!
    @IBOutlet var otpDigit4TF: UITextField!
    @IBOutlet var otpView: UIView!
    
    var userMobileNmbr = String()
    var userMobileOTP = String()
    var userOtpDetailDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appd = UIApplication.shared.delegate as! AppDelegate
       
        if userOtpDetailDict.count==0 {
            userMobileNmbr = "xxxxxxxxx"
            userMobileOTP = ""
        }
        else
        {
            userMobileNmbr = userOtpDetailDict.value(forKey: "mobileNo") as! String
            let otpNumber:String = String(format: "%@", userOtpDetailDict.value(forKey: "OTP") as! CVarArg)
            userMobileOTP = otpNumber
        }

        submitButtonView.layer.cornerRadius = submitButtonView.frame.height/2
        submitButtonView.clipsToBounds = true
        
        lblPrefieldMobileNmbr.text = userMobileNmbr
        
        // add bottom line textfield
        bottomLineTextfield(textfield: otpDigit1TF)
        bottomLineTextfield(textfield: otpDigit2TF)
        bottomLineTextfield(textfield: otpDigit3TF)
        bottomLineTextfield(textfield: otpDigit4TF)
        
        addDoneButtonOnKeyboard()
   
    }
    
    func animationView()
    {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            //Frame Option 1:
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: -100, width: self.view.frame.width, height: self.view.frame.height-100)
            
            //Frame Option 2:
            //self.myView.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 4)
            self.view.backgroundColor = .blue
            
        },completion: { finish in
            
            UIView.animate(withDuration: 1, delay: 0.25,options: UIView.AnimationOptions.curveEaseIn,animations: {
                self.view.backgroundColor = .orange
             //   self.view.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                
               // self.animationButton.isEnabled = false // If you want to restrict the button not to repeat animation..You can enable by setting into true
                
            },completion: nil)})
        }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
       
        if (range.length == 0){
            if textField == otpDigit1TF {
                otpDigit2TF.becomeFirstResponder()
            }
            if textField == otpDigit2TF {
                otpDigit3TF.becomeFirstResponder()
            }
            if textField == otpDigit3TF {
                otpDigit4TF.becomeFirstResponder()
            }
            if textField == otpDigit4TF {
                otpDigit4TF.becomeFirstResponder()
                
                let otp = "\((otpDigit1TF.text)!)\((otpDigit2TF.text)!)\((otpDigit3TF.text)!)\((otpDigit4TF.text)!)\(string)"
                print(otp)
            }
            textField.text? = string
            return false
        }else if (range.length == 1) {
           
            if textField == otpDigit4TF {
                otpDigit3TF.becomeFirstResponder()
            }
            if textField == otpDigit3TF {
                otpDigit2TF.becomeFirstResponder()
            }
            if textField == otpDigit2TF {
                otpDigit1TF.becomeFirstResponder()
            }
            if textField == otpDigit1TF {
                otpDigit1TF.resignFirstResponder()
            }
            textField.text? = ""
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        if UIScreen.main.sizeType == .iPhone5
        {
            ViewUpanimateMoving(up: true, upValue: 170)
        }
        else if UIScreen.main.sizeType == .iPhone6
        {
            ViewUpanimateMoving(up: true, upValue: 150)
        }
        else if UIScreen.main.sizeType == .iPhone6Plus
        {
            ViewUpanimateMoving(up: true, upValue: 140)
        }
        else if UIScreen.main.sizeType == .iPhoneX_XS
        {
            ViewUpanimateMoving(up: true, upValue: 80)
        }
        else if UIScreen.main.sizeType == .iPhoneXR
        {
            ViewUpanimateMoving(up: true, upValue: 50)
        }
        else if UIScreen.main.sizeType == .iPhoneXSMax
        {
            ViewUpanimateMoving(up: true, upValue: 50)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if UIScreen.main.sizeType == .iPhone5
        {
            ViewUpanimateMoving(up: false, upValue: 170)
        }
        else if UIScreen.main.sizeType == .iPhone6
        {
            ViewUpanimateMoving(up: false, upValue: 150)
        }
        else if UIScreen.main.sizeType == .iPhone6Plus
        {
            ViewUpanimateMoving(up: false, upValue: 140)
        }
        else if UIScreen.main.sizeType == .iPhoneX_XS
        {
            ViewUpanimateMoving(up: false, upValue: 80)
        }
        else if UIScreen.main.sizeType == .iPhoneXR
        {
            ViewUpanimateMoving(up: false, upValue: 50)
        }
        else if UIScreen.main.sizeType == .iPhoneXSMax
        {
            ViewUpanimateMoving(up: false, upValue: 50)
        }
    }

    @IBAction func backBTN(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
  
    
    @IBAction func submitBTN(_ sender: Any) {
       
        otpDigit1TF.resignFirstResponder()
        otpDigit2TF.resignFirstResponder()
        otpDigit3TF.resignFirstResponder()
        otpDigit4TF.resignFirstResponder()

        var otpStr1 = String()
        otpStr1 = otpDigit1TF.text!
        
        var otpStr2 = String()
        otpStr2 = otpDigit2TF.text!
        
        var otpStr3 = String()
        otpStr3 = otpDigit3TF.text!
        
        var otpStr4 = String()
        otpStr4 = otpDigit4TF.text!
        
        var otpString = String()
        otpString = "\(otpStr1)\(otpStr2)\(otpStr3)\(otpStr4)"
        
        print(otpString)
        
        if userMobileOTP==otpString
        {
            UserDefaults.standard.set(true, forKey: "status")
            Switcher.updateRootVC()

            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.customTabIdentifier) as? CustomTabViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
      else
        {
            showAlertC(message: AlertViewMessage.invaliOTP)
        }
    }
    
    @IBAction func resendBTN(_ sender: Any) {
        
    if ConnectionCheck.isConnectedToNetwork() == true
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.resendOTP , forKey: "Action")
        dict .setValue(userMobileNmbr, forKey: "mobileNo")
        dict .setValue(userMobileOTP, forKey: "OTP")
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
                    self.showAlertC(message:self.dataResponse.value(forKey: "message") as! String)
                 }
               else
                {
                  self.showAlertC(message:self.dataResponse.value(forKey: "message") as! String)
                }
             }
           }
        }
    else
    {
        self.showAlertC(message: AlertViewMessage.internetConnection)
    }
}
  
    func addDoneButtonOnKeyboard()
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        otpDigit1TF.inputAccessoryView = doneToolbar
        otpDigit2TF.inputAccessoryView = doneToolbar
        otpDigit3TF.inputAccessoryView = doneToolbar
        otpDigit4TF.inputAccessoryView = doneToolbar

    }
    
    @objc func doneButtonAction()
    {
        otpDigit1TF.resignFirstResponder()
        otpDigit2TF.resignFirstResponder()
        otpDigit3TF.resignFirstResponder()
        otpDigit4TF.resignFirstResponder()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    }
