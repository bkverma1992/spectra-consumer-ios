//
//  MoreViewController.swift
//  SpectraNet
//
//  Created by Yugasalabs-28 on 23/07/2019.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // More View Outlets
    
    var appd = AppDelegate()
    
    @IBOutlet weak var moreTblView: UITableView!
    @IBOutlet var helptbleView: UITableView!
    @IBOutlet var helpImg: UIImageView!
    var moreListArray = NSArray()
    var moreImgArr = NSArray()
    @IBOutlet var helpCatView: UIView!
    
    var helpListArray = NSArray()
    var helpImgArr = NSArray()
    @IBOutlet var lblDummyHandelScroll: UILabel!
    @IBOutlet var helpCatBtn: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appd = UIApplication.shared.delegate as! AppDelegate
        
        moreListArray = ["My Plan","MyTransactions","My Account","Data Usage"]
        moreImgArr = ["plan.png","MyTransaction.png","myAcnt.png","dataUsage.png"]

        helpListArray = ["FAQ","Troubleshooting","Create SR","Contact Us"]
        helpImgArr = ["faq","trblShoot","CreateSR","contact"]
        
        
        moreTblView.reloadData()
        helpCatView.isHidden = true
        lblDummyHandelScroll.text = "" //dummyUsingHome.menuDummyLable1
        moreTblView.isScrollEnabled = false
        helptbleView.isScrollEnabled = false
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        if tableView==moreTblView {
             return moreListArray.count
        }
        if tableView==helptbleView {
             return helpListArray.count
        }
        return moreListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView==moreTblView {
            var cell : MoreTableViewCell? = (moreTblView.dequeueReusableCell(withIdentifier: TableViewCellName.moreTableViewCell) as! MoreTableViewCell)
            
            if cell == nil {
                cell = MoreTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: TableViewCellName.moreTableViewCell)
            }
            
            if indexPath.row==0 {
                cell?.containerView.backgroundColor = .bgColors
            }
            cell?.lblMoreTitleName.text = (moreListArray[indexPath.row] as! String)
            // cell?.moreTitleImg.text = ((invoiceListArray[indexPath.row] as AnyObject) .value(forKey: "amount") as! String)
            cell?.moreTitleImg.image = UIImage(named: moreImgArr[indexPath.row] as! String)
            return cell!
        }
        if tableView==helptbleView {
            var cell : HelpCatTableViewCell? = (helptbleView.dequeueReusableCell(withIdentifier: TableViewCellName.helpTableViewCell) as! HelpCatTableViewCell)
            
            if cell == nil {
                cell = HelpCatTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: TableViewCellName.helpTableViewCell)
            }
            cell?.titla.text = (helpListArray[indexPath.row] as! String)
            cell?.img.image = UIImage(named: helpImgArr[indexPath.row] as! String)
            return cell!
        }
        
        
            return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView==moreTblView {
            if indexPath.row == 0 {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.planIdentifier) as? PlanViewController
                self.navigationController?.pushViewController(vc!, animated: false)
            }
            else if (indexPath.row==1)
            {
                appd.navigateFrom="moreScreen"
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.customTabIdentifier) as? CustomTabViewController
                self.navigationController?.pushViewController(vc!, animated: false)
            }
            else if (indexPath.row==2)
            {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.AccountIdentifier) as? AccountViewController
                self.navigationController?.pushViewController(vc!, animated: false)
            }
            else if (indexPath.row==3)
            {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.dataUsageIdentifier) as? DataUsageViewController
                self.navigationController?.pushViewController(vc!, animated: false)
                
            }
        }
        if tableView==helptbleView {
            if indexPath.row == 0 {
                if appd.segmentType==segment.userB2C
                {
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.faqIdentifier) as? FaqViewController
                    self.navigationController?.pushViewController(vc!, animated: false)
                }
                else
                {
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.businessIdentifier) as? BusinessFaqViewController
                    self.navigationController?.pushViewController(vc!, animated: false)
                }
            }
            else if (indexPath.row==1)
            {
               
            }
            else if (indexPath.row==2)
            {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ViewIdentifier.CreateSRIdentifier) as? CreateSRViewController
                self.navigationController?.pushViewController(vc!, animated: false)
            }
            else if (indexPath.row==3)
            {
                
            }
        }
    }

    @IBAction func logoutBTN(_ sender: Any)
    {
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC()
    }
    @IBAction func helpCatBTN(_ sender: Any) {
        helpCatBtn.isSelected = !helpCatBtn.isSelected
        if helpCatBtn.isSelected
        {
           helpImg.image = UIImage(named: "upper")
            helpCatView.isHidden = false
            if UIScreen.main.sizeType == .iPhone6Plus
            {
                lblDummyHandelScroll.text = dummyUsingHome.iphone8PlusmenuDummy
            }
           else if UIScreen.main.sizeType == .iPhone5
            {
                lblDummyHandelScroll.text = dummyUsingHome.iphone5PlusmenuDummy
            }
            else
            {
                lblDummyHandelScroll.text = dummyUsingHome.menuDummyLable
            }
        }
        else
        {
            lblDummyHandelScroll.text = "" //dummyUsingHome.menuDummyLable1
            helpImg.image = UIImage(named: "down")
            helpCatView.isHidden = true
        }
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
