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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).row {
        case 0:
            let defaultNotificationFlea = Flea(type: .notification(title: "Hello, welcome to use Flea"))
            defaultNotificationFlea.baseAt(tabBarController!).stay(2).show()
        case 1:
            let notificationFlea = Flea(type: .notification(title: "Hello, welcome to use Flea"))
            notificationFlea.titleColor = UIColor.white
            notificationFlea.style = .normal(FleaPalette.Green)
            
            notificationFlea.baseAt(navigationCotnroller: navigationController!).stay(2).show()
        default:
            break
        }
    }
}
