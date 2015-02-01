//
//  WQueueCell.swift
//  Waiting
//
//  Created by Doug Guastaferro on 1/7/15.
//  Copyright (c) 2015 Doug Guastaferro. All rights reserved.
//

import Foundation
import UIKit

protocol WQueueTableViewCellDelegate: class{
    func actionButtonTapped(guest: WGuest?)
}

class WQueueTableViewCell: UITableViewCell{
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var partySizeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var guest: WGuest?
    weak var delegate:WQueueTableViewCellDelegate?

    @IBAction func rightImageTapped(sender: AnyObject) {
        if let delegate = self.delegate{
            delegate.actionButtonTapped(self.guest)
            self.actionButton.hidden = true
            self.actionImage.hidden = true
            activityIndicator.startAnimating()
        }
    }
    
    func populateWithGuest(guest: WGuest, timeString: String){
        self.guest = guest
        self.nameLabel.text = guest.name;
        self.timeLabel.text = timeString;
        self.partySizeLabel.text = "\(guest.partySize)"
    }
    
}