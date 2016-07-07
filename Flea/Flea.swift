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

public class Flea: UIView {
    public var direction = Direction.Top
    public var anchor = Anchor.Edge
    public var style = FleaStyle.Normal(UIColor.whiteColor())
    public var backgroundStyle = FleaBackgroundStyle.Clear
    
    public var offset = UIOffset()
    public var spring = false
    public var cornerRadius: CGFloat = 0
    public var duration = 0.0
    
    private var containerView = UIView()
    private var contentView: UIView?

    private var baseView: UIView?
    private var baseNavigationConroller: UINavigationController?
    
    private var initialOrigin = CGPoint()
    private var finalOrigin = CGPoint()
    private var animationDuration = 0.3
}

extension Flea {
    public func show() {
        if let baseNavigationConroller = baseNavigationConroller {
            show(inNavigationController: baseNavigationConroller)
            
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
            offset = UIOffset(horizontal: offset.horizontal, vertical: offset.vertical + navigationController.navigationBar.frame.height)
        }
        show(inView: navigationController.view)
    }
    
    private func show(inView view: UIView) {
        prepare()
    }
    
    func prepare() {
        guard let contentView = contentView else {
            return
        }
        switch backgroundStyle {
        case .Clear:
            backgroundColor = UIColor.clearColor()
        case .Dark:
            backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        case .None:
            backgroundColor = UIColor.clearColor()
        }
        switch style {
        case .Normal(let color):
            containerView = UIView()
            containerView.backgroundColor = color
        case .Blur(let blurEffectStyle):
            let blurEffect = UIBlurEffect(style: blurEffectStyle)
            containerView = UIVisualEffectView(effect: blurEffect)
        }
        
        containerView.frame = contentView.frame
        containerView.addSubview(contentView)
        
        // 配置初始位置／配置最终位置
        switch direction {
        case .Top:
            initialOrigin = CGPoint()
        case .Left:
            break
        case .Bottom:
            break
        case .Right:
            break
        }
        
        switch anchor {
        case .Edge:
            break
        case .Center:
            break
        }
        
        
    }
    
    public func dismiss() {
        
    }
    
}

extension Flea {
    public func baseAt(view view: UIView) -> Self {
        baseView = view
        
        return self
    }
    public func baseAt(navigationCotnroller navigationController: UINavigationController) -> Self {
        baseNavigationConroller = navigationController
        
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