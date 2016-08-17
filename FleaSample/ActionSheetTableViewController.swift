//
//  ActionSheetTableViewController.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/16.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit
import Flea

class ActionSheetTableViewController: UITableViewController {

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
            let defaultActionSheet = Flea(type: .ActionSheet(title: "Do you love Flea", subTitle: "If you love it, you can star Flea on GitHub"))
            defaultActionSheet.addAction("Sorry, I don't love it", action: { 
                
            })
            defaultActionSheet.addAction("I love it!", action: { 
                
            })
            defaultActionSheet.show()
            break
        case 1:
            let actionFlea = Flea(type: .ActionSheet(title: "Do you love Flea", subTitle: "If you love it, you can star Flea on GitHub"))
            actionFlea.titleColor = FleaPalette.DarkGray
            actionFlea.subTitleColor = FleaPalette.Green
            actionFlea.addAction("Sorry, I don't love it", color: FleaPalette.Blue, action: { 
                
            })
            actionFlea.addAction("I love it", color: FleaPalette.Red, action: { 
                
            })
            actionFlea.show()
            
        case 2:
            break
        default:
            break
        }
    }

}
