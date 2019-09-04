//
//  ViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/11/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift


class LoginViewController: UIViewController,UITextFieldDelegate {

    let realm = try? Realm()
    var userOTP = OTPData()
    let networkClass = CANetworkManager()
    var iconClick = true
    var dataResponse = NSDictionary()
    var checkStatus = String()
 
    @IBOutlet var mobileNumberTF: JVFloatLabeledTextField!
    @IBOutlet var userNameTF: JVFloatLabeledTextField!
    @IBOutlet var passwordTF: JVFloatLabeledTextField!
    
    @IBOutlet weak var firstMobileNmbrContainerView: UIView! //// userloginByMobile
    @IBOutlet var userLoginView: UIView! // userloginByPswd
    @IBOutlet var viewSbmtBTNBG: UIView!
    @IBOutlet var loginBtnView: UIView!
    @IBOutlet var buttonView: UIView!
    @IBOutlet var pswdShowBTN: UIButton!
    @IBOutlet var loginErrorMSGView: UIView!
    @IBOutlet var lbl1Hi: UILabel!
    @IBOutlet var lblErrMsgByLogin: UILabel!
   // let defaults = UserDefaults.standard
    @IBOutlet var userLoginByPswdBTN: UIButton!
    
    @IBOutlet var userLine1: UILabel!
    @IBOutlet var pswdLine1: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCornerRadiusView(radius: Float(viewSbmtBTNBG.frame.height/2), color: UIColor.cornerBGFullOpack, view: viewSbmtBTNBG)
        setCornerRadiusView(radius: Float(loginBtnView.frame.height/2), color: UIColor.clear, view: loginBtnView)
        loginBtnView.backgroundColor = UIColor.viewBackgroundHalfOpack
        userLoginView.isHidden = true
        buttonView.isHidden = true
        
        setupKeyboardDismissRecognizer()
        addDoneButtonOnKeyboard()
     
        
        mobileNumberTF.delegate = self
        placeholderTextColor(textfeildName: mobileNumberTF, placeHolderText: "Registered Mobile Number", withColor: UIColor.gray)
        placeholderTextColor(textfeildName: userNameTF, placeHolderText: "Username", withColor: UIColor.gray)
        placeholderTextColor(textfeildName: passwordTF, placeHolderText: "Password", withColor: UIColor.gray)
    }
  
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        userLoginByPswdBTN.isUserInteractionEnabled = false
        //mobileNumberTF.text = "8826756090"
        let screenBounds = UIScreen.main.bounds
        let width = screenBounds.width
        let height = screenBounds.height
        print(width)
        print(height)

        
    }
   
    @IBAction func submitNmbrBTN(_ sender: Any)
    {
        self.mobileNumberTF.resignFirstResponder()
        var phone = String()
        phone = mobileNumberTF.text!
        let phoneNumberValidation = phone.isValidMobileNo
        
        if phoneNumberValidation == true
        {
            if ConnectionCheck.isConnectedToNetwork() == true
            {
                serviceTypeLoginByMobile()
            }
            else
            {
                showAlertC(message: AlertViewMessage.internetConnection)
            }
        }
        else
        {
            self.showAlertC(message:ErrorValidationMessages.wrongMobileNumber)//wrongMobileNumber
        }
    }
    
    func serviceTypeLoginByMobile()
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.getAccountByMobile, forKey: "Action")
        dict .setValue(mobileNumberTF.text, forKey: "Mobile")
        dict .setValue(UserAuthKEY.authKEY, forKey: "Authkey")
        print(dict)
        
        DispatchQueue.main.async {
            self.networkClass.requestApi(serviceName: ServiceMethods.serviceBaseURL, method: kHTTPMethod.POST, postData: dict as! Dictionary<String, AnyObject>) { (response, error) in
                print(response as Any)
                if response != nil
                {
                var dataResponse = NSDictionary()
                var checkStatus = String()
                
                dataResponse = response as! NSDictionary
                checkStatus = dataResponse.value(forKey: "status") as! String
                
                if checkStatus == "success"
                {
                    var dict1 = NSDictionary()
                    dict1 = response as! NSDictionary
                    var arr = NSArray()
                    arr = dict1.value(forKey: "response") as! NSArray
                    
                    try! self.realm!.write
                    {
                        if let users = self.realm?.objects(UserData.self) {
                            self.realm!.delete(users)
                        }
                    }
                    
                    for entry in arr {
                        
                        if let currentUser = Mapper<UserData>().map(JSONObject: entry) {
                            
                            try! self.realm!.write {
                                self.realm!.add(currentUser)
                                //  self.ecards.append(card)
                            }
                        }
                    }
                    
                    if ConnectionCheck.isConnectedToNetwork() == true
                    {
                        self.serviceGenerateOTP()
                    }
                    else
                    {
                        self.showAlertC(message: AlertViewMessage.internetConnection)
                    }
                }
                else
                {
                    self.showAlertC(message: dataResponse.value(forKey: "message") as! String)
                }
              }
            }
        }
    }
    
 // Send OTP user's number
  func serviceGenerateOTP()
  {
    let dict = NSMutableDictionary()
    dict .setValue(ActionKeys.sandOTP, forKey: "Action")
    dict .setValue(mobileNumberTF.text, forKey: "mobileNo")
    dict .setValue(UserAuthKEY.authKEY, forKey: "Authkey")
    print(dict)
    
    networkClass.requestApi(serviceName: ServiceMethods.serviceBaseURL, method: kHTTPMethod.POST, postData: dict as! Dictionary<String, AnyObject>) { (response, error) in
        print(response as Any)
        if response != nil
        {
        var dataResponse = NSDictionary()
        var checkStatus = String()
        
        dataResponse = response as! NSDictionary
        checkStatus = dataResponse.value(forKey: "status") as! String
        
        if checkStatus == "success"
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.otpIdentifier) as? OTPViewController
            vc?.userOtpDetailDict = dataResponse.value(forKey: "response") as! NSDictionary
            
            var dict1 = NSDictionary()
            dict1 = response as! NSDictionary
            var dicto = NSDictionary()
            dicto = dict1.value(forKey: "response") as! NSDictionary
            
            try! self.realm!.write
            {
                if let users = self.realm?.objects(OTPData.self) {
                    self.realm!.delete(users)
                }
            }
            
            if let currentUser = Mapper<OTPData>().map(JSONObject: dicto)
                {
                    try! self.realm!.write {
                        self.realm!.add(currentUser)
                    }
            }
            
            self.navigationController?.pushViewController(vc!, animated: false)
        }
        else
        {
            self.showAlertC(message:dataResponse.value(forKey: "message") as! String)
        }
       }
      }
    }
    
    @IBAction func loginUserViaUserName(_ sender: Any)
    {
        if (userNameTF.text == "" || passwordTF.text == "")
        {
        }
        else
        {
            userLoginByPswdBTN.isUserInteractionEnabled = true
            if ConnectionCheck.isConnectedToNetwork() == true
            {
                ServiceTypeUserLoginByPaswd()
            }
            else
            {
                showAlertC(message: AlertViewMessage.internetConnection)
            }
        }
    }
  
    func ServiceTypeUserLoginByPaswd()
    {
        self.userNameTF.resignFirstResponder()
        self.passwordTF.resignFirstResponder()
        
        if userNameTF.text == ""
        {
            self.showAlertC(message:ErrorValidationMessages.wrongEmailUserName)
        }
        else if passwordTF.text == ""
        {
            self.showAlertC(message:ErrorValidationMessages.wrongEnterPassword)
        }
        else
        {
           var pswdEncodeStr = String()
            pswdEncodeStr = passwordTF.text!.data(using: .utf8)?.base64EncodedString() as Any as! String
            
            let dict = NSMutableDictionary()
            dict .setValue(ActionKeys.getAccountByPassword, forKey: "Action")
            dict .setValue(userNameTF.text, forKey: "Username")
            dict .setValue(pswdEncodeStr, forKey: "Password")
            dict .setValue(UserAuthKEY.authKEY, forKey: "Authkey")
            
            networkClass.requestApi(serviceName: ServiceMethods.serviceBaseURL, method: kHTTPMethod.POST, postData: dict as! Dictionary<String, AnyObject>) { (response, error) in
                print(response as Any)
                if response != nil
                {
                    self.dataResponse = response as! NSDictionary
                    self.checkStatus = self.dataResponse.value(forKey: "status") as! String
                    
                    if self.checkStatus == "success"
                    {
                        self.setTextFieldTextClr(textColor: UIColor.black, bgColor: UIColor.gray)
                      
                        UserDefaults.standard.set(true, forKey: "status")
                        Switcher.updateRootVC()
                        self.loginErrorMSGView.isHidden = true
                        self.lbl1Hi.isHidden = false
                        var dict1 = NSDictionary()
                        dict1 = response as! NSDictionary
                        var arr = NSArray()
                        arr = dict1.value(forKey: "response") as! NSArray
                        
                        try! self.realm!.write
                        {
                            if let users = self.realm?.objects(UserData.self) {
                                self.realm!.delete(users)
                            }
                        }
                        
                        
                        for entry in arr {
                            
                            if let currentUser = Mapper<UserData>().map(JSONObject: entry) {
                                
                                try! self.realm!.write {
                                    self.realm!.add(currentUser)
                                    //  self.ecards.append(card)
                                }
                            }
                        }
                        
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.customTabIdentifier) as? CustomTabViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
                    }
                    else
                    {
                        self.lblErrMsgByLogin.text = self.dataResponse.value(forKey: "message") as? String
                        self.loginErrorMSGView.isHidden = false
                        self.setTextFieldTextClr(textColor: UIColor.red, bgColor: UIColor.red)
                        self.lbl1Hi.isHidden = true
                        self.userLoginByPswdBTN.isUserInteractionEnabled = false
                        self.setCornerRadiusView(radius: Float(self.loginBtnView.frame.height/2), color: UIColor.clear, view: self.loginBtnView)
                        self.loginBtnView.backgroundColor = UIColor.viewBackgroundHalfOpack
                    }
                }
            }
     }
    }
    
    func setTextFieldTextClr(textColor: UIColor, bgColor: UIColor) {
        userNameTF.textColor = textColor
        passwordTF.textColor = textColor
        userLine1.backgroundColor = bgColor
        pswdLine1.backgroundColor = bgColor
    }
    // userloginByUsename And Password
    @IBAction func loginButton(_ sender: Any)
    {
        userLoginView.isHidden = false
        firstMobileNmbrContainerView.isHidden = true
        loginErrorMSGView.isHidden = true
        setCornerRadiusView(radius: Float(loginErrorMSGView.frame.height/2), color: UIColor.clear, view: loginErrorMSGView)
       // firstMobileNmbrContainerView.fadeOut()
    }
    
     // userloginByMobileNumber
    @IBAction func loginViaMobileNmbrBtn(_ sender: Any)
    {
       // userLoginView.fadeIn()
       // firstMobileNmbrContainerView.fadeIn()
        userLoginView.isHidden = true
        firstMobileNmbrContainerView.isHidden = false
    }
    
    @IBAction func forgotPswdButton(_ sender: Any)
    {
        //usingAlmofireLoginByUsername()
      
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.forgotPswdIdentifier) as? ForgotPasswordViewController
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    
    func setupKeyboardDismissRecognizer()
    {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(LoginViewController.dismissKeyboard))
        
        self.firstMobileNmbrContainerView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
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
        
       mobileNumberTF.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        mobileNumberTF.resignFirstResponder()
    }
    
    @IBAction func showPswdBTN(_ sender: Any)
    {
        if passwordTF.text == ""
        {
        }
        else
        {
            if(iconClick == true) {
                passwordTF.isSecureTextEntry = false
                pswdShowBTN.setTitle("HIDE", for: UIControl.State.normal)
            } else {
                passwordTF.isSecureTextEntry = true
                pswdShowBTN.setTitle("SHOW", for: UIControl.State.normal)
            }
            iconClick = !iconClick
        }
    }
    
    @IBAction func hideErrorMsgView(_ sender: Any) {
    
        self.loginErrorMSGView.isHidden = true
        self.lbl1Hi.isHidden = false
        setTextFieldTextClr(textColor: UIColor.black, bgColor: UIColor.gray)
        userLoginByPswdBTN.isUserInteractionEnabled = true
        setCornerRadiusView(radius: Float(loginBtnView.frame.height/2), color: UIColor.cornerBGFullOpack, view: loginBtnView)
        loginBtnView.backgroundColor = UIColor.viewBackgroundFullOpack
        userNameTF.text = ""
        passwordTF.text = ""
    }
    
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if UIScreen.main.sizeType == .iPhone5 {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: true, upValue: 180)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: true, upValue: 115)
            }
        }
        else if UIScreen.main.sizeType == .iPhone6
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: true, upValue: 180)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: true, upValue: 120)
            }
        }
        else if UIScreen.main.sizeType == .iPhone6Plus
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: true, upValue: 130)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: true, upValue: 110)//iPhoneX_XS
            }
        }
        else if UIScreen.main.sizeType == .iPhoneX_XS
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: true, upValue: 140)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: true, upValue: 90)
            }
        }
        else if UIScreen.main.sizeType == .iPhoneXSMax
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: true, upValue: 80)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: true, upValue: 10)
            }
        }
        else if UIScreen.main.sizeType == .iPhoneXR
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: true, upValue: 90)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: true, upValue: 10)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if UIScreen.main.sizeType == .iPhone5
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: false, upValue: 180)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: false, upValue: 115)
            }
        }
        else if UIScreen.main.sizeType == .iPhone6
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: false, upValue: 180)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: false, upValue: 120)
            }
        }
        else if UIScreen.main.sizeType == .iPhone6Plus
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: false, upValue: 130)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: false, upValue: 110)
            }
        }
        else if UIScreen.main.sizeType == .iPhoneX_XS
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: false, upValue: 140)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: false, upValue: 90)
            }
        }
        else if UIScreen.main.sizeType == .iPhoneXSMax
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: false, upValue: 80)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: false, upValue: 10)
            }
        }
        else if UIScreen.main.sizeType == .iPhoneXR
        {
            if textField==mobileNumberTF
            {
                ViewUpanimateMoving(up: false, upValue: 90)
            }
            else if textField==passwordTF
            {
                ViewUpanimateMoving(up: false, upValue: 10)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField==mobileNumberTF {
            
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            if newString.length == 10
            {
                buttonView.isHidden = false
            }
            else if newString.length<10
            {
                buttonView.isHidden = true
            }
            return newString.length <= maxLength
        }
        else if (textField==passwordTF)
        {
            let maxLength = 12
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
//            if newString.length == 10
//            {
//            }
             if newString.length>12
            {
                textField.resignFirstResponder()
            }
            else
             {
                if (userNameTF.text == "" && passwordTF.text == "")
                {
                    print("jhdsjksdjs")
                }
                else
                {
                    userLoginByPswdBTN.isUserInteractionEnabled = true
                    setCornerRadiusView(radius: Float(loginBtnView.frame.height/2), color: UIColor.cornerBGFullOpack, view: loginBtnView)
                    loginBtnView.backgroundColor = UIColor.viewBackgroundFullOpack
                }
            }

            return newString.length <= maxLength
        }
        
        return true
    }
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    }

extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.9, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.8, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
   
}

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

