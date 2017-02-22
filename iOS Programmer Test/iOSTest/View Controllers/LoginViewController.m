//
//  LoginViewController.m
//  iOSTest
//
//  Created by App Partner on 9/6/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "LoginViewController.h"
#import "MenuViewController.h"
#import "Reachability.h"
#import "LoginClient.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController ()
@property (nonatomic, strong) LoginClient *client;

@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) NSString *messageValidation;

@property (assign,nonatomic ) BOOL isLoginSuccess;


@end

@implementation LoginViewController

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Take username and password input from the user using UITextFields
 *
 * 3) Using the following endpoint, make a request to login
 *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php
 *    Parameter One: username
 *    Parameter Two: password
 *
 * 4) A valid username is 'AppPartner'
 *    A valid password is 'qwerty'
 *
 * 5) Calculate how long the API call took in milliseconds
 *
 * 6) If the response is an error display the error in a UIAlertView
 *
 * 7) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertView
 *
 * 8) When login is successful, tapping 'OK' in the UIAlertView should bring you back to the main menu.
 **/


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isLoginSuccess = false;
    
    _client = [[LoginClient alloc] init];
    
    [self.activityIndicator setHidden:YES];
    
    [self configureNavigationHeader];
    
    self.btnLogin.layer.cornerRadius = 20;
    self.textFieldUserName.layer.cornerRadius = 7.0;
    self.textFieldPassword.layer.cornerRadius = 7.0;
    
    self.textFieldUserName.layer.borderColor = [UIColor colorWithRed:94.0/255 green:94.0/255 blue:94.0/255 alpha:1.0].CGColor;
    self.textFieldUserName.layer.borderWidth = 1.0;
    
    
    self.textFieldPassword.layer.borderColor = [UIColor colorWithRed:94.0/255 green:94.0/255 blue:94.0/255 alpha:1.0].CGColor;
    self.textFieldPassword.layer.borderWidth = 1.0;
    
    [self.view bringSubviewToFront:self.btnLogin];
    [self.view bringSubviewToFront:self.textFieldUserName];
    [self.view bringSubviewToFront:self.textFieldPassword];
    
    // Setting up the padding in the textfield
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.textFieldUserName.leftView = paddingView;
    self.textFieldUserName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewPass = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.textFieldPassword.leftView = paddingViewPass;
    self.textFieldPassword.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- Private Methods
-(void)configureNavigationHeader {
    [self.navigationController setNavigationBarHidden:false];
    //[self.navigationBar setBarTintColor:UIColorFromRGB(0x363636)];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:174.0f/255.0f blue:188.0f/255.0f alpha:1.0f]];
    self.navigationItem.title = @"Login";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
    
}


- (IBAction)didPressLoginButton:(id)sender{
    
    if ([self validation] == true) {
        if ([Utils isInternetAvailbleForURL:@"http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php"]) {
            
            [self.activityIndicator setHidden:NO];
            [self.activityIndicator startAnimating];
            
            NSDate *methodStart = [NSDate date];
            
            [_client loginWithUsername:self.textFieldUserName.text password:self.textFieldPassword.text completion:^(NSDictionary *dict) {
                
                
                NSDate *methodFinish = [NSDate date];
                NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
                
                NSString *code = [dict objectForKey:@"code"];
                NSString *message = [dict objectForKey:@"message"];
                
                if ([code isEqualToString:@"Success"]) {
                    // Showing alert on Main Queue
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.activityIndicator stopAnimating];
                        [self.activityIndicator setHidden:YES];
                        
                        _isLoginSuccess = true;
                        [self showAlertController:@"Test App" message:[NSString stringWithFormat:@"%@ AND api response back time %f",message,executionTime]];
                        
                    });
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.activityIndicator stopAnimating];
                        [self.activityIndicator setHidden:YES];
                        
                        _isLoginSuccess = false;
                        [self showAlertController:@"Test App" message:message];
                        
                    });
                    
                    
                }
                
            }];
            
        } else {
            
            [self showAlertController:@"Test App" message:@"Internet connection is not available. Connect to the internet and try again"];
            
        }
        
        
    } else {
        [self showAlertController:@"Test App" message:self.messageValidation];
    }
    
    
    
}


-(BOOL)validation {
    if (self.textFieldUserName.text.length <= 0) {
        self.messageValidation = @"Please enter username";
        return false;
    } else if (self.textFieldPassword.text.length <= 0){
        self.messageValidation = @"Please enter password";
        return false;
    }
    
    return true;
}



-(void)showAlertController:(NSString*) title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (_isLoginSuccess == true) {
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}





@end
