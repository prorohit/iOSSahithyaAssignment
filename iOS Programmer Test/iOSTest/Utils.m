//
//  Utils.m
//  iOSTest
//
//  Created by Rohit.Singh on 22/02/17.
//  Copyright © 2017 AppPartner. All rights reserved.
//

#import "Utils.h"
#import "Reachability.h"
@implementation Utils

+ (BOOL)isInternetAvailbleForURL:(NSString *)strUrl{
    
    Reachability* reach = [Reachability reachabilityWithHostname:strUrl];
    
    if (reach.isReachableViaWiFi){
        return YES;
    } else {
        return NO;
    }
    
}


@end
