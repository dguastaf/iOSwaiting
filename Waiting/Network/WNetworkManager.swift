//
//  WNetworkManager.swift
//  Waiting
//
//  Created by Doug Guastaferro on 1/7/15.
//  Copyright (c) 2015 Doug Guastaferro. All rights reserved.
//

import Foundation

let TWILIO_URL = "https://api.twilio.com/2010-04-01/"
let ACCOUNT_PATH = "Accounts/"
let SMS_PATH = "Messages.json"
let SMS_PARAM_FROM = "From"
let SMS_PARAM_TO = "To"
let SMS_PARAM_BODY = "Body"

class WNetworkManager{
    
    class func reloadAllColumns(completion: ([WGuest]) -> ()){
        let query = PFQuery(className: WGuest.parseClassName());
        query.whereKey("status", equalTo:GuestStatus.Waiting.rawValue)
        query.orderByAscending("timeAdded")
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
    
    class func sendText(guest: WGuest, completion: ((NSError?) -> ())?){
        if let twilioUrl = NSURL(string: TWILIO_URL){
            var twilioPath = "\(ACCOUNT_PATH)\(TwilioAccountSID)/\(SMS_PATH)"
            var params = ["From":TwilioAccountNumber]
            params["To"] = guest.phoneNumber
            params["Body"] = "Testing -St. Chris Antique Show App"
        
            let manager = AFHTTPRequestOperationManager(baseURL: twilioUrl)
            manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(TwilioAccountSID, password: TwilioAccountSecret)
            manager.POST(twilioPath, parameters: params, success: { (operation, responseData) -> Void in
                println("success!")
                completion?(nil)
            }, failure: { (operation, error) -> Void in
                println("failure")
                completion?(error)
            })
        }
        else{
            completion?(NSError())
        }
        
    }
}