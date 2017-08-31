//
//  bFirstViewController.m
//  NavTab6in1
//
//  Created by Alfredo Alba on 10/5/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "bFirstViewController.h"

@interface bFirstViewController ()

@end

@implementation bFirstViewController

@synthesize sText;
@synthesize lbText;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lbText.text = sText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
