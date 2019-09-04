//
//  CreateSRViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 8/12/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class CreateSRViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let realm = try? Realm()
    var appd = AppDelegate()
    
    var userResult:Results<UserCurrentData>? = nil
    var networkClass = CANetworkManager()
    @IBOutlet var lblNetStatus: UILabel!
    @IBOutlet var submitView: UIView!
    @IBOutlet var descr: JVFloatLabeledTextView!
    @IBOutlet var transparantView: UIView!
    @IBOutlet var submitServiceRequest: UIView!
    @IBOutlet var backToSRView: UIView!
    @IBOutlet var caseTypeView: UIView!
    
    @IBOutlet var issuetypeLabel: UILabel!

    var caseNumber = String()
    var canID = String()
    var caseArr = NSArray()
    
    @IBOutlet var caseTableView: UITableView!
    @IBOutlet var createdSRNmbrLBL: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        appd = UIApplication.shared.delegate as! AppDelegate
        
        setCornerRadiusView(radius: Float(submitView.frame.height/2), color: UIColor.cornerBGFullOpack, view: submitView)
        setCornerRadiusView(radius: Float(backToSRView.frame.height/2), color: UIColor.cornerBGFullOpack, view: backToSRView)

        showViews(withBool: true)
        
        userResult = self.realm!.objects(UserCurrentData.self)
        if let userData = userResult?[0]
        {
            canID = userData.CANId
        }
        caseTypeView .isHidden = true
        lblNetStatus.textColor = UIColor.gray
        issuetypeLabel.isHidden = true
        descr.text = ""
        
    }

    @IBAction func backBTN(_ sender: Any) {
        //self.navigationController?.popViewController(animated: false)
        appd.navigateFrom="SRScreen"
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.customTabIdentifier) as? CustomTabViewController
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    @IBAction func showListOfNETStatusBTN(_ sender: Any)
    {
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            ServiceGetCasesType()
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
    }
    
    @IBAction func submitQuaryBTN(_ sender: Any)
    {
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            serviceCreateSR()
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
    }
    
    func showViews(withBool : Bool)
    {
        transparantView.isHidden = withBool
        submitServiceRequest.isHidden = withBool
    }
    
    @IBAction func backToSRBTN(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func serviceCreateSR()
    {
        if lblNetStatus.text == ""
        {
            caseNumber = ""
        }
       
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.createSR, forKey: "Action")
        dict .setValue("188029", forKey: "canID")
        dict .setValue(caseNumber, forKey: "caseType")
        dict .setValue(descr.text, forKey: "comment")
        dict .setValue(UserAuthKEY.authKEY, forKey: "Authkey")
        
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
                    self.showViews(withBool: false)
                    
                    self.createdSRNmbrLBL.text = String(format: "Your service request has been submitted successfully. Your service request number is %@.", dataResponse.value(forKey: "response") as! CVarArg)
                    
                }
                else
                {
                    self.showAlertC(message:dataResponse.value(forKey: "message") as! String)
                }
            }
        }
    }

    func ServiceGetCasesType()
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.getCases, forKey: "Action")
        dict .setValue(UserAuthKEY.authKEY, forKey: "Authkey")
        
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
                    self.caseArr = dataResponse.value(forKey: "response") as! NSArray
                    self.caseTypeView .isHidden = false
                    self.caseTableView.delegate = self
                    self.caseTableView.dataSource = self
                    self.caseTableView.reloadData()
                }
                else
                {
                    self.showAlertC(message:dataResponse.value(forKey: "message") as! String)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return caseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : CaseTYpeTableViewCell? = (caseTableView.dequeueReusableCell(withIdentifier: TableViewCellName.caseTypeTableViewCell) as! CaseTYpeTableViewCell)
        
        if cell == nil {
            cell = CaseTYpeTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: TableViewCellName.canIDTableViewCell)
        }
        print(indexPath.row)
        
//        if let userData = userResult?[indexPath.row]
//        {
        cell?.caseLBL.text = ((caseArr[indexPath.row] as AnyObject) .value(forKey: "case_desc") as! String)
  //      }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        lblNetStatus.text = ((caseArr[indexPath.row] as AnyObject) .value(forKey: "case_desc") as! String)
        lblNetStatus.textColor = UIColor.white
        self.caseTypeView .isHidden = true
        issuetypeLabel.isHidden = false
        caseNumber = ((caseArr[indexPath.row] as AnyObject) .value(forKey: "case_id") as! String)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func hideCaseTypeView(_ sender: Any)
    {
        caseTypeView .isHidden = true
    }
    
 
}
