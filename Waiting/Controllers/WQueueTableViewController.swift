//
//  WQueueTableViewController.swift
//  Waiting
//
//  Created by Doug Guastaferro on 1/7/15.
//  Copyright (c) 2015 Doug Guastaferro. All rights reserved.
//

import Foundation
import UIKit

class WQueueTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate{
    let QueueTableViewCellNib = "WQueueTableViewCell"
    let QueueTalbeViewCellReuseID = "QueueTableViewCell"
    var guests:[WGuest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: self.QueueTableViewCellNib, bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(nib, forCellReuseIdentifier: "QueueTableViewCell")
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return guests.count
        return 50
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(QueueTalbeViewCellReuseID) as WQueueTableViewCell
        
        return cell
    }
    
}