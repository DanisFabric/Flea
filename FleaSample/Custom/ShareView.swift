//
//  ShareView.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/19.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit
import Flea

private let PreferedItemWidth: CGFloat = 60
private let PreferedItemHeight: CGFloat = 80

class ShareItemView: UIView {
    let imageView = UIImageView()
    let textLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = FleaPalette.DarkGray
        label.font = UIFont.systemFontOfSize(13)
        label.textAlignment = .Center
        
        return label
    }()
    var didTapAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0, y: 0, width: PreferedItemWidth, height: PreferedItemWidth)
        textLabel.frame = CGRect(x: 0, y: PreferedItemWidth, width: PreferedItemWidth, height: PreferedItemHeight - PreferedItemWidth)
    }
}

class ShareView: UIView {
    var itemViews = [ShareItemView]()
    
}

extension ShareView: FleaContentView {
    func prepareInView(view: UIView) {
        let margin = UIOffset(horizontal: 20, vertical: 20)
        let toEdge = UIOffset(horizontal: 20, vertical: 20)
        
        var maxY = toEdge.vertical
        let contentWidth = view.bounds.width - toEdge.horizontal * 2
        
        let maxColumn = Int(contentWidth / PreferedItemWidth)
        var row = 0
        var column = 0
        
        for itemView in itemViews {
            itemView.frame = CGRect(x: toEdge.horizontal + (margin.horizontal + PreferedItemWidth) * CGFloat(column), y: maxY + (margin.vertical + PreferedItemHeight) * CGFloat(row), width: PreferedItemWidth, height: PreferedItemHeight)
            column += 1
            if column == maxColumn - 1 {
                column = 0
                row += 1
            }
        }
        if let lastItemView = itemViews.last {
            maxY = lastItemView.frame.maxY
        }
        maxY += toEdge.vertical
        
        self.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: maxY)
    }
}

extension ShareView {
    func addShareItem(title: String, image: UIImage, action: (() -> Void)?) {
        let itemView = ShareItemView()
        itemView.textLabel.text = title
        itemView.imageView.image = image
        itemView.didTapAction = action
        
        addSubview(itemView)
        itemViews.append(itemView)
    }
}


