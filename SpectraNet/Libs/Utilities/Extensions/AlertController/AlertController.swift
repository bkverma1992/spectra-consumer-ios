//
//  AlertController.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/12/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func showAlertC(message: String)
    {
    let alert = UIAlertController(title: "SpectraNet", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true)
    }
}
