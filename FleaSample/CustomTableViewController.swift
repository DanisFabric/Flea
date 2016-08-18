//
//  CustomTableViewController.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/16.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit
import Flea

class CustomTableViewController: UITableViewController {

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
            let guideView = GuideView(frame: CGRect(x: 0, y: 0, width: 280, height: 360))
            guideView.addPage(UIImage(named: "guide-0")!)
            guideView.addPage(UIImage(named: "guide-1")!)
            
            let flea = Flea(type: .Custom)
            flea.anchor = .Center
            flea.direction = .Top
            flea.backgroundStyle = .Dark
            flea.cornerRadius = 4
            
            flea.fill(guideView).show()
        case 1:
            let loginView = LoginView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 240))
            
            let flea = Flea(type: .Custom)
            flea.direction = .Top
            flea.backgroundStyle = .Dark
            
            flea.fill(loginView).show()
        default:
            break
        }
    }
}
