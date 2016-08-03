//
//  FleaActionView.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/1.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit

struct FleaActionItem {
    var title = ""
    var color = UIColor.blueColor()
    var action: (() -> Void)?
}

class FleaActionView: UIView {

    var title: String?
    var subTitle: String?
    
    var actionItems = [FleaActionItem]()
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
