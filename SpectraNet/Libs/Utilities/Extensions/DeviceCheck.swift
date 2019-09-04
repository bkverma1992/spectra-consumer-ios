//
//  DeviceCheck.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/18/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import Foundation
import UIKit


extension UIScreen {
//    var iPhoneX: Bool {
//        return UIScreen.main.nativeBounds.height == 2436
//    }
//    var iPhone: Bool {
//        return UIDevice.current.userInterfaceIdiom == .phone
//    }
//    enum ScreenType: String {
//        case iPhone4 = "iPhone 4 or iPhone 4S"
//        case iPhone5 = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
//        case iPhone6 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
//        case iPhone6Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
//        case iPhoneX_XS = "iPhone X or iPhone XS"
//        case iPhoneXR = "iPhone XR"
//        case iPhone_XSMax = "iPhone XS Max"
//        case unknown
//    }
//    var screenType: ScreenType {
//        switch UIScreen.main.nativeBounds.height {
//        case 960:
//            return .iPhone4
//        case 1136:
//            return .iPhone5
//        case 1334:
//            return .iPhone6
//        case 1792:
//            return .iPhoneXR
//        case 1920, 2208:
//            return .iPhone6Plus
//        case 2436:
//            return .iPhoneX_XS
//        case 2688:
//            return .iPhone_XSMax
//        default:
//            return .unknown
//        }
//    }
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone4 = 960.0
        case iPhone5 = 1136.0
        case iPhone6 = 1334.0
        case iPhone6Plus = 1920.0
        case iPhoneXR = 1792.0
        case iPhoneX_XS = 2436.0
        case iPhoneXSMax = 2688.0
    }
    
    
    
    

    var sizeType: SizeType {
        let height = nativeBounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
}


