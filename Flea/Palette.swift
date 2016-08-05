//
//  Palette.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/5.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import Foundation


extension UIColor {
    convenience init(hex: UInt) {
        let red   = CGFloat(hex & 0x110000) / 255
        let green = CGFloat(hex & 0x001100) / 255
        let blue  = CGFloat(hex & 0x000011) / 255
        
        self.init(red: red, green: blue, blue: green, alpha: 1.0)
    }
}

struct Palette {
    static let darkGray = UIColor(hex: 0x00000)
    static let gray     = UIColor(hex: 0x00000)
    static let red      = UIColor(hex: 0x0000)
    static let green    = UIColor(hex: 0x0000)
    static let blue     = UIColor(hex: 0x0000)
    
}