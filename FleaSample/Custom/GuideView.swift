//
//  GuideView.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/16.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit

class GuideView: UIView {
    
    var pages = [UIImageView]()
    var pageControl = UIPageControl()
    
    let scrollView = { () -> UIScrollView in
        let scrollView = UIScrollView()
        scrollView.pagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        addSubview(pageControl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: bounds.width * CGFloat(pages.count), height: bounds.height)
        pageControl.frame = CGRect(x: 0, y: bounds.height * 0.7, width: bounds.width, height: bounds.height * 0.2)
        
        var index: CGFloat = 0
        for imageView in pages {
            imageView.frame = CGRect(x: index * bounds.width, y: 0, width: bounds.width, height: bounds.height)
            
            index += 1
        }
    }
}

extension GuideView {
    func addPage(image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        
        pages.append(imageView)
        scrollView.addSubview(imageView)
        
        pageControl.numberOfPages = pages.count
    }
}
