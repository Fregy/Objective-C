//
//  BookViewController.m
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController ()

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _coreD      =   [[CoreDataClass alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bAdd:(UIButton *)sender {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         _tfTitle.text,@"title",
                         _tfAuthor.text,@"author",
                         _tfPageC.text,@"page",
                         _tfTeeageO.text,@"percentTGO" ,nil];
    
    if([_coreD insertDataBook:@"Book" allData:dic]) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Message"
                                      message:@"Data Saved"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 _tfTitle.text      =   @"";
                                 _tfAuthor.text     =   @"";
                                 _tfPageC.text      =   @"";
                                 _tfTeeageO.text    =   @"";
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
