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
    var dateFormatter = NSDateFormatter();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: self.QueueTableViewCellNib, bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(nib, forCellReuseIdentifier: "QueueTableViewCell")
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .ShortStyle
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guests.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(QueueTalbeViewCellReuseID) as WQueueTableViewCell
        let guest = guests[indexPath.row]
        let timeString = dateFormatter.stringFromDate(guest.timeAdded)
        cell.populateWithGuest(guest, timeString: timeString)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        if let navController = storyboard.instantiateViewControllerWithIdentifier("AddGuestNavigationController") as? UINavigationController{
            navController.modalPresentationStyle = .FormSheet
            if let addController = navController.viewControllers.first as? WAddGuestViewController{
                weak var weakSelf = self
                self.presentViewController(navController, animated: true, completion: { () -> Void in

                })
                    addController.editingGuest = weakSelf?.guests[indexPath.row]
            }
        }
        
        
    }
    
}