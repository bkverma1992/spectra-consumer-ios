//
//  KeybordAnimation.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/12/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController
{
    func ViewUpanimateMoving (up:Bool, upValue :CGFloat){
        let durationMovement:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -upValue : upValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(durationMovement)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
