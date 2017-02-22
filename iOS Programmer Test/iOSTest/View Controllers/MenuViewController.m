//
//  MenuViewController.m
//  iOSTest
//
//  Created by App Partner on 9/6/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "ChatViewController.h"
#import "LoginViewController.h"
#import "MenuViewController.h"
#import "AnimationViewController.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *animationButton;
@end

@implementation MenuViewController

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 *
 * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
 *
 * 2) Use Autolayout to make sure all UI works for each resolution
 *
 * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
 *    provided code if necessary. It is ok to add any classes. This is your project now!
 *
 * 4) Read the additional instructions comments throughout the codebase, they will guide you.
 *
 * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
 *
 * Thank you and Good luck. - App Partner
 * =========================================================================================
 */


- (void)viewDidLoad
{
    // TODO: Make the UI look like it does in the mock-up
    
    // For configuring Navigation bar as per the designs
    [self configureNavigationHeader];
    
    [super viewDidLoad];
    
   }



-(void)configureNavigationHeader {
    [self.navigationController setNavigationBarHidden:false];
    //[self.navigationBar setBarTintColor:UIColorFromRGB(0x363636)];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:174.0f/255.0f blue:188.0f/255.0f alpha:1.0f]];
    self.navigationItem.title = @"Coding Tasks";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];

}

-(void)viewDidAppear:(BOOL)animated{
  
    [self.view bringSubviewToFront:self.chatButton];
    [self.view bringSubviewToFront:self.loginButton];
    [self.view bringSubviewToFront:self.animationButton];

    
    self.chatButton.layer.cornerRadius = 20;
    self.loginButton.layer.cornerRadius = 20;
    self.animationButton.layer.cornerRadius = 20;

    
}


- (IBAction)didPressChatButton:(id)sender
{
    ChatViewController *chatViewController = [[ChatViewController alloc] init];
    [self.navigationController pushViewController:chatViewController animated:YES];
}

- (IBAction)didPressLoginButton:(id)sender
{
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (IBAction)didPressAnimationButton:(id)sender
{
    AnimationViewController *animationViewController = [[AnimationViewController alloc] init];
    [self.navigationController pushViewController:animationViewController animated:YES];
}

@end
