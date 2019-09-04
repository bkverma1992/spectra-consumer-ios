//
//  Ecard.swift
//  MaxBupa
//
//  Created by Rohit S on 4/13/18.
//  Copyright © 2018 AppStudioz. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class Ecard: Object, Mappable  {
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    @objc dynamic var UserName = ""
    @objc dynamic var PlanName = ""
    @objc dynamic var PolicyName = ""
    @objc dynamic var PolicyNumber = ""
    @objc dynamic var CommencementDate = ""
    @objc dynamic var ExpiryDate = ""
    @objc dynamic var CustomerID = ""
    @objc dynamic var MemberID = ""
    @objc dynamic var IsHealthCoach = ""
    @objc dynamic var DOB = ""
    @objc dynamic var Gender = ""
    @objc dynamic var MobileNumber = ""
    @objc dynamic var Priority = false
    var RenewalFlag = ""
    
    func mapping(map: Map) {
        
        UserName <- map["UserName"]
        CommencementDate <- map["CommencementDate"]
        ExpiryDate <- map["ExpiryDate"]
        CustomerID <- map["CustomerID"]
        DOB <- map["DOB"]
        Gender <- map["Gender"]
        IsHealthCoach <- map[IsHealthCoach]
        MemberID <- map["MemberID"]
        MobileNumber <- map["MobileNumber"]
        PlanName <- map["PlanName"]
        PolicyName <- map["PolicyName"]
        PolicyNumber <- map["PolicyNumber"]
        Priority <- map["Priority"]
        RenewalFlag <- map["RenewalFlag"]
        if let _Priority = map["Priority"].currentValue as? String {
            Priority =  _Priority.lowercased() == "true"
        }
    }
    
}
