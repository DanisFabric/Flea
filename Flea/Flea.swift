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
    
    public var contentView: UIView!
    public var contentSize: CGSize!
    
    private var containerView = UIView()

    private var baseView: UIView?
    private var baseNavigationConroller: UINavigationController?
    
    public func show() {
        
    }
    
    public func dismiss() {
        
    }
    public func contentView() {
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
    public func fillContentView(view: UIView, size: CGSize) -> Self {
        contentView = view
        contentSize = size
        
        return self
    }
}