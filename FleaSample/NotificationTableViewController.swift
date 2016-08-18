//
//  NotificationTableViewController.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/16.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit
import Flea

class NotificationTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let defaultNotificationFlea = Flea(type: .Notification(title: "Hello, welcome to use Flea"))
            defaultNotificationFlea.setNotificationAction("Thanks", action: { 
                
            })
            defaultNotificationFlea.baseAt(tabBarController: tabBarController!).stay(2).show()
        case 1:
            let notificationFlea = Flea(type: .Notification(title: "Hello, welcome to use Flea"))
            notificationFlea.titleColor = UIColor.whiteColor()
            notificationFlea.style = .Normal(FleaPalette.Green)
            
            notificationFlea.baseAt(navigationCotnroller: navigationController!).stay(2).show()
        default:
            break
        }
    }
}
