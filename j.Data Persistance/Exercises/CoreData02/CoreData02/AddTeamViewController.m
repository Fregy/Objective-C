//
//  AddTeamViewController.m
//  CoreData02
//
//  Created by Alfredo Alba on 10/29/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "AddTeamViewController.h"

@interface AddTeamViewController ()

@end

@implementation AddTeamViewController

@synthesize number;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _core               =   [[CoreDataClass alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bSave:(UIButton *)sender {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         _tfName.text, @"name",
                         _tfColor.text, @"color", nil];
    
    if([_core insertDataTeam:@"Team" allData:dic idNumber:number]) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Message"
                                      message:@"Data Saved"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 _tfName .text      =   @"";
                                 _tfColor.text      =   @"";
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
