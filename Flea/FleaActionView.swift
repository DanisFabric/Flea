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
    weak var flea: Flea?
    
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
    private var buttons = [FleaActionButton]()
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        self.addGestureRecognizer(tap)
        
        for item in actionItems {
            let button = FleaActionButton(type: .Custom)
            
            button.titleLabel?.font = UIFont.systemFontOfSize(15)
            button.setTitle(item.title, forState: .Normal)
            button.setTitleColor(item.color, forState: .Normal)
            button.frame = CGRect(x: 0, y: maxY, width: view.bounds.width, height: 44)
            maxY += 44
            
            print("Add Action")
            button.addTarget(self, action: #selector(onTapAction(_:)), forControlEvents: .TouchUpInside)
            addSubview(button)
            buttons.append(button)
        }
        self.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: maxY)
    }
    func onTap(sender: AnyObject) {
        print("点我")
    }
    func onTapAction(sender: AnyObject) {
        print("点Button")
        
        let button = sender as! FleaActionButton
        let index = buttons.indexOf(button)!
        let item = actionItems[index]
        
        item.action?()
        flea?.dismiss()

    }
}

class FleaActionButton: UIButton {
    
    let line = { () -> UIView in
        let line = UIView()
        line.backgroundColor = FleaPalette.DarkWhite
        
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 10
        line.frame = CGRect(x: margin, y: 0, width: bounds.width - margin * 2, height: 0.5)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        backgroundColor = FleaPalette.DarkWhite
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
