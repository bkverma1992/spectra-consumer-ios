//
//  RemoveStringAfterSpecificChar.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/18/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func removestringAfterT(string: String) -> String
    {
        var getFilterString = String()
        if let index = string.range(of: "T")?.lowerBound
        {
            let substring = string[..<index]
            getFilterString = String(substring)
            print(getFilterString)
        }
        return getFilterString
    }
  
    func removestringAfterSPACE(string: String) -> String
    {
        var getFilterString = String()
        if let index = string.range(of: " ")?.lowerBound
        {
            let substring = string[..<index]
            getFilterString = String(substring)
            print(getFilterString)
        }
        return getFilterString
    }
    
    
    func replaceStringWithStr(yourString: String,replaceStr: String, withSyring: String) -> String
    {
        let replaced = yourString.replacingOccurrences(of: replaceStr, with: withSyring)
       return replaced
    }
}

