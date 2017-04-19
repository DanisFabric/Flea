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
    case edge(Direction)
    case center(Direction?)
    
    var direction: Direction? {
        switch self {
        case .edge(let direction):
            return direction
        case .center(let direction):
            return direction
        }
    }
    var isEdge: Bool {
        switch self {
        case .edge:
            return true
        default:
            return false
        }
    }
    var isCenter: Bool {
        switch self {
        case .edge:
            return false
        case .center:
            return true
        }
    }
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
    public var willDismissHandler: (() -> Void)?
    public var didDismissHandler: (() -> Void)?
    open fileprivate(set) var type = Type.custom
    open var anchor = Anchor.center(nil)
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
    
    fileprivate var initialPosition = CGPoint()
    fileprivate var finalPosition = CGPoint()
    fileprivate var initialTransform = CGAffineTransform.identity
    fileprivate var initialAlpha: CGFloat = 1
    
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
            anchor = .edge(.top)
            backgroundStyle = .dark
            contentView = FleaActionView()
            (contentView as! FleaActionView).title = title
            (contentView as! FleaActionView).subTitle = subTitle
            (contentView as! FleaActionView).flea = self
        case .alert(let title, let subTitle):
            anchor = .center(nil)
            backgroundStyle = .dark
            cornerRadius = 4
            contentView = FleaAlertView()
            (contentView as! FleaAlertView).title = title
            (contentView as! FleaAlertView).subTitle = subTitle
            (contentView as! FleaAlertView).flea = self
        case .notification(let title):
            anchor = .edge(.top)
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
        func layoutInitialPosition(direction: Direction) {
            switch direction {
            case .top:
                initialPosition = CGPoint(x: (bounds.width - containerView.bounds.width) / 2 + offset.horizontal, y: -containerView.bounds.height)
            case .left:
                initialPosition = CGPoint(x: -containerView.bounds.width, y: (bounds.height - containerView.bounds.height) / 2 + offset.vertical)
            case .bottom:
                initialPosition = CGPoint(x: (bounds.width - containerView.bounds.width) / 2 + offset.horizontal, y: bounds.height)
            case .right:
                initialPosition = CGPoint(x: bounds.width, y: (bounds.height - containerView.bounds.height) / 2 + offset.vertical)
            }
        }
        switch anchor {
        case .edge(let direction):
            layoutInitialPosition(direction: direction)
            
            switch direction {
            case .top:
                finalPosition = CGPoint(x: initialPosition.x, y: offset.vertical)

            case .left:
                finalPosition = CGPoint(x: offset.horizontal, y: initialPosition.y)

            case .bottom:
                finalPosition = CGPoint(x: initialPosition.x, y: bounds.height - containerView.bounds.height + offset.vertical)

            case .right:
                finalPosition = CGPoint(x: bounds.width - containerView.bounds.width + offset.horizontal, y: initialPosition.y)

            }
        case .center(let direction):
            finalPosition = CGPoint(x: bounds.midX - containerView.bounds.width/2 + offset.horizontal, y: bounds.midY - containerView.bounds.height/2 + offset.vertical)
            
            if let direction = direction {
                layoutInitialPosition(direction: direction)
            } else {
                initialPosition = finalPosition
                initialTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                initialAlpha = 0
            }
        }
        
        
//        switch direction {
//        case .top:
//            initialPosition = CGPoint(x: (bounds.width - containerView.bounds.width) / 2 + offset.horizontal, y: -containerView.bounds.height)
//            if anchor == .edge {
//                finalPosition = CGPoint(x: initialPosition.x, y: offset.vertical)
//            }
//        case .left:
//            initialPosition = CGPoint(x: -containerView.bounds.width, y: (bounds.height - containerView.bounds.height) / 2 + offset.vertical)
//            if anchor == .edge {
//                finalPosition = CGPoint(x: offset.horizontal, y: initialPosition.y)
//            }
//        case .bottom:
//            initialPosition = CGPoint(x: (bounds.width - containerView.bounds.width) / 2 + offset.horizontal, y: bounds.height)
//            if anchor == .edge {
//                finalPosition = CGPoint(x: initialPosition.x, y: bounds.height - containerView.bounds.height + offset.vertical)
//            }
//        case .right:
//            initialPosition = CGPoint(x: bounds.width, y: (bounds.height - containerView.bounds.height) / 2 + offset.vertical)
//            if anchor == .edge {
//                finalPosition = CGPoint(x: bounds.width - containerView.bounds.width + offset.horizontal, y: initialPosition.y)
//            }
//        }
//        if anchor == .center {
//            finalPosition = CGPoint(x: bounds.midX - containerView.bounds.width/2 + offset.horizontal, y: bounds.midY - containerView.bounds.height/2 + offset.vertical)
//        }
        containerView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        containerView.frame.origin = initialPosition
        containerView.alpha = initialAlpha
        containerView.transform = initialTransform
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
        switch anchor {
        case .edge(let direction):
            if direction == .top {
                baseBehindView = navigationController.navigationBar
                offset = UIOffset(horizontal: offset.horizontal, vertical: offset.vertical + navigationController.navigationBar.frame.height)
                if !UIApplication.shared.isStatusBarHidden {
                    offset.vertical += UIApplication.shared.statusBarFrame.height
                }
            }
        default:
            break
        }
        show(inView: navigationController.view)
    }
    fileprivate func show(inTabBarController tabBarController: UITabBarController) {
        switch anchor {
        case .edge(let direction):
            if direction == .bottom {
                baseBehindView = tabBarController.tabBar
                offset = UIOffset(horizontal: offset.horizontal, vertical: offset.vertical - tabBarController.tabBar.frame.height)
            }
        default:
            break
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
        
        func animations() {
            if anchor.isCenter && anchor.direction == nil {
                
            } else {
                containerView.frame.origin = self.finalPosition
                
            }
            containerView.transform = CGAffineTransform.identity
            containerView.alpha = 1
            
            if backgroundStyle == .dark {
                backgroundColor = UIColor.black.withAlphaComponent(0.6)
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
    
    
    public func dismiss(withCompletion completion: (() -> Void)? = nil) {
        willDismissHandler?()
        UIView.animate(withDuration: animationDuration, animations: { 
            
            self.containerView.frame.origin = self.initialPosition
            self.containerView.alpha = self.initialAlpha
            self.containerView.transform = self.initialTransform
            self.backgroundColor = UIColor.clear
            
            }, completion: { (_) in
                self.didDismissHandler?()
                self.removeFromSuperview()
        }) 
    }
    public func stay(_ duration: Double) -> Flea {
        self.duration = duration
        
        return self
    }
}

extension Flea {
    public func baseAt(_ any: Any?, behind: UIView? = nil) -> Self {
        switch any {
        case let view as UIView:
            baseView = view
            baseBehindView = behind
        case let navigationController as UINavigationController :
            baseNavigationConroller = navigationController
        case let tabBarController as UITabBarController:
            baseTabBarController = tabBarController
        default:
            break
        }
        
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
