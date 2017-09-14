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
    var widthScale: CGFloat = 1.0
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var titleLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        
        return label
    }()
}

extension FleaNotificationView: FleaContentView {
    func willBeAdded(to flea: Flea) {
        addSubview(titleLabel)
        
        self.frame = CGRect(x: 0, y: 0, width: flea.bounds.width * widthScale, height: 32)
        titleLabel.frame = self.bounds
    }
}
