//
//  ActionFlea.swift
//  FleaSample
//
//  Created by 廖雷 on 16/7/6.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import Foundation

struct ActionItem {
    var image: UIImage?
    var text: String?
    var action: (() -> Void)?
}

class ActionButton: UIButton {
    
}

public class ActionFlea: Flea {
    
    public var title = ""
    public var details = ""
    private var actions = [ActionItem]()
    
    private var titleLabel = UILabel()
    private var detailsLabel = UILabel()
    private var buttons = [ActionButton]()
    
    public init(title: String, details: String) {
        super.init(frame: CGRect())
        
        self.title = title
        self.details = details
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addAction(text: String?, image: UIImage?, action: (() -> Void)?) -> Self {
        return self
    }
    
}