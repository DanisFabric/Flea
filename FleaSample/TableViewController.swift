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
        switch indexPath.row {
        case 0:
            let flea = Flea(type: .ActionSheet(title: "廖雷dfgdflg dflg kdlfg dlf; gkldg dlf; ldf; kldfg dfl; klg ", subTitle: "sdfsdfsdf "))
            flea.titleColor = UIColor.greenColor()
            flea.subTitleColor = UIColor.blueColor()
            
            flea.addAction("item1") {
                
            }
            flea.addAction("item2") {
                
            }
            flea.show()
        case 1:
            let alert = Flea(type: .Alert(title: "廖雷sdfsdf", subTitle: "是一个大帅哥"))
            alert.addAction("Item1", action: { 
                
            })
            alert.addAction("Item2", action: { 
                
            })
            alert.show()
        case 2:
            let notification = Flea(type: .Notification(title: "么么哒"))
            notification.duration = 2
            notification.addAction("Action", action: { 
                
            })
            notification.baseAt(navigationCotnroller: navigationController!).show()
        default:
            break
        }
        
    }
}
