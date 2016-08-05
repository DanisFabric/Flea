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
    private var buttons = [UIButton]()

}

extension FleaActionView: FleaContentView {
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
        
        if titleLabel.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
            titleLabel.frame = CGRect(x: textMargin, y: textMargin, width: textWidth, height: titleLabel.frame.height)
            maxY = titleLabel.frame.maxY
        }
        if subTitleLabel.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
            subTitleLabel.frame = CGRect(x: textMargin, y: maxY + textMargin, width: textWidth, height: subTitleLabel.frame.height)
            maxY = subTitleLabel.frame.maxY
        }
        maxY += textMargin
        
        for item in actionItems {
            let button = UIButton(type: .System)
            button.setTitle(item.title, forState: .Normal)
            button.setTitleColor(item.color, forState: .Normal)
            button.frame = CGRect(x: 0, y: maxY, width: view.bounds.width, height: 44)
            maxY += 44
            
            addSubview(button)
            buttons.append(button)
        }
        
        self.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: maxY)
    }
    
}

private class FleaActionButton: UIButton {
    
    
}
