//
//  CanIDViewController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 8/8/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class CanIDViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let realm = try? Realm()
    var userResult:Results<UserData>? = nil
    var userCurrentData:Results<UserCurrentData>? = nil

    @IBOutlet var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userResult = self.realm!.objects(UserData.self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userResult!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : CanIDTableViewCell? = (tblView.dequeueReusableCell(withIdentifier: TableViewCellName.canIDTableViewCell) as! CanIDTableViewCell)
        
        if cell == nil {
            cell = CanIDTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: TableViewCellName.canIDTableViewCell)
        }
        print(indexPath.row)
        
         cell?.lblAcount.text = String(format: "Account %d", indexPath.row+1)

        if indexPath.row==0 {
          
        }
        else
        {
            cell?.lblAcount.textColor = UIColor.bgHalfOpackWithWhite
            cell?.lblUserCanID.textColor = UIColor.viewBackgroundHalfOpack
        }
        
        if let userData = userResult?[indexPath.row]
        {
            cell?.lblUserCanID.text = String(format: "CAN ID - %@", userData.CANId)
        }
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        try! self.realm!.write
         {
            if let users = self.realm?.objects(UserCurrentData.self) {
            self.realm!.delete(users)
          }
        }
        
        if let ddd = userResult?[indexPath.row] {
        if let currentUser = Mapper<UserCurrentData>().map(JSONObject: ddd) {
            
            try! self.realm!.write {
                self.realm!.add(currentUser)
                }
            }
        }
      
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
