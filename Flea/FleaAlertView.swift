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
    
    var titleLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = FleaPalette.DarkGray
        label.textAlignment = .Center
        label.font = UIFont.boldSystemFontOfSize(17)
        label.numberOfLines = 0
        
        return label
    }()
    var subTitleLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = FleaPalette.LightGray
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(13)
        label.numberOfLines = 0
        
        return label
    }()
    private var buttons = [FleaAlertButton]()
}

extension FleaAlertView: FleaContentView {
    func prepareInView(view: UIView) {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        let contentWidth = view.bounds.width * 0.8
        let textMargin: CGFloat = 20
        let textWidth = contentWidth - textMargin * 2
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
        
        if actionItems.count == 2 {
            let button1 = FleaAlertButton(type: .System)
            let button2 = FleaAlertButton(type: .System)
            button1.setTitle(actionItems[0].title, forState: .Normal)
            button1.setTitleColor(actionItems[0].color, forState: .Normal)
            button2.setTitle(actionItems[1].title, forState: .Normal)
            button2.setTitleColor(actionItems[1].color, forState: .Normal)
            
            button1.frame = CGRect(x: 0, y: maxY, width: contentWidth/2, height: 44)
            button2.frame = CGRect(x: contentWidth/2, y: maxY, width: contentWidth/2, height: 44)
            maxY += 44
            
            addSubview(button1)
            addSubview(button2)
            
            buttons.appendContentsOf([button1,button2])
        }else {
            for item in actionItems {
                let button = FleaAlertButton(type: .System)
                button.setTitle(item.title, forState: .Normal)
                button.setTitleColor(item.color, forState: .Normal)
                button.frame = CGRect(x: 0, y: maxY, width: contentWidth, height: 44)
                maxY += 44
                
                addSubview(button)
                buttons.append(button)
            }
        }
        
        self.frame = CGRect(x: 0, y: 0, width: contentWidth, height: maxY)
    }
}

private class FleaAlertButton: UIButton {
    
    private override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        backgroundColor = FleaPalette.DarkWhite
    }
    private override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        backgroundColor = UIColor.whiteColor()
    }
    private override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        backgroundColor = UIColor.whiteColor()
    }
}