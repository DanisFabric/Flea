//
//  FleaAlertView.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/1.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit

class FleaAlertView: UIView {

    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    var subTitle: String? {
        get {
            return subTitleLabel.text
        }
        set {
            subTitleLabel.text = newValue
        }
    }
    
    var actionItems = [FleaActionItem]()
    
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
