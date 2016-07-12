//
//  NotificationFlea.swift
//  FleaSample
//
//  Created by 廖雷 on 16/7/6.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import Foundation

public class NotificationFlea: Flea {
    public var title: String?
    public var actionTitle: String?
    public var action: (() -> Void)?
    
    public var titleLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.blackColor()
        label.font = UIFont.boldSystemFontOfSize(13)
        
        return label
    }()
    public let actionButton = { () -> UIButton in
        let button = UIButton(type: .System)
        button.tintColor = UIColor.blackColor()
        
        return button
    }()
    public let closeButton = { () -> UIButton in
        let button = UIButton(type: .System)
        button.setImage(UIImage(named: "flea-close"), forState: .Normal)
        button.tintColor = UIColor.blackColor()
        
        return button
    }()
    
    public init(title: String, action:(title: String, handler: ()->Void)? = nil) {
        super.init(frame: CGRect())
        
        self.title = title
        self.actionTitle = action?.title
        self.action = action?.handler
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
        super.prepare()
        
        let contentView = UIView()
        contentView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 36)
        
        titleLabel.text = title
        if let actionTitle = actionTitle {
            actionButton.setTitle(actionTitle, forState: .Normal)
        }
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionButton)
        contentView.addSubview(closeButton)
        
//        let c1 = NSLayoutConstraint(item: closeButton, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1.0, constant: 10)
//        let c2 = NSLayoutConstraint(item: closeButton, attribute: .Width, relatedBy: .Equal, toItem: contentView, attribute: .Height, multiplier: 1.0, constant: 0)
//        let c3 = NSLayoutConstraint(item: closeButton, attribute: .Height, relatedBy: .Equal, toItem: closeButton, attribute: .Width, multiplier: 1.0, constant: 0)
//        let c4 = NSLayoutConstraint(item: closeButton, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 0)
//        
//        closeButton.addConstraints([c1,c2,c3,c4])
//        
//        let a1 = NSLayoutConstraint(item: actionButton, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1.0, constant: -10)
//        let a2 = NSLayoutConstraint(item: actionButton, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 0)
//        let a3 = NSLayoutConstraint(item: actionButton, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: 0)
//        
//        actionButton.addConstraints([a1,a2,a3])
//        
//        let t1 = NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: closeButton, attribute: .Right, multiplier: 1.0, constant: 5.0)
//        let t2 = NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1.0, constant: 0)
//        let t3 = NSLayoutConstraint(item: titleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1.0, constant: 0)
//        let t4 = NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: closeButton, attribute: .Left, multiplier: 1.0, constant: 5)
//        
//        titleLabel.addConstraints([t1,t2,t3,t4])
        
        fill(contentView)
    }
}