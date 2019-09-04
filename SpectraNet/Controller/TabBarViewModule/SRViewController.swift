//
//  SRViewController.swift
//  SpectraNet
//
//  Created by Yugasalabs-28 on 23/07/2019.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class SRViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    var userTransactionData = SRData()
    let realm = try? Realm()
    var userSrResult:Results<SRData>? = nil
    var userCurrentData:Results<UserCurrentData>? = nil

    var networkClass = CANetworkManager()
    var dataResponse = NSDictionary()
    var checkStatus = String()
    
    var AllData:Array<Dictionary<String,String>> = []
    var SearchData:Array<Dictionary<String,String>> = []
    
    var canID = String()
    var srStatusArr = NSArray()
    var srSearchDataArr = NSArray()
    var search:String=""
    @IBOutlet var srStatusLbl: UILabel!
    
    @IBOutlet weak var srTblView: UITableView!
    @IBOutlet weak var riasingView: UIView!
    @IBOutlet var customView: UIView!
    @IBOutlet var customRiaseView: UIView!
    @IBOutlet var searchBTN: UIButton!
    @IBOutlet var searchSRNumberTF: UITextField!
    @IBOutlet var serachImage: UIImageView!
    @IBOutlet var searchView: UIView!
    @IBOutlet var hureyLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userCurrentData = self.realm!.objects(UserCurrentData.self)
        if let userData = userCurrentData?[0]
        {
            canID = userData.CANId
        }
        
        setCornerRadiusView(radius: Float(riasingView.frame.height/2), color: UIColor.clear, view: riasingView)
        setCornerRadiusView(radius: Float(customRiaseView.frame.height/2), color: UIColor.clear, view: customRiaseView)
        placeholderTextColor(textfeildName: searchSRNumberTF, placeHolderText: "Search by SR Number", withColor: UIColor.white)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        riasingView.isHidden = true
        customView.isHidden = true
        searchView.isHidden = true
        self.srTblView.isHidden = true
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            serviceTypeGetSRStatus(useKey: "canID", useNumber: "188029")
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
        searchSRNumberTF.addTarget(self, action: #selector(SRViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text!.isEmpty
        {
            searchBTN.isHidden = true
            serachImage.isHidden = true
        }
        else
        {
            searchBTN.isHidden = false
            serachImage.isHidden = false
        }
    }
   
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
//        if self.searchSRNumberTF.text == "" {
//            searchBTN.isHidden = true
//        } else {
//            searchBTN.isHidden = false
//        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userSrResult!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : SRTableViewCell? = (srTblView.dequeueReusableCell(withIdentifier: TableViewCellName.srTableViewCell) as! SRTableViewCell)
        
        if cell == nil
        {
            cell = SRTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: TableViewCellName.srTableViewCell)
        }
      
        if let srData = userSrResult?[indexPath.row]
        {
            
            cell?.lblSRNmbr.text = srData.srNumber
            if srData.status == "Resolved"
            {
                cell?.statusImg.image = UIImage(named: "status1")
            }
            else
            {
                cell?.statusImg.image = UIImage(named: "status0")
            }
            
             cell?.lblPrblmType.text = srData.problemType
             cell?.lblSubPrblmType.text = srData.subSubType
            
           // cell?.lblResolve.text = replaceStringWithStr(yourString: ((srStatusArr[indexPath.row] as AnyObject) .value(forKey: "modifiedon") as! String), replaceStr: " ", withSyring: " at ")
            cell?.lblResolve.text = ""

        }

        return cell!
    }
    func serviceTypeGetSRStatus(useKey: String, useNumber: String)
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.getSRStatus, forKey: "Action")
        dict .setValue(useNumber, forKey: useKey)
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
                if self.dataResponse.value(forKey: "response") is Dictionary<AnyHashable,Any>
                {
                    let alertMsg: Any = self.dataResponse.value(forKey: "response") as Any
                    self.showAlertC(message:(alertMsg as AnyObject).value(forKey: "Message") as! String)
                }
                else
                {
                    self.srStatusArr = self.dataResponse.value(forKey: "response") as! NSArray
                    print(self.srStatusArr)
                    var dict1 = NSDictionary()
                    dict1 = response as! NSDictionary
                    var arr = NSArray()
                    arr = dict1.value(forKey: "response") as! NSArray
                    
                    try! self.realm!.write
                    {
                        if let users = self.realm?.objects(SRData.self) {
                            self.realm!.delete(users)
                        }
                    }
                    
                    for entry in arr {
                        
                        if let currentUser = Mapper<SRData>().map(JSONObject: entry) {
                            
                            try! self.realm!.write {
                                self.realm!.add(currentUser)
                            }
                        }
                    }
                    
                    self.userSrResult = self.realm!.objects(SRData.self)
                    
                    self.customView.isHidden = true
                    self.srTblView.dataSource=self
                    self.srTblView.reloadData()
                     self.srTblView.isHidden = false
                    self.riasingView.isHidden = false
                    self.searchView.isHidden = false
                    self.serachImage.isHidden = true
                    self.searchBTN.isHidden = true
                }
            }
            else
            {
                self.customView.isHidden = false
                self.srStatusLbl.text = "There are no service request"
                self.hureyLbl.text="Hurrey!"
                //self.showAlertC(message:self.dataResponse.value(forKey: "message") as! String)
            }
          }
        }
    }
    
    func serviceTypeSearchSR(useKey: String, useNumber: String)
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.getSRStatus, forKey: "Action")
        dict .setValue(useNumber, forKey: useKey)
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
                    if self.dataResponse.value(forKey: "response") is Dictionary<AnyHashable,Any>
                    {
                        let alertMsg: Any = self.dataResponse.value(forKey: "response") as Any
                        self.showAlertC(message:(alertMsg as AnyObject).value(forKey: "Message") as! String)
                    }
                    else
                    {
                        self.srStatusArr = self.dataResponse.value(forKey: "response") as! NSArray
                        print(self.srStatusArr)
                        var dict1 = NSDictionary()
                        dict1 = response as! NSDictionary
                        var arr = NSArray()
                        arr = dict1.value(forKey: "response") as! NSArray
                        
                        try! self.realm!.write
                        {
                            if let users = self.realm?.objects(SRData.self) {
                                self.realm!.delete(users)
                            }
                        }
                        
                        for entry in arr {
                            
                            if let currentUser = Mapper<SRData>().map(JSONObject: entry) {
                                
                                try! self.realm!.write {
                                    self.realm!.add(currentUser)
                                }
                            }
                        }
                        
                        self.userSrResult = self.realm!.objects(SRData.self)
                        
                        self.customView.isHidden = true
                        self.srTblView.dataSource=self
                        self.srTblView.reloadData()
                        self.riasingView.isHidden = false
                        self.searchView.isHidden = false
                        self.serachImage.isHidden = true
                        self.searchBTN.isHidden = false
                    }
                }
                else
                {
                    self.hureyLbl.text=""
                    self.srStatusLbl.text = "No Request found."

                    self.customView.isHidden = false
                    //self.showAlertC(message:self.dataResponse.value(forKey: "message") as! String)
                }
            }
        }
    }
    

@IBAction func clickSearchBTN(_ sender: Any)
{
    if ConnectionCheck.isConnectedToNetwork() == true
    {
        searchBTN.isSelected = !searchBTN.isSelected
        
        if(searchBTN.isSelected == true)
        {
            serachImage.image = UIImage(named: "cross")
          
            serviceTypeSearchSR(useKey: "srNumber", useNumber: searchSRNumberTF.text!)

        }
        else
        {
            serachImage.image = UIImage(named: "filterarrow")
            
            
            serviceTypeGetSRStatus(useKey: "canID", useNumber: "188029")
            searchSRNumberTF.text = ""
        }
    }
    else
    {
        showAlertC(message: AlertViewMessage.internetConnection)
    }
       
    }
    
    @IBAction func createSRBTN(_ sender: Any)
    {
       navigateCreateSRScreen()
    }
    
    @IBAction func createSRClick(_ sender: Any)
    {
      navigateCreateSRScreen()
    }
    
    func navigateCreateSRScreen()
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.CreateSRIdentifier) as? CreateSRViewController
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
