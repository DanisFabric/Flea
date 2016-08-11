//
//  FleaNotificationView.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/1.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit

class FleaNotificationView: UIView {

    weak var flea: Flea?
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var actionItem: FleaActionItem? {
        didSet {
            actionButton.setTitle(actionItem?.title, forState: .Normal)
            actionButton.setTitleColor(actionItem?.color, forState: .Normal)
        }
    }
    
    var titleLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(15)
        label.numberOfLines = 0
        
        return label
    }()
    var closeButton = { () -> UIButton in
        let button = UIButton(type: .System)
        button.setImage(UIImage(named: "flea-close"), forState: .Normal)
        button.tintColor = UIColor.whiteColor()
        
        return button
    }()
    var actionButton = { () -> UIButton in
        let button = UIButton(type: .System)
        
        return button
    }()
    
    @objc private func onClose(sender: UIButton) {
        flea?.dismiss()
    }
}

extension FleaNotificationView: FleaContentView {
    func prepareInView(view: UIView) {
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(actionButton)
        closeButton.addTarget(self, action: #selector(onClose(_:)), forControlEvents: .TouchUpInside)
        
        let size = CGSize(width: view.bounds.width, height: 44)
        
        closeButton.frame = CGRect(x: 10, y: 0, width: size.height, height: size.height)
        
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: closeButton.frame.maxX + 5, y: 0, width: titleLabel.frame.width, height: size.height)
        
        actionButton.sizeToFit()
        print(actionButton.frame)
        actionButton.frame = CGRect(x: size.width - actionButton.frame.width - 20, y: 0, width: actionButton.frame.width, height: size.height)
        
        frame = CGRect(origin: CGPoint(), size: size)
    }
}
