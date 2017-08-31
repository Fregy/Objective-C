//
//  AddPlayerViewController.m
//  CoreData02
//
//  Created by Alfredo Alba on 10/29/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "AddPlayerViewController.h"

@interface AddPlayerViewController ()

@end

@implementation AddPlayerViewController

@synthesize myTeams;
@synthesize number;

- (void)viewDidLoad {
    [super viewDidLoad];

    _core                =   [[CoreDataClass alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bSave:(UIButton *)sender {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         _tfName.text, @"name",
                         _tfAge.text, @"age", nil];
    
    if([_core insertDataPlayer:@"Player" allData:dic idNumber:number]) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Message"
                                      message:@"Data Saved"
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
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 1;
}

// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return ((Team *)myTeams[number]).name;
}
@end
