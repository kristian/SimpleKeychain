//
//  ViewController.m
//  Simple Keychain
//
//  Created by Kraljic, Kristian on 15.10.12.
//  Copyright (c) 2012 Kristian Kraljic (dikrypt.com, ksquared.de). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    _keychain = [SimpleKeychain defaultKeychain];
    if([_keychain count]<=0)
        [_keychain setObject:@"Default Value" forKey:@"Test"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_keychain count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *key = [[_keychain keys] objectAtIndex:indexPath.row],*value = (NSString*)[_keychain objectForKey:key];
    cell.textLabel.text = key;
    cell.detailTextLabel.text = value;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_keychain removeObjectForKey:[[_keychain keys] objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)actionAdd:(id)sender {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Add / Set Value" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [[alertView textFieldAtIndex:0] setPlaceholder:@"Key"];
    [[alertView textFieldAtIndex:1] setPlaceholder:@"Value"];
    [[alertView textFieldAtIndex:1] setSecureTextEntry:NO];
    [alertView show];
}

- (IBAction)actionRefresh:(id)sender {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex) {
        case 1:
            [_keychain setObject:[alertView textFieldAtIndex:1].text forKey:[alertView textFieldAtIndex:0].text];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

@end
