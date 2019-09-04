//
//  UITextfield+BottomBorderLine.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/12/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func bottomLineTextfield(textfield: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textfield.frame.height-1, width: textfield.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        textfield.borderStyle = UITextField.BorderStyle.none
        textfield.layer.addSublayer(bottomLine)
    }
}

