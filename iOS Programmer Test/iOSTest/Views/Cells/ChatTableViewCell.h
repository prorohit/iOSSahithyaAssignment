//
//  ChatTableViewCell.h
//  iOSTest
//
//  Created by App Partner on 9/23/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ChatTableViewCell : UITableViewCell

- (void)setCellData:(Message *)message;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@end
