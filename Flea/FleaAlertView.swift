//
//  FleaAlertView.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/1.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class FleaAlertView: UIView {
    weak var flea: Flea?
    var widthScale: CGFloat = 0.8
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
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        
        return label
    }()
    var subTitleLabel = { () -> UILabel in
        let label = UILabel()
        label.textColor = FleaPalette.LightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        
        return label
    }()
    
    fileprivate var buttons = [FleaAlertButton]()
    
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
    func willBeAdded(to flea: Flea) {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        let contentWidth = flea.bounds.width * widthScale
        let textMargin: CGFloat = 20
        let textWidth = contentWidth - textMargin * 2
        var maxY: CGFloat = 0
        let titleShow = titleLabel.text != nil || subTitleLabel.text != nil
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: textWidth, height: 0)
        titleLabel.sizeToFit()
        
        subTitleLabel.frame = CGRect(x: 0, y: 0, width: textWidth, height: 0)
        subTitleLabel.sizeToFit()
        
        if titleLabel.text?.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            titleLabel.frame = CGRect(x: textMargin, y: textMargin, width: textWidth, height: titleLabel.frame.height)
            maxY = titleLabel.frame.maxY
        }
        if subTitleLabel.text?.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            subTitleLabel.frame = CGRect(x: textMargin, y: maxY + textMargin, width: textWidth, height: subTitleLabel.frame.height)
            maxY = subTitleLabel.frame.maxY
        }
        if titleShow {
            maxY += textMargin
        }
        
        if actionItems.count == 2 && !flea.forbidSystemAlertStyle {
            let button1 = FleaAlertButton(type: .custom)
            let button2 = FleaAlertButton(type: .custom)
            button1.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button2.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            
            button1.setTitle(actionItems[0].title, for: UIControlState())
            button1.setTitleColor(actionItems[0].color, for: UIControlState())
            button2.setTitle(actionItems[1].title, for: UIControlState())
            button2.setTitleColor(actionItems[1].color, for: UIControlState())
            
            contentLine.frame = CGRect(x: 0, y: maxY, width: contentWidth, height: 0.5)
            buttonLine.frame = CGRect(x: contentWidth / 2, y: maxY, width: 0.5, height: 44)
            button1.line.isHidden = true
            button2.line.isHidden = true
            
            button1.frame = CGRect(x: 0, y: maxY, width: contentWidth/2, height: 44)
            button2.frame = CGRect(x: contentWidth/2, y: maxY, width: contentWidth/2, height: 44)
            maxY += 44
            
            button1.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
            button2.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
            
            addSubview(button1)
            addSubview(button2)
            addSubview(contentLine)
            addSubview(buttonLine)
            
            buttons.append(contentsOf: [button1,button2])
        }else {
            for item in actionItems {
                let button = FleaAlertButton(type: .custom)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                
                button.setTitle(item.title, for: UIControlState())
                button.setTitleColor(item.color, for: UIControlState())
                button.frame = CGRect(x: 0, y: maxY, width: contentWidth, height: 44)
                maxY += 44
                
                button.addTarget(self, action: #selector(onTapButton(_:)), for: .touchUpInside)
                addSubview(button)
                buttons.append(button)
            }
            if !titleShow {
                buttons.first?.line.removeFromSuperview()
            }
        }
        
        self.frame = CGRect(x: 0, y: 0, width: contentWidth, height: maxY)   
    }
    @objc fileprivate func onTapButton(_ sender: FleaAlertButton) {
        let index = buttons.index(of: sender)!
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        backgroundColor = FleaPalette.DarkWhite
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        backgroundColor = UIColor.white
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        backgroundColor = UIColor.white
    }

}
