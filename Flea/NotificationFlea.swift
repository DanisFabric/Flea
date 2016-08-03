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
    
    public func prepareContentView() {
        
        let contentView = UIView()
        contentView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 36)
        
        titleLabel.text = title
        if let actionTitle = actionTitle {
            actionButton.setTitle(actionTitle, forState: .Normal)
        }
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionButton)
        contentView.addSubview(closeButton)
        
        fill(contentView)
    }
}