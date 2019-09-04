//
//  PlaceholderTextColorChange.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/12/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func placeholderTextColor(textfeildName: UITextField, placeHolderText: String, withColor: UIColor)
    {
        textfeildName.attributedPlaceholder = NSAttributedString(string: placeHolderText,attributes: [NSAttributedString.Key.foregroundColor: withColor])
    }
    
}

