//
//  WHomeViewController.swift
//  Waiting
//
//  Created by Doug Guastaferro on 1/7/15.
//  Copyright (c) 2015 Doug Guastaferro. All rights reserved.
//

import UIKit
import Foundation

class WHomeViewController: UIViewController {
    
    private let DefaultRows = 4
    private var queueViewControllers:[WQueueTableViewController] = []
    private var timer:NSTimer?
    private var isReloading = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addColumns()
        
        self.reloadAllColumns()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(5 , target: self, selector: "reloadTimerExpired:", userInfo: nil, repeats: true)
        
    }
    
    deinit{
        self.timer?.invalidate()
        self.timer = nil;
        
    }

    private func addColumns(){
        let width = self.view.bounds.width / CGFloat(DefaultRows)
        
        for (var i = 0; i < self.DefaultRows; i++){

            let queueViewController = WQueueTableViewController()
            setWidthForColumn(queueViewController, index: i)
            self.view.addSubview(queueViewController.view)
            queueViewController.didMoveToParentViewController(self)
            self.queueViewControllers.append(queueViewController)
        }
    }
    
    private func setWidthForColumn(queueViewController: WQueueTableViewController, index: Int){
        let width = self.view.bounds.width / CGFloat(DefaultRows)
        let frame = CGRectMake(width * CGFloat(index), 0.0, width, self.view.bounds.height)
        queueViewController.view.frame = frame
    }
    
    func reloadTimerExpired(timer: NSTimer){
        self.reloadAllColumns()
    }
    
    private func reloadAllColumns(){
        if (self.isReloading){
            return
        }
        self.isReloading = true
        WNetworkManager.reloadAllColumns { (guests) in
            var guestLists = [[WGuest]](count:self.DefaultRows, repeatedValue:[])
            
            var index = 0
            
            for guest in guests{
                switch (guest.partySize){
                case 1...4:
                    index = 0
                case 5...6:
                    index = 1;
                case 7...8:
                    index = 2;
                default:
                    index = 3;
                }
                guestLists[index].append(guest)
            }
            
            for (index, guestList) in enumerate(guestLists){
                let queueViewController = self.queueViewControllers[index]
                queueViewController.guests = guestList;
                queueViewController.tableView.reloadData();
            }
            self.isReloading = false;
        }
    }
    
    
}