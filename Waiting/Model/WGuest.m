//
//  WGuest.m
//  Waiting
//
//  Created by Doug Guastaferro on 1/5/15.
//  Copyright (c) 2015 Doug Guastaferro. All rights reserved.
//

#import "WGuest.h"
#import <Parse/PFObject+Subclass.h>

@implementation WGuest
@dynamic name;
@dynamic phoneNumber;
@dynamic partySize;
@dynamic timeAdded;
@dynamic timePaged;
@dynamic timeInactive;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Guest";
}

@end
