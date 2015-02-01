//
//  WQueueTableViewController.swift
//  Waiting
//
//  Created by Doug Guastaferro on 1/7/15.
//  Copyright (c) 2015 Doug Guastaferro. All rights reserved.
//

import Foundation
import UIKit

class WQueueTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, WQueueTableViewCellDelegate{
    let QueueTableViewCellNib = "WQueueTableViewCell"
    let QueueTalbeViewCellReuseID = "QueueTableViewCell"
    var guests:[WGuest] = []
    var dateFormatter = NSDateFormatter();
    var headerTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: self.QueueTableViewCellNib, bundle: NSBundle(forClass: self.dynamicType))
        self.tableView.registerNib(nib, forCellReuseIdentifier: "QueueTableViewCell")
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .ShortStyle
        self.tableView.separatorStyle = .None
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guests.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(QueueTalbeViewCellReuseID) as WQueueTableViewCell
        let guest = guests[indexPath.row]
        let timeString = dateFormatter.stringFromDate(guest.timeAdded)
        cell.populateWithGuest(guest, timeString: timeString)
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        if let navController = storyboard.instantiateViewControllerWithIdentifier("AddGuestNavigationController") as? UINavigationController{
            navController.modalPresentationStyle = .FormSheet
            if let addController = navController.viewControllers.first as? WAddGuestViewController{
                weak var weakSelf = self
                self.presentViewController(navController, animated: true, completion: nil)
                addController.editingGuest = weakSelf?.guests[indexPath.row]
            }
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let nib = UINib(nibName: "WQueueTableViewHeader", bundle: NSBundle(forClass: self.dynamicType))
        
        if let headerView = nib.instantiateWithOwner(self, options: nil).first as? WQueueTableViewHeader{
            headerView.titleLabel.text = self.headerTitle
            return headerView
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func actionButtonTapped(sentGuest: WGuest?) {
        if let guest = sentGuest{
            switch(guest.status){
            case .Waiting:
                WNetworkManager.sendText(guest, completion: nil)
                guest.status = .Paged
                guest.saveInBackgroundWithBlock(nil)
            default:
                println("todo")
            }
        }
    }
    
}