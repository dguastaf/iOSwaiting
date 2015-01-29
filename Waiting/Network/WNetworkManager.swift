//
//  WNetworkManager.swift
//  Waiting
//
//  Created by Doug Guastaferro on 1/7/15.
//  Copyright (c) 2015 Doug Guastaferro. All rights reserved.
//

import Foundation

class WNetworkManager{

    class func reloadAllColumns(completion: ([WGuest]) -> ()){
        let query = PFQuery(className: WGuest.parseClassName());
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error != nil{
                NSLog("error!")
                completion([])
            }
            else{
                if let guests = objects as? [WGuest]{
                    completion(guests)
                }
            }
        }
    }
    
}