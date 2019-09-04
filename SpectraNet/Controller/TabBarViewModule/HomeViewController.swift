//
//  HomeViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/16/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//
// scrroll view container == 1094 if  tblView.isHidden = false this time we hiding the table view tblView.isHidden = true

import UIKit
import ObjectMapper
import RealmSwift

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
   
    var appd = AppDelegate()
    let realm = try? Realm()
    var userResult:Results<UserCurrentData>? = nil
    var userdata:Results<UserData>? = nil
    var networkClass = CANetworkManager()

    var checkStatus = String()
    var dataFillChildView = UIView()
    @IBOutlet var lblSRNmbr: UILabel!
    @IBOutlet var lblTotalGB: UILabel!
    @IBOutlet var lblUsageGB: UILabel!
    @IBOutlet var lblDueDate: UILabel!
    @IBOutlet var lblTcketDate: UILabel!
    @IBOutlet var outStandingAmt: UILabel!
    @IBOutlet var lblEstimateTime: UILabel!
    @IBOutlet var lblDueDateStatus: UILabel!
    @IBOutlet var duePayAmtBTN: UIButton!
    
    @IBOutlet var availDataview: UIView!
    var canID = String()
    @IBOutlet var tblView: UITableView!
    @IBOutlet var statusMsg: UIImageView!
    
    @IBOutlet var imageScrollCollectionView: UICollectionView!
    var timer = Timer()
    var counter = 0
    @IBOutlet var lblDayStatus: UILabel!
    @IBOutlet var pageView: UIPageControl!
    var imageArr = [AnyObject]()
    @IBOutlet var fillColorView: UIView!
    @IBOutlet var limitedDataImg: UIImageView!
    @IBOutlet var lblOutOfTitle: UILabel!
    @IBOutlet var lblDataLft: UILabel!
    @IBOutlet var lblUnlimitedData: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var dummyLabel: UILabel!
    @IBOutlet var paNowBTNView: UIView!
    @IBOutlet var viewAllView: UIView!
    @IBOutlet var srParentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appd = UIApplication.shared.delegate as! AppDelegate
        
      
        imageArr = [ UIImage(named: "img.png"),
                     UIImage(named: "img.png"),
                     UIImage(named: "img.png")
            ] as [AnyObject]
        
        
        userdata = self.realm!.objects(UserData.self)
        if let userActData = userdata?[0]
        {
            canID = userActData.CANId
        }
        
        if ConnectionCheck.isConnectedToNetwork() == true
        {
           serviceTypeGetAccountDataAPI()
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
        
        pageView.numberOfPages = imageArr.count
        pageView.currentPage = 0
     
        if imageArr.count>0 {
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self,   selector: (#selector(self.changeImage)), userInfo: nil, repeats: true)
            }
        }
        
        scrollView.isHidden = true
        setCornerRadiusView(radius: Float(paNowBTNView.frame.height/2), color: UIColor.cornerBGFullOpack, view: paNowBTNView)
        setCornerRadiusView(radius: Float(viewAllView.frame.height/2), color: UIColor.cornerBGFullOpack, view: viewAllView)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
         lblDayStatus.text = getGreetingTime()
    }
    
  
    func serviceTypeGetAccountDataAPI()
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.userAccountData, forKey: "Action")
        dict .setValue(canID, forKey: "canID")
        dict .setValue(UserAuthKEY.authKEY, forKey: "Authkey")
        print(dict)
        networkClass.requestApi(serviceName: ServiceMethods.serviceBaseURL, method: kHTTPMethod.POST, postData: dict as! Dictionary<String, AnyObject>) { (response, error) in
            
            print(response as Any)
            if response != nil
            {
               
                var dict1 = NSDictionary()
                dict1 = response as! NSDictionary
                var arr = NSArray()
                arr = dict1.value(forKey: "response") as! NSArray
              
                try! self.realm!.write
                {
                    if let users = self.realm?.objects(UserCurrentData.self) {
                        self.realm!.delete(users)
                    }
                }
                
                for entry in arr {
                    
                    if let currentUser = Mapper<UserCurrentData>().map(JSONObject: entry) {
                        
                        try! self.realm!.write {
                            self.realm!.add(currentUser)
                          //  self.ecards.append(card)
                        }
                    }
                }
                self.setDataFromAccount(dicto: response as! NSDictionary)
            }
        }
    }
   
    func setDataFromAccount(dicto: NSDictionary)
    {
        userResult = self.realm!.objects(UserCurrentData.self)
        self.checkStatus = dicto.value(forKey: "status") as! String
        
        if self.checkStatus == "success"
        {
            scrollView.isHidden = false
     
            if imageArr.count>0
            {
                dummyLabel.text = dummyUsingHome.dummyLable
                imageScrollCollectionView.isHidden = false
                pageView.isHidden = false
                dummyLabel.isHidden = true
            }
            else
            {
                dummyLabel.text = ""
                imageScrollCollectionView.isHidden = true
                pageView.isHidden = true
                dummyLabel.isHidden = true
            }
            
            var checkDataAvailbility = String()
            checkDataAvailbility = "Unlimited"
            if (checkDataAvailbility == "Unlimite")
            {
                  labelShowStatus(withBool: true, setImage: "unlimitedData", setTextLabel: "Hurrey", andOther: false)
            }
            else
            {
                labelShowStatus(withBool: false, setImage: "dataImg", setTextLabel: "Data Left", andOther: true)
            }
            var aStr = String()
            var prebarred = Bool()
            
            var getDateWithFormate = String()
               if let userActData = userResult?[0]
               {
                  aStr = userActData.OutStandingAmount
                appd.segmentType = userActData.Segment

                if userActData.SRNumber == ""
                {
                    srParentView.isHidden = true
                    if UIScreen.main.sizeType == .iPhone5
                    {
                        
                    }
                    else
                    {
                        scrollView.isScrollEnabled = false
                    }
                }
                else
                {
                    srParentView.isHidden = false
                    self.lblSRNmbr.text = userActData.SRNumber
                    self.lblTcketDate.text = setChangeDateFormate(previousDateStr: removestringAfterSPACE(string: userActData.SRCreatedOn))
                    self.lblEstimateTime.text = userActData.ETR
                    var str = String()
                    str = userActData.SRCaseStatus
                    if str == "In Progress"
                    {
                        statusMsg.image = UIImage(named: "status0")
                    }
                    else
                    {
                        statusMsg.image = UIImage(named: "status1")
                    }
                }
                
                getDateWithFormate = userActData.DueDate
               // getDateWithFormate = "15/07/2019"
                var replaceGB = String()
                replaceGB = replaceStringWithStr(yourString: userActData.planDataVolume, replaceStr: " GB", withSyring: "")
                
                var replaceTotalGB = Float()
                replaceTotalGB = (replaceGB as NSString).floatValue
                
                lblTotalGB.text = String(format: "%@", userActData.planDataVolume)
                lblUsageGB.text = String(format: "%@ GB", calculateUsageData(usageData: String(format: "%.2f GB",userActData.DataConsumption), TotalData: String(format: "%@", userActData.planDataVolume)));
                makeViewFrameingAccordingParants(withOutOfdata: replaceTotalGB, usageData: userActData.DataConsumption)
                prebarred = userActData.PreBarredFlag
            }
            
            if aStr == "0"
            {
                self.setdataIntoDueDateLBL(setTextDueDates: "", withBool: true, setDueDatesStatus: "", prebarredFlag: prebarred)
                self.outStandingAmt.text = "No Dues"
            }
            else
            {
                self.setdataIntoDueDateLBL(setTextDueDates: self.setChangeDateFormate(previousDateStr: getDateWithFormate), withBool: false, setDueDatesStatus: "Due on", prebarredFlag: prebarred)
                self.outStandingAmt.text = aStr
            }
            
            tblView.isHidden = true
        }
        else
        {
            self.showAlertC(message:dicto.value(forKey: "message") as! String)
        }
    }
    
    @objc func changeImage()
    {
        if counter<imageArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.imageScrollCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        }
        else
        {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.imageScrollCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : HomeTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: TableViewCellName.homeTableViewCell) as! HomeTableViewCell)
        
        if cell == nil {
            cell = HomeTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: TableViewCellName.homeTableViewCell)
        }
        //   cell?.lblMoreTitleName.text = homeListArr[indexPath.row] as! String
        // cell?.moreTitleImg.text = ((invoiceListArray[indexPath.row] as AnyObject) .value(forKey: "amount") as! String)
        return cell!
    }
    
    
    @IBAction func viewAllBTN(_ sender: Any)
    {
        appd.navigateFrom="SRScreen"
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.customTabIdentifier) as? CustomTabViewController
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    @IBAction func payDueAmountBTN(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewIdentifier.PayNowIdentifier) as? PayNowViewController
        vc?.payNowVC = "payNW"
        vc?.outStandingAmt = outStandingAmt.text!
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    @IBAction func viewDetailsBTN(_ sender: Any)
    {
        if appd.segmentType==segment.userB2C
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.dataUsageIdentifier) as? DataUsageViewController
            self.navigationController?.pushViewController(vc!, animated: false)
        }
        else
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.mrtgIdentifier) as? MRTGViewController
            self.navigationController?.pushViewController(vc!, animated: false)
        }
    }
  
    @IBAction func notificationBTN(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewIdentifier.NotificationIdentifier)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomCollectionViewCell = imageScrollCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        //cell.slideImage.image = imageArr[indexPath.row]
//        if let vc = cell.slideImage.viewWithTag(111) as? UIImageView {
//            vc.image = imageArr[indexPath.row]
//        }
////        else
//      else  if let ab = cell.viewWithTag(222) as? UIPageControl
//        {
//                     ab.currentPage = indexPath.row
//        }
        return cell
    }
    
    func calculateUsageData(usageData: String, TotalData: String) -> String
    {
        let usage = CGFloat((usageData as NSString).floatValue)
        let Total = CGFloat((TotalData as NSString).floatValue)
        var calculatedValue = Float()
        calculatedValue = Float(Total-usage)
        print(calculatedValue)
        let s = NSString(format: "%.2f", calculatedValue)
        return s as String
    }
    
    func makeViewFrameingAccordingParants(withOutOfdata: Float, usageData: Float)
    {
        let val = setViewFraming(outOfData: withOutOfdata, usageData: usageData, viewHeight: Float(fillColorView.frame.height), viewYorigin: Float(fillColorView.frame.origin.y-34))
        
        dataFillChildView.frame = CGRect(x: fillColorView.frame.origin.x-15, y: fillColorView.frame.origin.y-34.5, width: fillColorView.frame.width, height: CGFloat(val))
        
        dataFillChildView.backgroundColor = UIColor.bgDataFillColor
        fillColorView.backgroundColor = UIColor.white
        fillColorView .addSubview(dataFillChildView)
    }
    
    func setdataIntoDueDateLBL(setTextDueDates: String,withBool: Bool,setDueDatesStatus: String , prebarredFlag: Bool)
    {
        if prebarredFlag==false {
            self.lblDueDate.textColor = UIColor.black
        }
        else
        {
            self.lblDueDate.textColor = UIColor.red
        }
        self.lblDueDateStatus.text = setDueDatesStatus
        self.lblDueDate.text = setTextDueDates
        self.duePayAmtBTN.isHidden = withBool
        paNowBTNView.isHidden = withBool
    }
    
    func labelShowStatus(withBool: Bool, setImage: String, setTextLabel: String, andOther: Bool)
    {
        limitedDataImg.image = UIImage(named: setImage)
        lblDataLft.text = setTextLabel
        lblOutOfTitle.isHidden = withBool
        lblTotalGB.isHidden = withBool
        lblUsageGB.isHidden = withBool
        lblUnlimitedData.isHidden = andOther
        fillColorView.isHidden = withBool
    }
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
