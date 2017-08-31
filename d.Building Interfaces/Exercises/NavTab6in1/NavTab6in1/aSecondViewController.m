//
//  aSecondViewController.m
//  NavTab6in1
//
//  Created by Alfredo Alba on 10/5/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "aSecondViewController.h"

@interface aSecondViewController ()

@end

@implementation aSecondViewController

@synthesize myImage;
@synthesize showImage;

- (void)viewDidLoad {
    [super viewDidLoad];

    showImage.image = [UIImage imageNamed:myImage];
    
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
