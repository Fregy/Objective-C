//
//  AddViewController.m
//  NavTab
//
//  Created by Alfredo Alba on 10/4/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "AddViewController.h"
#import "ViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize tfText;
@synthesize ninjaArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    ViewController *destViewController = segue.destinationViewController;
    destViewController.ninjaArray = ninjaArray;
}

- (IBAction)bAdd:(UIButton *)sender {
    
    if (ninjaArray == nil) {
        ninjaArray = [[NSMutableArray alloc] init];
    }
    
    [ninjaArray addObject:tfText.text];
    
    tfText.text = @"";
    
}
@end
