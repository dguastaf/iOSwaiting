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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addColumns()
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
}