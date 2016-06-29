//
//  Flea.swift
//  FleaSample
//
//  Created by 廖雷 on 16/6/29.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit

enum Direction {
    case Top
    case Left
    case Bottom
    case Right
}

enum FleaType {
    case Page
    case Card
}

class Flea: UIView {
    var direction = Direction.Top
    var type = FleaType.Page
    
    func show() {
        
    }
    
    func dismiss() {
        
    }
    
}

extension Flea {
    func relativeTo(responder: UIResponder) -> Flea {
        // view
        // uiviewcontroller
        return self
    }
}
