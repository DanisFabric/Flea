//
//  FleaAlertView.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/1.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit

class FleaAlertView: UIView {
    weak var flea: Flea?
    
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
    
    let contentLine = { () -> UIView in
        let line = UIView()
        line.backgroundColor = FleaPalette.DarkWhite
        
        return line
    }()
    let buttonLine = { () -> UIView in
        let line = UIView()
        line.backgroundColor = FleaPalette.DarkWhite
        
        return line
    }()
    

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
            let button1 = FleaAlertButton(type: .Custom)
            let button2 = FleaAlertButton(type: .Custom)
            button1.titleLabel?.font = UIFont.systemFontOfSize(15)
            button2.titleLabel?.font = UIFont.systemFontOfSize(15)

            button1.setTitle(actionItems[0].title, forState: .Normal)
            button1.setTitleColor(actionItems[0].color, forState: .Normal)
            button2.setTitle(actionItems[1].title, forState: .Normal)
            button2.setTitleColor(actionItems[1].color, forState: .Normal)
            
            contentLine.frame = CGRect(x: 0, y: maxY, width: contentWidth, height: 0.5)
            buttonLine.frame = CGRect(x: contentWidth / 2, y: maxY, width: 0.5, height: 44)
            button1.line.hidden = true
            button2.line.hidden = true
            
            button1.frame = CGRect(x: 0, y: maxY, width: contentWidth/2, height: 44)
            button2.frame = CGRect(x: contentWidth/2, y: maxY, width: contentWidth/2, height: 44)
            maxY += 44
            
            button1.addTarget(self, action: #selector(onTapButton(_:)), forControlEvents: .TouchUpInside)
            button2.addTarget(self, action: #selector(onTapButton(_:)), forControlEvents: .TouchUpInside)
            
            addSubview(button1)
            addSubview(button2)
            addSubview(contentLine)
            addSubview(buttonLine)
            
            buttons.appendContentsOf([button1,button2])
        }else {
            for item in actionItems {
                let button = FleaAlertButton(type: .Custom)
                button.titleLabel?.font = UIFont.systemFontOfSize(15)

                button.setTitle(item.title, forState: .Normal)
                button.setTitleColor(item.color, forState: .Normal)
                button.frame = CGRect(x: 0, y: maxY, width: contentWidth, height: 44)
                maxY += 44
                
                button.addTarget(self, action: #selector(onTapButton(_:)), forControlEvents: .TouchUpInside)
                addSubview(button)
                buttons.append(button)
            }
        }
        
        self.frame = CGRect(x: 0, y: 0, width: contentWidth, height: maxY)
    }
    @objc private func onTapButton(sender: FleaAlertButton) {
        let index = buttons.indexOf(sender)!
        let item = actionItems[index]
            
        item.action?()
        flea?.dismiss()
    }
}

class FleaAlertButton: UIButton {
    
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