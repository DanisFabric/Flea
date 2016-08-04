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

class FleaActionView: UIView, FleaContentView {

    var title: String? {
        set {
            titleLabel.text = newValue
        }
        get {
            return titleLabel.text
        }
    }
    var subTitle: String? {
        set {
            subTitleLabel.text = newValue
        }
        get {
            return subTitleLabel.text
        }
    }
    
    var actionItems = [FleaActionItem]()
    
    var titleLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(15)
        label.numberOfLines = 0
        
        return label
    }()
    var subTitleLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(13)
        label.numberOfLines = 0
        
        return label
    }()
    var buttons = [UIButton]()

    func prepareInView(view: UIView) {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        let textMargin: CGFloat = 20
        let textWidth = view.bounds.width - textMargin * 2
        var maxY: CGFloat = 0
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: textWidth, height: 0)
        titleLabel.sizeToFit()
        
        subTitleLabel.frame = CGRect(x: 0, y: 0, width: textWidth, height: 0)
        subTitleLabel.sizeToFit()
        
        titleLabel.frame = CGRect(x: textMargin, y: textMargin, width: titleLabel.frame.width, height: titleLabel.frame.height)
        
        subTitleLabel.frame = CGRect(x: textMargin, y: titleLabel.frame.maxY + textMargin, width: subTitleLabel.frame.width, height: subTitleLabel.frame.height)
        
        for item in actionItems {
            let button = UIButton()
            
            addSubview(button)
            buttons.append(button)
        }
    }
}

private class FleaActionButton: UIButton {
    
    
}
