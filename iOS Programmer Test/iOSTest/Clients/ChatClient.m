//
//  ChatClient.m
//  iOSTest
//
//  Created by App Partner on 9/23/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "ChatClient.h"

@interface ChatClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation ChatClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php
 **/

- (void)fetchChatData:(void (^)(NSArray<Message *> *array))completion withError:(void (^)(NSString *error))errorBlock
{
    
    if ([self isInterNetAvailbleForURL:@"http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php" ]){
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php"]];
        [request setHTTPMethod:@"GET"];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            
            
            NSMutableDictionary *dict=[NSJSONSerialization JSONObjectWithData:[requestReply dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
            
            NSLog(@"%@",[dict objectForKey:@"data"]);
            
            NSArray *messageArray = [dict objectForKey:@"data"];
            
            NSMutableArray *arrayOfMessage = [[NSMutableArray alloc] init];
            
            
            for (NSDictionary * dataDict in messageArray) {
                //NSString * messageID = [dataDict objectForKey:@"user_id"];
                NSString * userName = [dataDict objectForKey:@"username"];
                NSString * avatar_url = [dataDict objectForKey:@"avatar_url"];
                NSString * message = [dataDict objectForKey:@"message"];
                
                Message *messageObj = [[Message alloc] initWithTestName:userName withTestMessage:message avatarUrl:avatar_url];
                
                [arrayOfMessage addObject:messageObj];
                
            }
            
            completion(arrayOfMessage);
            
            
        }] resume];

    } else{
    
    }
    
}


-(BOOL) isInterNetAvailbleForURL:(NSString *)strUrl{
    
    Reachability* reach = [Reachability reachabilityWithHostname:strUrl];

    if (reach.reachableOnWWAN){
        return YES;
    } else if (reach.isReachableViaWiFi){
        return YES;
    } else {
        return NO;
    }
   
}




@end
