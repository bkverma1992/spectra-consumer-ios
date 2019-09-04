//
//  DataUsageViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 8/13/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
import ObjectMapper

class DataUsageViewController: UIViewController,ChartViewDelegate {
    var networkClass = CANetworkManager()
    var dataUsageResult:Results<DataUsageData >? = nil
    let realm = try? Realm()

    @IBOutlet var dataUsageLBL: UILabel!
    @IBOutlet var lineChartView: LineChartView!
    
    @IBOutlet var oneMonthBTN: UIButton!
    @IBOutlet var sixMonthBTN: UIButton!
    @IBOutlet var customBTN: UIButton!
    @IBOutlet var firstBottomLine: UILabel!
    @IBOutlet var secondBottomLine: UILabel!
    @IBOutlet var customLine: UILabel!
    @IBOutlet var lblTotalDataUsage: UILabel!
    
    @IBOutlet var currentMonth: UILabel!
    @IBOutlet var lblSelectFromDate: UILabel!
    @IBOutlet var lblSelectToDate: UILabel!
    @IBOutlet var customdateView: UIView!
    @IBOutlet var manageLbl: UILabel!
    @IBOutlet var graphParantView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var transparentView: UIView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var doneBTNview: UIView!
    @IBOutlet var filterBtnView: UIView!
    @IBOutlet var datePickerParentView: UIView!
    @IBOutlet var dateFilterBTN: UIButton!
    var checkPickerFrom = String()
    var fromDateString = String()
    var toDateString = String()
    var totalNumberOfDays = Int()
    var dataUsageArr = NSMutableArray()
    var arrrrrr = NSMutableArray()
    var finalTotalUsage = Double()
    var currentdate = String()
    var numberOfDay = Double()
    
    
    
    let months = [0.0 , 5.0, 1.5, 0.5, 2.5, 3.0,5.0 , 9.0, 6.5, 6.5, 11.5, 3.0,5.0 , 9.0, 6.5, 6.5, 11.5, 3.0,5.0 , 9.0, 6.5, 6.5, 11.5, 11.5, 3.0,5.0 , 9.0, 6.5, 6.5, 11.5]
 
    let months1 = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
    
    let dollars1 = [1453.0,2352,5431,1442,5451,6486,1173,5678,9234,1345,9411,2212]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
     //   setChart(lineChartView, dataPoints: months, values: dollars)
        dataUsageLBL.transform = CGAffineTransform(rotationAngle: -.pi / 2)
        
        setBackgroundColrAccordingToClic(selectedBGColor: UIColor.cornerBGFullOpack, withSelectedBTN: oneMonthBTN, withUnselectedButton: sixMonthBTN, withUnselected2BTN: customBTN, unselectedBGColor: UIColor.gray, withSelectedBool: false, unselectBool: true, withselecedLine: firstBottomLine, unselect1: customLine, unselect2: secondBottomLine)
        manageLbl.text = ""
        setCornerRadiusView(radius: Float(filterBtnView.frame.height/2), color: UIColor.clear, view: filterBtnView)

        customdateView.isHidden = true
        manageLbl.isHidden = true
        hideDatePickerMode(bool: true)
       
        currentdate = getCurrentDate(withFormate: DateFormats.orderCurrentDateFormatOutPut)
        print(currentdate)
        serviceTypeUsageGraph(withStartdate: getLastNumberOfMonthPreviousDate(numberOfMonth: -1), withEndDate: currentdate, canId: "019309")
        finalTotalUsage = 0.00
        numberOfDay = 0
        
    }
    
    func setChartData(months : [String]) {
        // 1 - creating an array of data entries
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
       // for var i = 0; i < months.count; i++ {
            for i in 0..<months1.count {

                yVals1.append(ChartDataEntry(x: dollars1[i], y: Double(i)))
        }
        // 2 - create a data set with our array
        let set1: LineChartDataSet = LineChartDataSet(entries: yVals1, label: "First Set")
        set1.axisDependency = .left // Line will correlate with left axis values
        set1.setColor(UIColor.red.withAlphaComponent(0.5)) // our line's opacity is 50%
        set1.setCircleColor(UIColor.red) // our circle will be dark red
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0 // the radius of the node circle
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.red
        set1.highlightColor = UIColor.white
        set1.drawCircleHoleEnabled = true
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)

        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(UIColor.white)
        
        //5 - finally set our data
        self.lineChartView.data = data
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func oneMonthClick(_ sender: Any)
    {
        setBackgroundColrAccordingToClic(selectedBGColor: UIColor.cornerBGFullOpack, withSelectedBTN: oneMonthBTN, withUnselectedButton: sixMonthBTN, withUnselected2BTN: customBTN, unselectedBGColor: UIColor.gray, withSelectedBool: false, unselectBool: true, withselecedLine: firstBottomLine, unselect1: customLine, unselect2: secondBottomLine)
        manageLbl.text = ""
        customdateView.isHidden = true
        dataUsageArr = []
        serviceTypeUsageGraph(withStartdate: getLastNumberOfMonthPreviousDate(numberOfMonth: -1), withEndDate: currentdate, canId: "019309")
        finalTotalUsage = 0.00
    }
    
    @IBAction func sixMonthClick(_ sender: Any) {
        setBackgroundColrAccordingToClic(selectedBGColor: UIColor.cornerBGFullOpack, withSelectedBTN: sixMonthBTN, withUnselectedButton: oneMonthBTN, withUnselected2BTN: customBTN, unselectedBGColor: UIColor.gray, withSelectedBool: false, unselectBool: true, withselecedLine: secondBottomLine, unselect1: customLine, unselect2: firstBottomLine)
       // setChartData(months: months1)
        manageLbl.text = ""
        dataUsageArr = []
        serviceTypeUsageGraph(withStartdate: getLastNumberOfMonthPreviousDate(numberOfMonth: -6), withEndDate: currentdate, canId: "019309")
        finalTotalUsage = 0.00
        customdateView.isHidden = true
    }
    
    @IBAction func customClick(_ sender: Any) {
        setBackgroundColrAccordingToClic(selectedBGColor: UIColor.cornerBGFullOpack, withSelectedBTN: customBTN, withUnselectedButton: sixMonthBTN, withUnselected2BTN: oneMonthBTN, unselectedBGColor: UIColor.gray, withSelectedBool: false, unselectBool: true, withselecedLine: customLine, unselect1: firstBottomLine, unselect2: secondBottomLine)
        manageLbl.text = "LLLLL"
        customdateView.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func selectFromDateBTN(_ sender: Any) {
        hideDatePickerMode(bool: false)
        
        var result1 = String()
        result1 = getCurrentDate(withFormate: DateFormats.orderCurrentDateFormatOutPut)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.orderCurrentDateFormatOutPut //Your date format
        //according to date format your date string
        guard let date = dateFormatter.date(from: result1) else {
            fatalError()
        }
        print(date)
        datePicker.date = date
        //  datePicker.setDate(date1!, animated: false)
        datePicker .reloadInputViews()
        
        selectFromDate(datePicker: datePicker, hiddenTranspView: transparentView, hiddenDoneBTNView: doneBTNview)
        checkPickerFrom = "FromDATE"

    }
    @IBAction func selectToDateBTN(_ sender: Any) {
   
        hideDatePickerMode(bool: false)
       
        print(lblSelectFromDate.text as Any)
        if lblSelectFromDate.text != DefaultString.setSeletctdate
        {
            selectToDate(datePicker: datePicker, getFromStringDate: fromDateString, hiddenTranspView: transparentView, hiddenDoneBTNView: doneBTNview)
            checkPickerFrom = "ToDATE"
        }

    }
    
    @IBAction func filterBTN(_ sender: Any) {
        
        dateFilterBTN.isSelected = !dateFilterBTN.isSelected
        if(dateFilterBTN.isSelected == true)
        {
            dataUsageArr = []
            serviceTypeUsageGraph(withStartdate: fromDateString, withEndDate: toDateString, canId: "019309")
            finalTotalUsage = 0.00
        }
        else
        {
            lblSelectToDate.text = DefaultString.setSeletctdate
            lblSelectFromDate.text = DefaultString.setSeletctdate
            toDateString = ""
            fromDateString = ""
            

        }
    }
    
    @IBAction func custumdate(_ sender: Any)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.orderCurrentDateFormatOutPut
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = DateFormats.orderYearMonth
        
        if checkPickerFrom == "FromDATE"
        {
            if toDateString == ""
            {
                fromDateString = dateFormatter.string(from: datePicker.date)
                lblSelectFromDate.text = dateFormatter1.string(from: datePicker.date)
            }
            else
            {
//                if isLeapYear(year: toDateString)==true
//                {
//                    totalNumberOfDays = 366
//                }
//                else if (isLeapYear(year: dateFormatter.string(from: datePicker.date))==true)
//                {
//                    totalNumberOfDays = 366
//                }
//                else
//                {
//                    totalNumberOfDays = 365
//                }
                totalNumberOfDays = 365
                print(totalNumberOfDays)
                var dayCount = Int()
                dayCount = daysBetweenDates(startDate: dateFormatter.string(from: datePicker.date) as NSString, endDate: toDateString as NSString)
                if dayCount>totalNumberOfDays
                {
                    showAlertC(message: ErrorMessages.selectOneYear)
                }
                else if dayCount==totalNumberOfDays
                {
                    fromDateString = dateFormatter.string(from: datePicker.date)
                    lblSelectFromDate.text = dateFormatter1.string(from: datePicker.date)
                }
                else if 0>dayCount
                {
                    showAlertC(message: ErrorMessages.endYearValidation)
                }
                else
                {
                    fromDateString = dateFormatter.string(from: datePicker.date)
                    lblSelectFromDate.text = dateFormatter1.string(from: datePicker.date)
    
                }
            }
        }
        else
        {
            toDateString = dateFormatter.string(from: datePicker.date)
            lblSelectToDate.text = dateFormatter1.string(from: datePicker.date)
        }
    }
    
    @IBAction func doneDatePickerBTN(_ sender: Any) {
      
        hideDatePickerMode(bool: true)
    }
    
    func hideDatePickerMode(bool: Bool)  {
        transparentView.isHidden = bool
        datePickerParentView.isHidden = bool
    }
    
    func serviceTypeUsageGraph(withStartdate: String, withEndDate: String, canId: String)
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.getSessionHistory, forKey: "Action")
        dict .setValue(canId, forKey: "canID")
        dict .setValue(withStartdate, forKey: "fromDate")
        dict .setValue(withEndDate, forKey: "toDate")
        dict .setValue(UserAuthKEY.authKEY, forKey: "Authkey")
        print(dict)
        
        networkClass.requestApi(serviceName: ServiceMethods.serviceBaseURL, method: kHTTPMethod.POST, postData: dict as! Dictionary<String, AnyObject>) { (response, error) in
            
            print(response as Any)
            if response != nil
            {
                var dataResponse = NSDictionary()
                var checkStatus = String()
                var arr = NSArray()

                dataResponse = response as! NSDictionary
                checkStatus = dataResponse.value(forKey: "status") as! String
                
                if checkStatus == "success"
                {
                    arr = dataResponse.value(forKey: "response") as! NSArray
                    try! self.realm!.write
                    {
                        if let users = self.realm?.objects(DataUsageData.self) {
                            self.realm!.delete(users)
                        }
                    }
                    
                    for entry in arr {
                        
                        if let currentUser = Mapper<DataUsageData>().map(JSONObject: entry) {
                            
                            try! self.realm!.write {
                                self.realm!.add(currentUser)
                            }
                        }
                    }
                    
                    self.dataUsageResult = self.realm!.objects(DataUsageData.self)
                    print(self.dataUsageResult?.count as Any)
                    var usageDataVal = String()
                    
                    for i in 0 ..< self.dataUsageResult!.count
                    {
                        print(self.dataUsageResult![i].total)
                        usageDataVal = self.dataUsageResult![i].total
                        print(self.convertByteToGB(total: usageDataVal))
                        usageDataVal = self.convertByteToGB(total: usageDataVal)
                        let myFloat = (usageDataVal as NSString).doubleValue
                        self.dataUsageArr.add(myFloat)
                        self.finalTotalUsage = myFloat + self.finalTotalUsage
                        self.numberOfDay = self.numberOfDay+1
                        self.arrrrrr.add(self.numberOfDay+1)
                    }
                    print(self.dataUsageArr)
                    print(self.arrrrrr)

                    self.setChart(self.lineChartView, dataPoints: self.months, values: self.dataUsageArr as! [Double])
                    self.lblTotalDataUsage.text = String(format: "%.2f GB", self.finalTotalUsage)
                }
                else
                {
                    self.showAlertC(message:dataResponse.value(forKey: "message") as! String)
                }
            }
        }
    }
    func convertByteToGB(total: String) -> String
    {
        let myFloat = (total as NSString).floatValue
        let final = myFloat/1024/1024/1024
        let str = String(format: "%.2f", final)
       return str
    }
}
