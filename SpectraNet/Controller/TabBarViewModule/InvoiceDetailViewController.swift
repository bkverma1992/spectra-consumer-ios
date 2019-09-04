//
//  InvoiceDetailViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/17/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import MessageUI

class InvoiceDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,UIWebViewDelegate {
    var networkClass = CANetworkManager()
  
    let realm = try? Realm()
    var userResult:Results<UserCurrentData>? = nil
    var userInvoiceResult:Results<InvoiceListData>? = nil
    var userTranscationResult:Results<TransactionData>? = nil
    var userInvoiceFilter:Results<FilterInvoiceClass>? = nil

    var appd = AppDelegate()
    var dataResponse = NSDictionary()
    var checkStatus = String()
    
    @IBOutlet var lblTitleName: UILabel!
    @IBOutlet var invoiceBTN: UIButton!
    @IBOutlet var ledgerBTN: UIButton!
    @IBOutlet var invoiceBtnLine: UILabel!
    @IBOutlet var ledgerBtnLine: UILabel!
    @IBOutlet var invoiceTblView: UITableView!
    
    var canID = String()
    @IBOutlet var transparentView: UIView!
    
    // invoice Details Outlets

    @IBOutlet var lblOutstandingAmt: UILabel!
    @IBOutlet var lblInvoiceDueStatus: UILabel!
    @IBOutlet var lblDueDate: UILabel!
    @IBOutlet var invoiceDuePayBTN: UIButton!
    
    @IBOutlet var lblSelectFromDate: UILabel!
    @IBOutlet var lblSelectToDate: UILabel!
    @IBOutlet var lblSelectFromIMG: UIImageView!
    @IBOutlet var lblSelectToIMG: UIImageView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var filterInvoiceBTN: UIButton!
   
    @IBOutlet var ledgerLblSelectFromDate: UILabel!
    @IBOutlet var ledgerLblSelectToDate: UILabel!
    @IBOutlet var ledgerLblSelectFromIMG: UIImageView!
    @IBOutlet var ledgerLblSelectToIMG: UIImageView!
    @IBOutlet var ledgerFilterInvoiceBTN: UIButton!
    
    @IBOutlet var doneButtonView: UIView!
    var checkPickerFrom = String()
    var fromDateString = String()
    var toDateString = String()
    
    @IBOutlet var ledgerTbleView: UITableView!
    @IBOutlet var invoicePayNwView: UIView!
    var outStadingAmntStr = String()
    var getDateWithFormate = String()
    @IBOutlet var ledgerFilterView: UIView!
    @IBOutlet var invoiceFilterView: UIView!
    @IBOutlet var invoiceStatusView: UIView!
    @IBOutlet var ledgerStatusView: UIView!

    @IBOutlet var pdfParantView: UIView!
    @IBOutlet var pdfWebView: UIWebView!
    var invoiceNumber = String()
    var sendInvoiceNumber = String()
    var htmlStr = String()
    var fileUrl = NSURL()
    var totalNumberOfDays = Int()
    var preBarred = Bool()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        appd = UIApplication.shared.delegate as! AppDelegate
        
        userResult = self.realm!.objects(UserCurrentData.self)
        if let userActData = userResult?[0]
        {
            outStadingAmntStr = userActData.OutStandingAmount
            getDateWithFormate = userActData.DueDate
            lblOutstandingAmt.text = outStadingAmntStr
            canID = userActData.CANId
            preBarred = userActData.PreBarredFlag
        }
        
        datePicker.isHidden = true
        transparentView.isHidden = true
        doneButtonView.isHidden = true
        checkPickerFrom = ""
        //getDateWithFormate = "15/07/2019"
        if outStadingAmntStr == "0"
        {
            setdataIntoDueDateLBL(setTextDueDates: "", withBool: true, setDueDatesStatus: "",prebarredFlag: preBarred)
            lblOutstandingAmt.text = "No Dues"
        }
        else
        {
            if (getDateWithFormate == "")
            {
                setdataIntoDueDateLBL(setTextDueDates: "", withBool: true, setDueDatesStatus: "", prebarredFlag: preBarred)
                lblOutstandingAmt.text = "No Dues"
            }
            else
            {
                setdataIntoDueDateLBL(setTextDueDates: "Due on", withBool: false, setDueDatesStatus: setChangeDateFormate(previousDateStr: getDateWithFormate),prebarredFlag: preBarred)
                lblOutstandingAmt.text = outStadingAmntStr
            }
        }
        
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            serviceTypeGetInvoiceListAPI()
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
        
        ledgerTbleView.isHidden=true
        self.tabBarController?.tabBar.isHidden = false
        setCornerRadiusView(radius: Float(invoicePayNwView.frame.height/2), color: UIColor.cornerBGFullOpack, view: invoicePayNwView)
        setCornerRadiusView(radius: Float(ledgerFilterView.frame.height/2), color: UIColor.clear, view: ledgerFilterView)
        setCornerRadiusView(radius: Float(invoiceFilterView.frame.height/2), color: UIColor.clear, view: invoiceFilterView)
        self.ledgerTbleView.estimatedRowHeight = 252
        self.ledgerTbleView.rowHeight = UITableView.automaticDimension
        invoiceStatusView.isHidden = true
        ledgerStatusView.isHidden = true
        pdfParantView.isHidden = true
  
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
        if tableView==invoiceTblView {
            if appd.segmentType == segment.userB2C {
                return 294
            }
            else
            {
                return 415
            }
        }
        return UITableView.automaticDimension
    }
    
      override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        if    appd.navigateFrom=="moreScreen"
        {
            setBelowlineColor(below1stTabLine: invoiceBtnLine, withColor: UIColor.black, below2ndTabLine: ledgerBtnLine, withColor2: .bgColors, btn1stTab: invoiceBTN, with1stBtnTabColor: UIColor.darkGray, btn2ndTab: ledgerBTN, with2ndBtnTabColor: .bgColors, setstatus: "PAYMENTS", toLabel: lblTitleName)
            ledgerTbleView.isHidden = false
            
            if ConnectionCheck.isConnectedToNetwork() == true
            {
                self.serviceTypeLedgerData(dateFrom: getLastNumberOfMonthPreviousDate(numberOfMonth: -6), toDate: getCurrentDate(withFormate: DateFormats.orderCurrentDateFormatOutPut))
            }
            else
            {
                showAlertC(message: AlertViewMessage.internetConnection)
            }
            
            appd.navigateFrom=""
            setTextWhenNotFilter(fromDateLabel: lblSelectFromDate, withFromStr: DefaultString.setSeletctdate, toDateLable: lblSelectToDate)
        }
        else
        {
            setBelowlineColor(below1stTabLine: invoiceBtnLine, withColor: .bgColors, below2ndTabLine: ledgerBtnLine, withColor2: UIColor.black, btn1stTab: invoiceBTN, with1stBtnTabColor: .bgColors , btn2ndTab: ledgerBTN, with2ndBtnTabColor: UIColor.darkGray, setstatus: "PAYMENTS", toLabel: lblTitleName)
            ledgerTbleView.isHidden = true
            setTextWhenNotFilter(fromDateLabel: ledgerLblSelectFromDate, withFromStr: DefaultString.setSeletctdate, toDateLable: ledgerLblSelectToDate)
        }
    }
  
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView==ledgerTbleView
        {
            return userTranscationResult!.count;
        }
        else if tableView==invoiceTblView
        {//para  userInvoiceResult!.count
            return userInvoiceResult!.count
        }
        
        return userInvoiceResult!.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         if (tableView==invoiceTblView)
        {
            var cell : InvoiceTableViewCell? = (invoiceTblView.dequeueReusableCell(withIdentifier: TableViewCellName.invoiceTableViewCell) as! InvoiceTableViewCell)
            if cell == nil {
                cell = InvoiceTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: TableViewCellName.invoiceTableViewCell)
            }
            
            if let invoiceStr = userInvoiceResult?[indexPath.row]
            {
                cell?.lblInvoiceNmbr.text = invoiceStr.displayInvNo
                cell?.lblDueDate.text = setInvoiceListDateFormate(previousDateStr: removestringAfterT(string: invoiceStr.duedt), withPreviousDateFormte: DateFormats.orderCurrentDateFormatOutPut, replaeWithFormate: DateFormats.orderDateFormatResult)
                cell?.lblInvoicePeriod.text = String(format: "%@ - %@",setInvoiceListDateFormate(previousDateStr: removestringAfterT(string: invoiceStr.startdt), withPreviousDateFormte: DateFormats.orderCurrentDateFormatOutPut, replaeWithFormate: DateFormats.orderDateFormat),  setInvoiceListDateFormate(previousDateStr: removestringAfterT(string: invoiceStr.enddt), withPreviousDateFormte: DateFormats.orderCurrentDateFormatOutPut, replaeWithFormate: DateFormats.orderDateFormat))
                cell?.lblInvoicedate.text = setInvoiceListDateFormate(previousDateStr: removestringAfterT(string: invoiceStr.invoicedt), withPreviousDateFormte: DateFormats.orderCurrentDateFormatOutPut, replaeWithFormate: DateFormats.orderDateFormatResult)

                if appd.segmentType == segment.userB2C
                {
                    cell?.lblManageScreen.isHidden = true
                    cell?.lblManageScreen.text = "I"
                    cell?.lblAmount.text = invoiceStr.amount
                    cell?.lblAmountD.text = "Amount"
                    cell?.lblOpeningAmt.text = ""
                    cell?.lblInvoiceAmt.text = ""
                    cell?.lblPayment.text = ""
                    cell?.lblTdsAmt.text = ""
                    cell?.lblOPENINGAmountD.isHidden = true
                    cell?.lbINVOICElAmountD.isHidden = true
                    cell?.lblPAYMENTAmountD.isHidden = true
                    cell?.lblTDSAmountD.isHidden = true
                    cell?.lblBtnName.text = "EMAIL"
                }
                else
                {
                    cell?.lblManageScreen.text = "iIIIIIl"
                    cell?.lblManageScreen.isHidden = true
                    cell?.lblAmount.text = invoiceStr.unPaidBalance
                    cell?.lblAmountD.text = "Unpaid Amount"
                    cell?.lblOpeningAmt.text = invoiceStr.openingBalance
                    cell?.lblInvoiceAmt.text = invoiceStr.invoiceCharge
                    cell?.lblTdsAmt.text = String(format: "%.2f ",invoiceStr.tdsAmount)
                    cell?.lblPayment.text = invoiceStr.unPaidBalance
                    cell?.lblOPENINGAmountD.isHidden = false
                    cell?.lbINVOICElAmountD.isHidden = false
                    cell?.lblPAYMENTAmountD.isHidden = false
                    cell?.lblTDSAmountD.isHidden = false
                    cell?.lblBtnName.text = "PAY NOW"
                }
            }
            
            cell?.invoiceViewButton.addTarget(self, action: #selector(invoiceViewButtonAction), for: .touchUpInside)
            cell?.invoiceEmailButton.addTarget(self, action: #selector(invoiceEmailButtonAction), for: .touchUpInside)
            setCornerRadiusView(radius: Float((cell?.viewInvoiceView.frame.height)!/2), color: UIColor.clear, view: cell!.viewInvoiceView)
            setCornerRadiusView(radius: Float((cell?.emailView.frame.height)!/2), color: UIColor.clear, view: cell!.emailView)
           
            return cell!
        }
        else if (tableView==ledgerTbleView)
        {
            var cell : TransactionTableViewCell? = (ledgerTbleView.dequeueReusableCell(withIdentifier: TableViewCellName.TrasactionTableViewCell) as! TransactionTableViewCell)
            
            if cell == nil {
                cell = TransactionTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: TableViewCellName.TrasactionTableViewCell)
            }
            
            if let trasData = userTranscationResult?[indexPath.row]
            {
             //   let dueDateStr = trasData.transactionDate
              //  cell?.lblTransDate.text = setInvoiceListDateFormate(previousDateStr: removestringAfterT(string: dueDateStr), withPreviousDateFormte: DateFormats.orderCurrentDateFormatOutPut, replaeWithFormate: DateFormats.orderDateFormatResult)
                cell?.lblTransDate.text = trasData.transactionDate
                cell?.lblTransNmbr.text = trasData.transactionNo
                cell?.lblTypePayment.text = trasData.type
                cell?.lblTransAmnt.text = trasData.amount
                cell?.lblPaymentMode.text = trasData.paymentMode
                cell?.lblDesc.text = trasData._description
               
//                if trasData.instrumentDetail == ""
//                {
//                    cell?.lblPaymentMode.text = "NA"
//                    cell?.lblDesc.text = trasData.narration
//                }
//                else
//                {
//                    cell?.lblPaymentMode.text = trasData.instrumentType
//                    cell?.lblDesc.text = trasData.instrumentDetail
//                }
            }
            return cell!
        }
        return UITableViewCell()
    }
    
    @objc func invoiceViewButtonAction(sender: UIButton!)
    {
        let buttonPosition = sender.convert(CGPoint.zero, to: invoiceTblView)
        let indexPath = invoiceTblView.indexPathForRow(at:buttonPosition)
        
       if let trasData = userInvoiceResult?[indexPath!.row]
       {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.invoiceDetailsIdentifier) as? InvoiceContentViewController
            vc?.invoiceNumber = trasData.invoiceNo
            vc?.sendInvoiceNumber = trasData.cslno
            self.navigationController?.pushViewController(vc!, animated: false)
       }
    }
    
    @objc func invoiceEmailButtonAction(sender: UIButton!)
    {
        let buttonPosition = sender.convert(CGPoint.zero, to: invoiceTblView)
        let indexPath = invoiceTblView.indexPathForRow(at:buttonPosition)
      //  sendEmail()
        var amountPay = String()
        
        if let trasData = userInvoiceResult?[indexPath!.row]
        {
            sendInvoiceNumber = trasData.cslno
            invoiceNumber = trasData.invoiceNo
            amountPay = trasData.unPaidBalance
        }
        
        if appd.segmentType == segment.userB2C
        {
            DispatchQueue.main.async {
                self.serviceTypeInvoiceContentData()
            }
        }
        else
        {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.PayNowIdentifier) as? PayNowViewController
            vc?.outStandingAmt = amountPay
            self.navigationController?.pushViewController(vc!, animated: false)
        }
    }
  
    @IBAction func duePaymentBTN(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.PayNowIdentifier) as? PayNowViewController
         vc?.outStandingAmt = lblOutstandingAmt.text!
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    @IBAction func filterTransactionBTN(_ sender: Any)
    {
        if ConnectionCheck.isConnectedToNetwork() == true
        {
           if (fromDateString != "" && toDateString != "")
           {
             ledgerFilterInvoiceBTN.isSelected = !ledgerFilterInvoiceBTN.isSelected
            if(ledgerFilterInvoiceBTN.isSelected == true)
            {
                self.serviceTypeLedgerData(dateFrom: fromDateString, toDate: toDateString)
            }
            else
            {
                ledgerLblSelectToDate.text = DefaultString.setSeletctdate
                ledgerLblSelectFromDate.text = DefaultString.setSeletctdate
                toDateString = ""
                fromDateString = ""
               self.serviceTypeLedgerData(dateFrom: getLastNumberOfMonthPreviousDate(numberOfMonth: -6), toDate: getCurrentDate(withFormate: DateFormats.orderCurrentDateFormatOutPut))
            }
         }
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
    }
    
    @IBAction func ledgerSelectFromButton(_ sender: Any)
    {
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
        
        selectFromDate(datePicker: datePicker, hiddenTranspView: transparentView, hiddenDoneBTNView: doneButtonView)
        checkPickerFrom = "FromDATE"
    }
    @IBAction func ledgerSelctTODateButton(_ sender: Any)
    {
        print(ledgerLblSelectFromDate.text as Any)
        if ledgerLblSelectFromDate.text != DefaultString.setSeletctdate
        {
            selectToDate(datePicker: datePicker, getFromStringDate: fromDateString, hiddenTranspView: transparentView, hiddenDoneBTNView: doneButtonView)
            checkPickerFrom = "ToDATE"
        }
    }
    
    @IBAction func selctTODateButton(_ sender: Any)
    {
        if lblSelectFromDate.text == DefaultString.setSeletctdate
        {
           print("Select From Date")
        }
        else
        {
            selectToDate(datePicker: datePicker, getFromStringDate: fromDateString, hiddenTranspView: transparentView, hiddenDoneBTNView: doneButtonView)
            checkPickerFrom = "ToDATE"
        }
    }
    
    @IBAction func selectFromButton(_ sender: Any)
    {
        
//        if checkPickerFrom == "ToDATE"
//        {
//            selectToDate(datePicker: datePicker, getFromStringDate: fromDateString, hiddenTranspView: transparentView, hiddenDoneBTNView: doneButtonView)
//             checkPickerFrom = "FromDATE"
//        }
//        else
//        {
            selectFromDate(datePicker: datePicker, hiddenTranspView: transparentView, hiddenDoneBTNView: doneButtonView)
            checkPickerFrom = "FromDATE"
    //    }
    }
    
    private func doneHandler() {
    
        transparentView.isHidden = true
    }
    
    private func completetionalHandler(month: Int, year: Int) {
        print( "month = ", month, " year = ", year )
    }
  
    // get date from selected date picker
    @IBAction func getDate(_ sender: Any)
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
                ledgerLblSelectFromDate.text = dateFormatter1.string(from: datePicker.date)
            }
            else
            {
//               if isLeapYear(year: toDateString)==true
//               {
//                    totalNumberOfDays = 366
//               }
//                else if (isLeapYear(year: dateFormatter.string(from: datePicker.date))==true)
//               {
//                    totalNumberOfDays = 366
//               }
//                else
//               {
//                    totalNumberOfDays = 365
//               }
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
                    ledgerLblSelectFromDate.text = dateFormatter1.string(from: datePicker.date)
                }
                else if 0>dayCount
                {
                    showAlertC(message: ErrorMessages.endYearValidation)
                }
                else
                {
                    fromDateString = dateFormatter.string(from: datePicker.date)
                    lblSelectFromDate.text = dateFormatter1.string(from: datePicker.date)
                    ledgerLblSelectFromDate.text = dateFormatter1.string(from: datePicker.date)
                }
            }
        }
        else
        {
            toDateString = dateFormatter.string(from: datePicker.date)
            lblSelectToDate.text = dateFormatter1.string(from: datePicker.date)
            ledgerLblSelectToDate.text = dateFormatter1.string(from: datePicker.date)
        }
    }
    
    @IBAction func doneDatePickerBTN(_ sender: Any) {
        transparentView.isHidden = true
        doneButtonView.isHidden = true
        datePicker.isHidden = true
    }
   
  //************************************************************ SERVICES ******************************************************
    func serviceTypeGetInvoiceListAPI()
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.getInvoiceList, forKey: "Action")
        dict .setValue(canID, forKey: "canID")
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
                        var dict1 = NSDictionary()
                        dict1 = response as! NSDictionary
                        var arr = NSArray()
                        arr = dict1.value(forKey: "response") as! NSArray
                        
                        try! self.realm!.write
                        {
                            if let users = self.realm?.objects(InvoiceListData.self) {
                                self.realm!.delete(users)
                            }
                        }
                        
                        for entry in arr {
                            
                            if let currentUser = Mapper<InvoiceListData>().map(JSONObject: entry) {
                                
                                try! self.realm!.write {
                                    self.realm!.add(currentUser)
                                }
                            }
                        }
                        
                        self.userInvoiceResult = self.realm!.objects(InvoiceListData.self)
                   
                    self.invoiceTblView.delegate = self
                    self.invoiceTblView.dataSource = self
                    self.invoiceTblView.reloadData()
                    self.invoiceStatusView.isHidden = true
                    self.ledgerStatusView.isHidden = true
                }
                else
                {
                    self.showAlertC(message:self.dataResponse.value(forKey: "message") as! String)
                }
            }
            else
            {
                self.invoiceTblView.delegate = self
                self.invoiceTblView.dataSource = self
                self.invoiceTblView.reloadData()
            }
        }
    }
    
    @IBAction func filterInvoiceBTN(_ sender: Any)
    {
    if ConnectionCheck.isConnectedToNetwork() == true
    {
        if (fromDateString != "" && toDateString != "")
        {
            filterInvoiceBTN.isSelected = !filterInvoiceBTN.isSelected
            
            if(filterInvoiceBTN.isSelected == true)
            {
                let dict = NSMutableDictionary()
                dict .setValue(ActionKeys.getInvoiceList, forKey: "Action")
                dict .setValue(fromDateString, forKey: "startDate")
                dict .setValue(toDateString, forKey: "endDate")
                dict .setValue(canID, forKey: "canID")
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
                            var dict1 = NSDictionary()
                            dict1 = response as! NSDictionary
                            var arr = NSArray()
                            arr = dict1.value(forKey: "response") as! NSArray
                            
                            try! self.realm!.write
                            {
                                if let users = self.realm?.objects(InvoiceListData.self) {
                                    self.realm!.delete(users)
                                }
                            }
                            
                            for entry in arr {
                                
                                if let currentUser = Mapper<InvoiceListData>().map(JSONObject: entry) {
                                    
                                    try! self.realm!.write {
                                        self.realm!.add(currentUser)
                                    }
                                }
                            }
                            self.userInvoiceResult = self.realm!.objects(InvoiceListData.self)
                            self.invoiceTblView.delegate = self
                            self.invoiceTblView.dataSource = self
                            self.invoiceTblView.reloadData()
                            self.invoiceStatusView.isHidden = true
                            self.ledgerStatusView.isHidden = true
                        }
                        else
                        {
                            self.showAlertC(message:dataResponse.value(forKey: "message") as! String)
                            self.invoiceStatusView.isHidden = false
                            self.ledgerStatusView.isHidden = true
                        }
                    }
                }
            }
            else
            {
                lblSelectToDate.text = DefaultString.setSeletctdate
                lblSelectFromDate.text = DefaultString.setSeletctdate
                toDateString = ""
                fromDateString = ""
               
                serviceTypeGetInvoiceListAPI()

              
            }
        }
    }
    else
    {
      showAlertC(message: AlertViewMessage.internetConnection)
    }
    }
    
    func serviceTypeLedgerData(dateFrom: String, toDate: String)  {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.paymentTransactionDetails, forKey: "Action")
        dict .setValue(canID, forKey: "canID") // 205315
        dict .setValue(dateFrom, forKey: "fromDate")
        dict .setValue(toDate, forKey: "toDate")
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
                    var dict1 = NSDictionary()
                    dict1 = response as! NSDictionary
                    var arr = NSArray()
                    arr = dict1.value(forKey: "response") as! NSArray
                    
                    try! self.realm!.write
                    {
                        if let users = self.realm?.objects(TransactionData.self) {
                            self.realm!.delete(users)
                        }
                    }
                    
                    for entry in arr {
                        
                        if let currentUser = Mapper<TransactionData>().map(JSONObject: entry) {
                            
                            try! self.realm!.write {
                                self.realm!.add(currentUser)
                                
                            }
                        }
                    }
                    
                    self.userTranscationResult = self.realm!.objects(TransactionData.self)
                    
                    self.ledgerTbleView.delegate=self
                    self.ledgerTbleView.dataSource=self
                    self.ledgerTbleView.reloadData()
                    self.invoiceStatusView.isHidden = true
                    self.ledgerStatusView.isHidden = true
                }
                else
                {
                    self.showAlertC(message:dataResponse.value(forKey: "message") as! String)
                    self.invoiceStatusView.isHidden = true
                    self.ledgerStatusView.isHidden = false
                }
            }
        }
    }
    
    
    @IBAction func clickInvoiceBTN(_ sender: Any)
    {
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            serviceTypeGetInvoiceListAPI()
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
        
       setTextWhenNotFilter(fromDateLabel: lblSelectFromDate, withFromStr: DefaultString.setSeletctdate, toDateLable: lblSelectToDate)

        setBelowlineColor(below1stTabLine: invoiceBtnLine, withColor: .bgColors, below2ndTabLine: ledgerBtnLine, withColor2: UIColor.black, btn1stTab: invoiceBTN, with1stBtnTabColor: .bgColors , btn2ndTab: ledgerBTN, with2ndBtnTabColor: UIColor.darkGray, setstatus: "PAYMENTS", toLabel: lblTitleName)
        ledgerTbleView.isHidden = true
    }
    
    @IBAction func clickLedgerBTN(_ sender: Any)
    {
        setTextWhenNotFilter(fromDateLabel: ledgerLblSelectFromDate, withFromStr: DefaultString.setSeletctdate, toDateLable: ledgerLblSelectToDate)

        setBelowlineColor(below1stTabLine: invoiceBtnLine, withColor: UIColor.black, below2ndTabLine: ledgerBtnLine, withColor2: .bgColors, btn1stTab: invoiceBTN, with1stBtnTabColor: UIColor.darkGray, btn2ndTab: ledgerBTN, with2ndBtnTabColor: .bgColors, setstatus: "PAYMENTS", toLabel: lblTitleName)
        ledgerTbleView.isHidden = false
        toDateString = ""
        fromDateString = ""
        
        if ConnectionCheck.isConnectedToNetwork() == true
        {
            self.serviceTypeLedgerData(dateFrom: getLastNumberOfMonthPreviousDate(numberOfMonth: -6), toDate: getCurrentDate(withFormate: DateFormats.orderCurrentDateFormatOutPut))
        }
        else
        {
            showAlertC(message: AlertViewMessage.internetConnection)
        }
    }
    
    func setdataIntoDueDateLBL(setTextDueDates: String,withBool: Bool,setDueDatesStatus: String,prebarredFlag: Bool )
    {
        if prebarredFlag==false {
            self.lblDueDate.textColor = UIColor.black
        }
        else
        {
            self.lblDueDate.textColor = UIColor.red
        }
        
        lblDueDate.text = setTextDueDates
        invoicePayNwView.isHidden = withBool
        lblInvoiceDueStatus.text = setDueDatesStatus
    }
    
    func setTextWhenNotFilter(fromDateLabel: UILabel, withFromStr: String, toDateLable: UILabel) {
        fromDateLabel.text = withFromStr
        toDateLable.text = withFromStr
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["bhoopendra.verma@affle.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true)
//    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func serviceTypeInvoiceContentData()
    {
        let dict = NSMutableDictionary()
        dict .setValue(ActionKeys.invoiceContent, forKey: "Action")
        dict .setValue(invoiceNumber, forKey: "invoiceNo")
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
                    self.htmlStr = dataResponse.value(forKey: "response") as! String
                    self.pdfWebView.loadHTMLString(self.htmlStr, baseURL: nil)
                    self.pdfWebView.delegate = self
                    //                    self.openPDFView() remove webview from this screen
                    self.pdfWebView.isHidden = true
                }
                else
                {
                    self.showAlertC(message:dataResponse.value(forKey: "message") as! String)
                }
            }
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        openPDFView()
    }
    
    func openPDFView() {
        let render = UIPrintPageRenderer()
        render.addPrintFormatter((self.pdfWebView?.viewPrintFormatter())!, startingAtPageAt: 0)
        let page = CGRect(x: 0, y: 0, width: pdfWebView.frame.width, height: pdfWebView.frame.height)
        render.setValue(NSValue(cgRect:page),forKey:"paperRect")
        render.setValue(NSValue(cgRect:page), forKey: "printableRect")
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData,page, nil)
        
        for i in 1...render.numberOfPages-1
        {
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        
        UIGraphicsEndPDFContext();
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsDirectory)
        var nameOfFile = String()
        nameOfFile = String(format: "%@.pdf", invoiceNumber)
        fileUrl = documentsDirectory.appendingPathComponent(nameOfFile) as NSURL;
        attachedPdfFileToMail()
    }

    func attachedPdfFileToMail()
    {
    if MFMailComposeViewController.canSendMail() {
    let mailComposer = MFMailComposeViewController()
    mailComposer.setSubject("")
    mailComposer.setMessageBody("Invoice", isHTML: false)
    mailComposer.setToRecipients([""])
    do {
    let attachmentData = try Data(contentsOf: fileUrl as URL)
    mailComposer.addAttachmentData(attachmentData, mimeType: "application/pdf", fileName: invoiceNumber)
    mailComposer.mailComposeDelegate = self
    self.present(mailComposer, animated: true
    , completion: nil)
    } catch let error {
    print("We have encountered error \(error.localizedDescription)")
    }
    
    } else {
    print("Email is not configured in settings app or we are not able to send an email")
    }
}
    
    //MARK:- MailcomposerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("User cancelled")
            break
            
        case .saved:
            print("Mail is saved by user")
            break
            
        case .sent:
            print("Mail is sent successfully")
            break
            
        case .failed:
            print("Sending mail is failed")
            break
        default:
            break
        }
        
        controller.dismiss(animated: true)
        
    }

    
}

