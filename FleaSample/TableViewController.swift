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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        contentView.backgroundColor = UIColor.clearColor()
        
        let flea = Flea()
        flea.style = .Blur(.Dark)
        flea.backgroundStyle = .Dark
        flea.anchor = .Edge
        flea.fill(contentView).show()

    }
}
