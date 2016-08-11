//
//  FleaNotificationView.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/1.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit

class FleaNotificationView: UIView {

    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var actionItem: FleaActionItem?
    
    var titleLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(15)
        label.numberOfLines = 0
        
        return label
    }()
    var closeButton = { () -> UIButton in
        let button = UIButton(type: .System)
        button.setImage(UIImage(named: "flea-close"), forState: .Normal)
        
        return button
    }()
    var actionButton = { () -> UIButton in
        let button = UIButton(type: .System)
        
        return button
    }()
}

extension FleaNotificationView: FleaContentView {
    func prepareInView(view: UIView) {
        addSubview(titleLabel)
        addSubview(closeButton)
        
    }
}
