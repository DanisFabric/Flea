//
//  NotificationFlea.swift
//  FleaSample
//
//  Created by 廖雷 on 16/7/6.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import Foundation

public class NotificationFlea: Flea {
    public var image: UIImage?
    public var title: String?
    public var actionTitle: String?
    public var action: (() -> Void)?
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let actionButton = UIButton()
    
    public init(title: String, image: UIImage?, action:(title: String, handler: ()->Void)) {
        super.init(frame: CGRect())
        
        self.title = title
        self.image = image
        self.actionTitle = action.title
        self.action = action.handler
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepare() {
        super.prepare()
        
        let contentView = UIView()
        
    }
}