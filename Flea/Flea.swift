//
//  Flea.swift
//  FleaSample
//
//  Created by 廖雷 on 16/6/29.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit

public enum Direction {
    case Top
    case Left
    case Bottom
    case Right
}

public enum Anchor {
    case Edge
    case Center
}

public enum FleaStyle {
    case Normal(UIColor)
    case Blur(UIBlurEffectStyle)
}

public enum FleaBackgroundStyle {
    case Dark
    case Clear
    case None
}

public enum Type {
    case Custom
    case ActionSheet(title: String?, subTitle: String?)
    case Alert(title: String?, subTitle: String?)
    case Notification(title: String?)
}

protocol FleaContentView {
    func prepareInView(view: UIView)
}

public class Flea: UIView {
    public private(set) var type = Type.Custom
    public var direction = Direction.Top
    public var anchor = Anchor.Edge
    public var style = FleaStyle.Normal(UIColor.whiteColor())
    public var backgroundStyle = FleaBackgroundStyle.Clear
    
    public var offset = UIOffset()
    public var spring = true
    public var cornerRadius: CGFloat = 0
    public var duration = 0.0
    
    var containerView = UIView()
    var contentView: UIView?

    private var baseView: UIView?
    private var baseNavigationConroller: UINavigationController?
    private var baseTabBarController: UITabBarController?
    private var baseBehindView: UIView?
    
    private var animationDuration = 0.3
    private var animationSpringDuration = 0.5
    
    private var initialOrigin = CGPoint()
    private var finalOrigin = CGPoint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    public init(type: Type) {
        self.init()
        
        self.type = type
        switch type {
        case .Custom:
            break
        case .ActionSheet(let title, let subTitle):
            direction = .Bottom
            backgroundStyle = .Dark
            contentView = FleaActionView()
            (contentView as! FleaActionView).title = title
            (contentView as! FleaActionView).subTitle = subTitle
        case .Alert(let title, let subTitle):
            direction = .Top
            backgroundStyle = .Dark
            anchor = .Center
            cornerRadius = 4
            contentView = FleaAlertView()
            (contentView as! FleaAlertView).title = title
            (contentView as! FleaAlertView).subTitle = subTitle
        case .Notification(let title):
            direction = .Top
            backgroundStyle = .None
            style = .Blur(.Dark)
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
    
    func onTap(tap: UITapGestureRecognizer) {
        dismiss()
    }
    
    func prepared() {
        guard let contentView = contentView else {
            return
        }
        backgroundColor = UIColor.clearColor()
        switch style {
        case .Normal(let color):
            containerView = UIView()
            containerView.backgroundColor = color
        case .Blur(let blurEffectStyle):
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
        case .Top:
            initialOrigin = CGPoint(x: (bounds.width - containerView.bounds.width) / 2 + offset.horizontal, y: -containerView.bounds.height)
            if anchor == .Edge {
                finalOrigin = CGPoint(x: initialOrigin.x, y: offset.vertical)
            }
        case .Left:
            initialOrigin = CGPoint(x: -containerView.bounds.width, y: (bounds.height - containerView.bounds.height) / 2 + offset.vertical)
            if anchor == .Edge {
                finalOrigin = CGPoint(x: offset.horizontal, y: initialOrigin.y)
            }
        case .Bottom:
            initialOrigin = CGPoint(x: (bounds.width - containerView.bounds.width) / 2 + offset.horizontal, y: bounds.height)
            if anchor == .Edge {
                finalOrigin = CGPoint(x: initialOrigin.x, y: bounds.height - containerView.bounds.height + offset.vertical)
            }
        case .Right:
            initialOrigin = CGPoint(x: bounds.width, y: (bounds.height - containerView.bounds.height) / 2 + offset.vertical)
            if anchor == .Edge {
                finalOrigin = CGPoint(x: bounds.width - containerView.bounds.width + offset.horizontal, y: initialOrigin.y)
            }
        }
        if anchor == .Center {
            finalOrigin = CGPoint(x: bounds.midX - containerView.bounds.width/2 + offset.horizontal, y: bounds.midY - containerView.bounds.height/2 + offset.vertical)
        }
        
        containerView.frame.origin = initialOrigin
    }
    
    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if backgroundStyle == .None && !CGRectContainsPoint(containerView.frame, point) {
            return nil
        }else {
            return super.hitTest(point, withEvent: event)
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
        let window = UIApplication.sharedApplication().keyWindow!
        show(inView: window)
    }
    private func show(inNavigationController navigationController: UINavigationController) {
        if navigationController.navigationBar.translucent && anchor == .Edge && direction == .Top {
            baseBehindView = navigationController.navigationBar
            offset = UIOffset(horizontal: offset.horizontal, vertical: offset.vertical + navigationController.navigationBar.frame.height)
            if !UIApplication.sharedApplication().statusBarHidden {
                offset.vertical += UIApplication.sharedApplication().statusBarFrame.height
            }
        }
        show(inView: navigationController.view)
    }
    private func show(inTabBarController tabBarController: UITabBarController) {
        if tabBarController.tabBar.translucent && anchor == .Edge && direction == .Bottom {
            baseBehindView = tabBarController.tabBar
            offset = UIOffset(horizontal: offset.horizontal, vertical: offset.vertical - tabBarController.tabBar.frame.height)
        }
        show(inView: tabBarController.view)
    }
    
    private func show(inView view: UIView) {
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
            if self.backgroundStyle == .Dark {
                self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
            }
        }
        if spring {
            UIView.animateWithDuration(animationSpringDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .AllowUserInteraction, animations: {
                
                animations()
                
                }, completion: nil)
        }else {
            UIView.animateWithDuration(animationDuration, animations: { 
                animations()
            })
        }
        if duration > 0 {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * duration)), dispatch_get_main_queue(), {
                self.dismiss()
            })
        }
    }
    
    
    public func dismiss() {
        UIView.animateWithDuration(animationDuration, animations: { 
            
            self.containerView.frame.origin = self.initialOrigin
            self.backgroundColor = UIColor.clearColor()
            
            }) { (_) in
                self.removeFromSuperview()
        }
    }
    public func stay(duration: Double) -> Flea {
        self.duration = duration
        
        return self
    }
}

extension Flea {
    public func baseAt(view view: UIView, behind: UIView? = nil) -> Self {
        baseView = view
        baseBehindView = behind
        
        return self
    }
    public func baseAt(navigationCotnroller navigationController: UINavigationController) -> Self {
        baseNavigationConroller = navigationController
        
        return self
    }
    public func baseAt(tabBarController tabBarController: UITabBarController) -> Self {
        direction = .Bottom
        baseTabBarController = tabBarController
        
        return self
    }
}

extension Flea {
    public func fill(view: UIView) -> Self {
        contentView = view
        contentView!.frame = CGRect(origin: CGPoint(), size: contentView!.frame.size)
        
        return self
    }
}

// MARK: - [Alert][Action][Notification] Configuration
extension Flea {
    public func addAction(title: String, color: UIColor = FleaPalette.Blue, action: (() -> Void)?) {
        let item = FleaActionItem(title: title, color: color, action: action)
        switch type {
        case .ActionSheet:
            let actionView = contentView as! FleaActionView
            actionView.actionItems.append(item)
        case .Alert:
            let alertView = contentView as! FleaAlertView
            alertView.actionItems.append(item)
        default:
            break
        }
    }
    public func setNotificationAction(title: String, color: UIColor = UIColor.whiteColor(), action: (() -> Void)?) {
        let item = FleaActionItem(title: title, color: color, action: action)
        let notificationView = contentView as! FleaNotificationView
        notificationView.actionItem = item
        
    }
    public var titleColor: UIColor? {
        get {
            switch type {
            case .ActionSheet:
                return (contentView as! FleaActionView).titleLabel.textColor
            case .Alert:
                return (contentView as! FleaAlertView).titleLabel.textColor
            case .Notification:
                return (contentView as! FleaNotificationView).titleLabel.textColor
            default:
                return nil
            }
        }
        set {
            switch type {
            case .ActionSheet:
                (contentView as! FleaActionView).titleLabel.textColor = newValue
            case .Alert:
                (contentView as! FleaAlertView).titleLabel.textColor = newValue
            case .Notification:
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
            case .ActionSheet:
                return (contentView as! FleaActionView).subTitleLabel.textColor
            case .Alert:
                return (contentView as! FleaAlertView).subTitleLabel.textColor
            default:
                return nil
            }
        }
        set {
            switch type {
            case .ActionSheet:
                (contentView as! FleaActionView).subTitleLabel.textColor = newValue
            case .Alert:
                (contentView as! FleaAlertView).subTitleLabel.textColor = newValue
            default:
                break
            }
        }
    }

}

extension Flea: UIGestureRecognizerDelegate {
    public override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard backgroundStyle != .None else {
            return false
        }
        let location = gestureRecognizer.locationInView(self)
        
        if CGRectContainsPoint(containerView.frame, location) {
            return false
        }
        return true
    }
}