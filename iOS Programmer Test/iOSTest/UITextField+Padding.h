//
//  UITextField+Padding.h
//  iOSTest
//
//  Created by Rohit.Singh on 22/02/17.
//  Copyright © 2017 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Padding)

-(CGRect)textRectForBounds:(CGRect)bounds;
-(CGRect)editingRectForBounds:(CGRect)bounds;


@end
