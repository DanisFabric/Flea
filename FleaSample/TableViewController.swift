//
//  TableViewController.swift
//  FleaSample
//
//  Created by 廖雷 on 16/7/7.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit
import Flea

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        contentView.backgroundColor = UIColor.clearColor()
//        
//        let flea = Flea()
//        flea.style = .Blur(.Dark)
//        flea.backgroundStyle = .None
//        flea.anchor = .Edge
//        
//        flea.baseAt(navigationCotnroller: navigationController!)
//        flea.fill(contentView).show()
//        let flea = Flea(frame: CGRect())
        let flea = Flea(type: .ActionSheet(title: "廖雷dfgdflg dflg kdlfg dlf; gkldg dlf; ldf; kldfg dfl; klg ", subTitle: "这是一个牛逼的开源库"))
        flea.addAction("item1") { 
            
        }
        flea.addAction("item2") { 
            
        }
        flea.show()
        
        let notiFlea = NotificationFlea(title: "Danis is Handsome")
        notiFlea.style = .Blur(.Dark)
        notiFlea.baseAt(navigationCotnroller: navigationController!).show()
    }
}
