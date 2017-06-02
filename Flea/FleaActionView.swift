//
//  FleaActionView.swift
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


struct FleaActionItem {
    var title = ""
    var color = UIColor.blue
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
    fileprivate var buttons = [FleaActionButton]()
}

extension FleaActionView: FleaContentView {
    func willBeAdded(to flea: Flea) {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        let textMargin: CGFloat = 20
        let textWidth = flea.bounds.width - textMargin * 2
        var maxY: CGFloat = 0
        
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
        maxY += textMargin
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        self.addGestureRecognizer(tap)
        
        for item in actionItems {
            let button = FleaActionButton(type: .custom)
            
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitle(item.title, for: UIControlState())
            button.setTitleColor(item.color, for: UIControlState())
            button.frame = CGRect(x: 0, y: maxY, width: flea.bounds.width, height: 44)
            maxY += 44
            
            print("Add Action")
            button.addTarget(self, action: #selector(onTapAction(_:)), for: .touchUpInside)
            addSubview(button)
            buttons.append(button)
        }
        self.frame = CGRect(x: 0, y: 0, width: flea.bounds.width, height: maxY)
    }
    func onTap(_ sender: AnyObject) {
        print("点我")
    }
    func onTapAction(_ sender: AnyObject) {
        print("点Button")
        
        let button = sender as! FleaActionButton
        let index = buttons.index(of: button)!
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
