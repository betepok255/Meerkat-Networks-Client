//
//  Enums.swift
//  Meerkat Networks Client
//
//  Created by Marvell on 19.11.15.
//  Copyright © 2015 Meerkat Networks. All rights reserved.
//

import UIKit

public enum MNColor: Int {
    case Green = 0x10B76A
    case Red = 0xDC4663
    
    case Gray = 0x808080
    case GrayDark = 0x333333
    
    case Blue = 0x5774A2
    case BlueDark = 0x003366
    case BlueLight = 0x3366FF
    
    case CyanDark = 0x4285F4
    
    case MNC = 0x007AA3
//    case Green = ""
}

//public extension UIColor {
//    convenience init(hex : Int) {
//        let blue = CGFloat(hex & 0xFF)
//        let green = CGFloat((hex >> 8) & 0xFF)
//        let red = CGFloat((hex >> 16) & 0xFF)
//        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
//    }
//}