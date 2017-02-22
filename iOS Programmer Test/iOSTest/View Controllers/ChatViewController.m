//
//  ChatViewController.m
//  iOSTest
//
//  Created by App Partner on 9/6/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "ChatViewController.h"
#import "MenuViewController.h"
#import "ChatTableViewCell.h"
#import "ChatClient.h"
#import "Utils.h"
@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *chatTable;
@property (nonatomic, strong) ChatClient *client;
@property (nonatomic, strong) NSMutableArray *messages;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation ChatViewController

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Using the following endpoint, fetch chat data
 *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php
 *
 * 3) Parse the chat data using 'Message' model
 *
 **/


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.client = [[ChatClient alloc] init];
    
    self.messages = [[NSMutableArray alloc] init];
    [self configureTable:self.chatTable];
    [self configureNavigationHeader];
    
    
    if ([Utils isInternetAvailbleForURL:@"http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php"]) {
        [self.activityIndicator setHidden:false];
        [self.activityIndicator startAnimating];
        
        [self.client fetchChatData:^(NSArray<Message *> *array) {
            NSLog(@"%@",array);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator setHidden:true];
                [self.activityIndicator stopAnimating];
                self.messages = [array mutableCopy];
                
                [self.chatTable reloadData];
            });
            
        } withError:^(NSString *error) {
            
            [self showAlertController:@"Test app" message:error.localizedLowercaseString];
            
        }];

    }else {
        [self showAlertController:@"Test App" message:@"Internet connection is not available. Connect to the internet and try again"];
        
    }
    
   }

-(void)configureNavigationHeader {
    [self.navigationController setNavigationBarHidden:false];
    //[self.navigationBar setBarTintColor:UIColorFromRGB(0x363636)];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0f/255.0f green:174.0f/255.0f blue:188.0f/255.0f alpha:1.0f]];
    self.navigationItem.title = @"Chat";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";
    self.navigationController.navigationBar.topItem.backBarButtonItem = barButton;
}


- (void)configureTable:(UITableView *)tableView
{
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"ChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChatTableViewCell"];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatTableViewCell *cell = nil;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatTableViewCell" owner:self options:nil];
        cell = (ChatTableViewCell *)[nib objectAtIndex:0];
    }
    
    [cell setCellData:self.messages[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}

-(void)showAlertController:(NSString*) title message:(NSString *)message {
    if ([UIAlertController class]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else{
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}




@end
