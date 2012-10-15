//
//  ViewController.h
//  Simple Keychain
//
//  Created by Kraljic, Kristian on 15.10.12.
//  Copyright (c) 2012 Kristian Kraljic (dikrypt.com, ksquared.de). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleKeychain.h"

@interface ViewController : UITableViewController<UIAlertViewDelegate>

@property SimpleKeychain* keychain;

- (IBAction)actionAdd:(id)sender;
- (IBAction)actionRefresh:(id)sender;

@end
