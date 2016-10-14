//
//  Flea.swift
//  FleaSample
//
//  Created by 廖雷 on 16/6/29.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit

public enum Direction {
    case top
    case left
    case bottom
    case right
}

public enum Anchor {
    case edge
    case center
}

public enum FleaStyle {
    case normal(UIColor)
    case blur(UIBlurEffectStyle)
}

public enum FleaBackgroundStyle {
    case dark
    case clear
    case none
}

public enum Type {
    case custom
    case actionSheet(title: String?, subTitle: String?)
    case alert(title: String?, subTitle: String?)
    case notification(title: String?)
}

public protocol FleaContentView {
    func prepareInView(_ view: UIView)
}

open class Flea: UIView {
    open fileprivate(set) var type = Type.custom
    open var direction = Direction.top
    open var anchor = Anchor.edge
    open var style = FleaStyle.normal(UIColor.white)
    open var backgroundStyle = FleaBackgroundStyle.clear
    
    open var offset = UIOffset()
    open var spring = true
    open var cornerRadius: CGFloat = 0
    open var duration = 0.0
    
    var containerView = UIView()
    var contentView: UIView?

    fileprivate var baseView: UIView?
    fileprivate var baseNavigationConroller: UINavigationController?
    fileprivate var baseTabBarController: UITabBarController?
    fileprivate var baseBehindView: UIView?
    
    fileprivate var animationDuration = 0.3
    fileprivate var animationSpringDuration = 0.5
    
    fileprivate var initialOrigin = CGPoint()
    fileprivate var finalOrigin = CGPoint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    public init(type: Type) {
        self.init()
        
        self.type = type
        switch type {
        case .custom:
            break
        case .actionSheet(let title, let subTitle):
            direction = .bottom
            backgroundStyle = .dark
            contentView = FleaActionView()
            (contentView as! FleaActionView).title = title
            (contentView as! FleaActionView).subTitle = subTitle
            (contentView as! FleaActionView).flea = self
        case .alert(let title, let subTitle):
            direction = .top
            backgroundStyle = .dark
            anchor = .center
            cornerRadius = 4
            contentView = FleaAlertView()
            (contentView as! FleaAlertView).title = title
            (contentView as! FleaAlertView).subTitle = subTitle
            (contentView as! FleaAlertView).flea = self
        case .notification(let title):
            direction = .top
            backgroundStyle = .none
            style = .blur(.dark)
            contentView = FleaNotificationView()
            (contentView as! FleaNotificationView).title = title
            (contentView as! FleaNotificationView).flea = self
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        tap.delegate = self
        addGestureRecognizer(tap)
    }
    
    func onTap(_ tap: UITapGestureRecognizer) {
        dismiss()
    }
    
    func prepared() {
        guard let contentView = contentView else {
            return
        }
        backgroundColor = UIColor.clear
        switch style {
        case .normal(let color):
            containerView = UIView()
            containerView.backgroundColor = color
        case .blur(let blurEffectStyle):
            let blurEffect = UIBlurEffect(style: blurEffectStyle)
            containerView = UIVisualEffectView(effect: blurEffect)
        }
        if let contentView = contentView as? FleaContentView {
            contentView.prepareInView(self)
        }
        containerView.frame = contentView.frame
        containerView.addSubview(contentView)
        addSubview(containerView)
        
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        
        // 配置初始位置／配置最终位置
        switch direction {
        case .top:
            initialOrigin = CGPoint(x: (bounds.width - containerView.bounds.width) / 2 + offset.horizontal, y: -containerView.bounds.height)
            if anchor == .edge {
                finalOrigin = CGPoint(x: initialOrigin.x, y: offset.vertical)
            }
        case .left:
            initialOrigin = CGPoint(x: -containerView.bounds.width, y: (bounds.height - containerView.bounds.height) / 2 + offset.vertical)
            if anchor == .edge {
                finalOrigin = CGPoint(x: offset.horizontal, y: initialOrigin.y)
            }
        case .bottom:
            initialOrigin = CGPoint(x: (bounds.width - containerView.bounds.width) / 2 + offset.horizontal, y: bounds.height)
            if anchor == .edge {
                finalOrigin = CGPoint(x: initialOrigin.x, y: bounds.height - containerView.bounds.height + offset.vertical)
            }
        case .right:
            initialOrigin = CGPoint(x: bounds.width, y: (bounds.height - containerView.bounds.height) / 2 + offset.vertical)
            if anchor == .edge {
                finalOrigin = CGPoint(x: bounds.width - containerView.bounds.width + offset.horizontal, y: initialOrigin.y)
            }
        }
        if anchor == .center {
            finalOrigin = CGPoint(x: bounds.midX - containerView.bounds.width/2 + offset.horizontal, y: bounds.midY - containerView.bounds.height/2 + offset.vertical)
        }
        
        containerView.frame.origin = initialOrigin
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if backgroundStyle == .none && !containerView.frame.contains(point) {
            return nil
        }else {
            return super.hitTest(point, with: event)
        }
    }
}

extension Flea {
    public func show() {
        if let baseNavigationConroller = baseNavigationConroller {
            show(inNavigationController: baseNavigationConroller)
            
            return
        }
        if let baseTabBarController = baseTabBarController {
            show(inTabBarController: baseTabBarController)
            
            return
        }
        if let baseView = baseView {
            show(inView: baseView)
            
            return
        }
        let window = UIApplication.shared.keyWindow!
        show(inView: window)
    }
    fileprivate func show(inNavigationController navigationController: UINavigationController) {
        if navigationController.navigationBar.isTranslucent && anchor == .edge && direction == .top {
            baseBehindView = navigationController.navigationBar
            offset = UIOffset(horizontal: offset.horizontal, vertical: offset.vertical + navigationController.navigationBar.frame.height)
            if !UIApplication.shared.isStatusBarHidden {
                offset.vertical += UIApplication.shared.statusBarFrame.height
            }
        }
        show(inView: navigationController.view)
    }
    fileprivate func show(inTabBarController tabBarController: UITabBarController) {
        if tabBarController.tabBar.isTranslucent && anchor == .edge && direction == .bottom {
            baseBehindView = tabBarController.tabBar
            offset = UIOffset(horizontal: offset.horizontal, vertical: offset.vertical - tabBarController.tabBar.frame.height)
        }
        show(inView: tabBarController.view)
    }
    
    fileprivate func show(inView view: UIView) {
        self.frame = view.bounds
        view.addSubview(self)
        if let baseBehindView = baseBehindView {
            view.insertSubview(self, belowSubview: baseBehindView)
        }else {
            view.addSubview(self)
        }

        prepared()
        
        let animations = {
            self.containerView.frame.origin = self.finalOrigin
            if self.backgroundStyle == .dark {
                self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            }
        }
        if spring {
            UIView.animate(withDuration: animationSpringDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {
                
                animations()
                
                }, completion: nil)
        }else {
            UIView.animate(withDuration: animationDuration, animations: { 
                animations()
            })
        }
        if duration > 0 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * duration)) / Double(NSEC_PER_SEC), execute: {
                self.dismiss()
            })
        }
    }
    
    
    public func dismiss() {
        UIView.animate(withDuration: animationDuration, animations: { 
            
            self.containerView.frame.origin = self.initialOrigin
            self.backgroundColor = UIColor.clear
            
            }, completion: { (_) in
                self.removeFromSuperview()
        }) 
    }
    public func stay(_ duration: Double) -> Flea {
        self.duration = duration
        
        return self
    }
}

extension Flea {
    public func baseAt(_ view: UIView, behind: UIView? = nil) -> Self {
        baseView = view
        baseBehindView = behind
        
        return self
    }
    public func baseAt(navigationCotnroller navigationController: UINavigationController) -> Self {
        baseNavigationConroller = navigationController
        
        return self
    }
    public func baseAt(_ tabBarController: UITabBarController) -> Self {
        direction = .bottom
        baseTabBarController = tabBarController
        
        return self
    }
}

extension Flea {
    public func fill(_ view: UIView) -> Self {
        contentView = view
        contentView!.frame = CGRect(origin: CGPoint(), size: contentView!.frame.size)
        
        return self
    }
}

// MARK: - [Alert][Action][Notification] Configuration
extension Flea {
    public func addAction(_ title: String, color: UIColor = FleaPalette.Blue, action: (() -> Void)?) {
        let item = FleaActionItem(title: title, color: color, action: action)
        switch type {
        case .actionSheet:
            let actionView = contentView as! FleaActionView
            actionView.actionItems.append(item)
        case .alert:
            let alertView = contentView as! FleaAlertView
            alertView.actionItems.append(item)
        default:
            break
        }
    }
    public func setNotificationAction(_ title: String, color: UIColor = UIColor.white, action: (() -> Void)?) {
        let item = FleaActionItem(title: title, color: color, action: action)
        let notificationView = contentView as! FleaNotificationView
        notificationView.actionItem = item
        
    }
    public var titleColor: UIColor? {
        get {
            switch type {
            case .actionSheet:
                return (contentView as! FleaActionView).titleLabel.textColor
            case .alert:
                return (contentView as! FleaAlertView).titleLabel.textColor
            case .notification:
                return (contentView as! FleaNotificationView).titleLabel.textColor
            default:
                return nil
            }
        }
        set {
            switch type {
            case .actionSheet:
                (contentView as! FleaActionView).titleLabel.textColor = newValue
            case .alert:
                (contentView as! FleaAlertView).titleLabel.textColor = newValue
            case .notification:
                (contentView as! FleaNotificationView).titleLabel.textColor = newValue
                (contentView as! FleaNotificationView).closeButton.tintColor = newValue // CloseButton use the same color of TitleLabel
            default:
                break
            }
        }
    }
    public var subTitleColor: UIColor? {
        get {
            switch type {
            case .actionSheet:
                return (contentView as! FleaActionView).subTitleLabel.textColor
            case .alert:
                return (contentView as! FleaAlertView).subTitleLabel.textColor
            default:
                return nil
            }
        }
        set {
            switch type {
            case .actionSheet:
                (contentView as! FleaActionView).subTitleLabel.textColor = newValue
            case .alert:
                (contentView as! FleaAlertView).subTitleLabel.textColor = newValue
            default:
                break
            }
        }
    }

}

extension Flea: UIGestureRecognizerDelegate {
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard backgroundStyle != .none else {
            return false
        }
        let location = gestureRecognizer.location(in: self)
        
        if containerView.frame.contains(location) {
            return false
        }
        return true
    }
}
