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
+ (NSString *)parseClassName;
@property (nonatomic, strong) NSString *name;

@end
