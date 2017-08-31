//
//  EditPlayerViewController.m
//  CoreData02
//
//  Created by Alfredo Alba on 10/29/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "EditPlayerViewController.h"

@interface EditPlayerViewController ()

@end

@implementation EditPlayerViewController

@synthesize myRow;
@synthesize myAge;
@synthesize myName;
@synthesize myTeams;

- (void)viewDidLoad {
    [super viewDidLoad];

    _p              =   [[Player alloc] init];
    _tfAge.text     =   myAge;
    _tfName.text    =   myName;
    _number         =   0;
    
    [_myPickerView selectedRowInComponent:myRow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bChange:(UIButton *)sender {
    
    _p           =   [[Player alloc] init];
    
    _p.name      =   _tfName.text;
    _p.age       =   _tfAge.text;
    _p.teamid    =   [NSString stringWithFormat:@"%ld", (long)_number];
    
    [self.delegate didFinishGetDataPlayers:_p myTeam:myRow];
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Message"
                                  message:@"Pre Saved"
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             _tfName.text      =   @"";
                             _tfAge.text      =   @"";
                             
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _number = row;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [myTeams count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return ((Team *)myTeams[row]).name;
}

@end
