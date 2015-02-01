//
//  WGuest.h
//  Waiting
//
//  Created by Doug Guastaferro on 1/5/15.
//  Copyright (c) 2015 Doug Guastaferro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface WGuest : PFObject<PFSubclassing>

typedef NS_ENUM(NSInteger, GuestStatus) {
    kWaiting,
    kPaged,
    kInactive
};

+ (NSString *)parseClassName;
+ (WGuest *)createGuest;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic) NSInteger partySize;
@property (nonatomic, strong) NSDate *timeAdded;
@property (nonatomic, strong) NSDate *timePaged;
@property (nonatomic, strong) NSDate *timeInactive;
@property (nonatomic) GuestStatus status;


@end
