//
//  UITextField+Padding.m
//  iOSTest
//
//  Created by Rohit.Singh on 22/02/17.
//  Copyright © 2017 AppPartner. All rights reserved.
//

#import "UITextField+Padding.h"

@implementation UITextField (Padding)

-(CGRect)textRectForBounds:(CGRect)bounds {
    
    
    
    return CGRectMake(bounds.origin.x+20 , bounds.origin.y ,
                      bounds.size.width , bounds.size.height-2 );
}
-(CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end

