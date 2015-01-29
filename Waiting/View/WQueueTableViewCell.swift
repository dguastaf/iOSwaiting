//
//  WQueueCell.swift
//  Waiting
//
//  Created by Doug Guastaferro on 1/7/15.
//  Copyright (c) 2015 Doug Guastaferro. All rights reserved.
//

import Foundation
import UIKit

class WQueueTableViewCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var partySizeLabel: UILabel!

    @IBAction func rightImageTapped(sender: AnyObject) {
        println("text tapped")
    }
    
    func populateWithGuest(guest: WGuest, timeString: String){
        self.nameLabel.text = guest.name;
        self.timeLabel.text = timeString;
        self.partySizeLabel.text = "\(guest.partySize)"
    }
    
}