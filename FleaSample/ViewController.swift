//
//  ViewController.swift
//  FleaSample
//
//  Created by 廖雷 on 16/6/29.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit
import Flea

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onShow(sender: AnyObject) {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        contentView.backgroundColor = UIColor.blueColor()
        
        let flea = Flea()
        flea.anchor = .Center
        flea.fill(contentView).show()
    }

}

