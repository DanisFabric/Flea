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
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

public struct FleaPalette {
    public static let Black     = UIColor(hex: 0x1B242E)
    public static let DarkGray  = UIColor(hex: 0x606B78)
    public static let LightGray = UIColor(hex: 0xB3B7C1)
    public static let DarkWhite = UIColor(hex: 0xEEEEEE)
    public static let Red       = UIColor(hex: 0xE63636)
    public static let Green     = UIColor(hex: 0x5ED163)
    public static let Blue      = UIColor(hex: 0x3388FF)
    
}