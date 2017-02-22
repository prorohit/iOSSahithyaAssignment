//
//  ChatTableViewCell.m
//  iOSTest
//
//  Created by App Partner on 9/23/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "ChatTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ChatTableViewCell ()

@property (nonatomic, strong) Message *message;


@end

@implementation ChatTableViewCell

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Setup cell to match mockup
 * 
 * 2) Include user's avatar image
 **/


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // For Making imageview of avatar image of the user as circular
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.contentMode = UIViewContentModeScaleAspectFit;
    self.userImage.clipsToBounds = YES;

}

- (void)setCellData:(Message *)message
{
    [self.header setText:message.username];
    [self.body setText:message.text];
    
    [self.userImage sd_setImageWithURL:message.avatarURL
                 placeholderImage:[UIImage imageNamed:@"ic_logo.png"]];
    
    
}

@end
