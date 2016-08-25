//
//  ShareView.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/19.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit
import Flea

class ShareItemView: UIView {
    let imageView = UIImageView()

    var didTapAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        
        layer.cornerRadius = 4
        layer.masksToBounds = true
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRectInset(bounds, bounds.width * 0.2, bounds.height * 0.2)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        backgroundColor = UIColor.lightGrayColor()
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        backgroundColor = UIColor.whiteColor()
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        super.touchesCancelled(touches, withEvent: event)
        
        backgroundColor = UIColor.whiteColor()
    }
}

class ShareView: UIView {
    weak var flea: Flea?
    var preferedColumns = 4
    var itemViews = [ShareItemView]()
    
    let cancelButton = { () -> UIButton in
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor.whiteColor()
        button.tintColor = FleaPalette.DarkGray
        button.setTitle("Cancel", forState: .Normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cancelButton.addTarget(self, action: #selector(onCancel(_:)), forControlEvents: .TouchUpInside)
        addSubview(cancelButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onCancel(sender: UIButton) {
        flea?.dismiss()
    }
}

extension ShareView: FleaContentView {
    func prepareInView(view: UIView) {
        backgroundColor = FleaPalette.DarkWhite
        
        
        let margin = UIOffset(horizontal: 10, vertical: 20)
        let toEdge = UIOffset(horizontal: 20, vertical: 20)
        
        var maxY = toEdge.vertical
        let contentWidth = view.bounds.width - toEdge.horizontal * 2
        
        let itemSize = { () -> CGSize in
            let width = (contentWidth - margin.horizontal * CGFloat(preferedColumns - 1)) / CGFloat(preferedColumns)
            
            return CGSize(width: width, height: width)
        }()
        
        var row = 0
        var column = 0
        
        for itemView in itemViews {
            itemView.frame = CGRect(x: toEdge.horizontal + (margin.horizontal + itemSize.width) * CGFloat(column), y: maxY, width: itemSize.width, height: itemSize.height)
            column += 1
            if column == preferedColumns {
                column = 0
                row += 1
                maxY = itemView.frame.maxY + margin.vertical
            }
        }
        maxY += toEdge.vertical + itemSize.height
        cancelButton.frame = CGRect(x: 0, y: maxY, width: view.bounds.width, height: 44)
        maxY += 44
        
        self.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: maxY)
    }
}

extension ShareView {
    func addShareItem(image: UIImage, action: (() -> Void)?) {
        let itemView = ShareItemView()
        itemView.imageView.image = image
        itemView.didTapAction = action
        
        addSubview(itemView)
        itemViews.append(itemView)
    }
}


