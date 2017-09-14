//
//  AlertTableViewController.swift
//  FleaSample
//
//  Created by 廖雷 on 16/8/16.
//  Copyright © 2016年 廖雷. All rights reserved.
//

import UIKit
import Flea

class AlertTableViewController: UITableViewController {

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
            let defaultAlertFlea = Flea(type: .alert(title: "Do you love Flea", subTitle: "If you love Flea, you may start it on GitHub"))
            defaultAlertFlea.addAction("No, thanks", action: { 
                
            })
            defaultAlertFlea.addAction("I love Flea", action: { 
                
            })
            defaultAlertFlea.show()
        case 1:
            let alert = Flea(type: .alert(title: nil, subTitle: nil))
            alert.forbidSystemAlertStyle = true
            alert.addAction("No, thanks", action: { 
                
            })
            alert.addAction("I love Flea", action: { 
                
            })
//            alert.addAction("What is Flea", color: FleaPalette.Red, action: { 
//                
//            })
            alert.contentWidthScale = 0.2
            alert.show()
        default:
            break
        }
    }
}
