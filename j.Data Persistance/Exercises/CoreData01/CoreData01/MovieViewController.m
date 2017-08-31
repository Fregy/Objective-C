//
//  MovieViewController.m
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "MovieViewController.h"

@interface MovieViewController ()

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _coreD      =   [[CoreDataClass alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)bAdd:(UIButton *)sender {
    
    NSString *band = @"NO";
    
    if ([_sAir isOn]) {
        band = @"YES";
    }
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                        _tfTitle.text,@"title",
                        _tfMainC.text,@"main_character",
                        _tfSeasonC.text,@"season",
                        band,@"airing" ,nil];
    
    if([_coreD insertDataMovie:@"Movie" allData:dic]) {
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
                                 _tfMainC.text      =   @"";
                                 _tfSeasonC.text    =   @"";
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
