//
//  AnimationViewController.m
//  iOSTest
//
//  Created by App Partner on 12/13/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "AnimationViewController.h"
#import "MenuViewController.h"

@interface AnimationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewForSpin;

@property (weak, nonatomic) IBOutlet UIButton *btnSpin;




@end

@implementation AnimationViewController

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Logo should spin when the user hits the spin button
 *
 * 3) User should be able to drag the logo around the screen with his/her fingers
 *
 * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
 *    section in Swfit to show off your skills. Anything your heart desires!
 *
 **/

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureNavigationHeader];
    self.btnSpin.layer.cornerRadius = 20;
    
    
    // Adding Pan gesture to move the image on the screen.
    self.imageViewForSpin.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panner = [[UIPanGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(panWasRecognized:)];
    [self.imageViewForSpin addGestureRecognizer:panner];
    
    
}



#pragma mark -- Private Methods
-(void)configureNavigationHeader {
    [self.navigationController setNavigationBarHidden:false];
    //[self.navigationBar setBarTintColor:UIColorFromRGB(0x363636)];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:174.0f/255.0f blue:188.0f/255.0f alpha:1.0f]];
    self.navigationItem.title = @"Animation";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;

}

-(void)spinAnimation {
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 0.5; // Speed - Less the value more will be speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [self.imageViewForSpin.layer addAnimation:rotation forKey:@"Spin"];
}



- (void)panWasRecognized:(UIPanGestureRecognizer *)panner {
    UIView *draggedView = panner.view;
    CGPoint offset = [panner translationInView:draggedView.superview];
    CGPoint center = draggedView.center;
    draggedView.center = CGPointMake(center.x + offset.x, center.y + offset.y);
    
    // Reset translation to zero so on the next `panWasRecognized:` message, the
    // translation will just be the additional movement of the touch since now.
    [panner setTranslation:CGPointZero inView:draggedView.superview];
}


#pragma mark -- IBAction For Spin Button

- (IBAction)didPressSpinButton:(id)sender
{
    [self spinAnimation];
}
@end
