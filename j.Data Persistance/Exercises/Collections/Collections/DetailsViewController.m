//
//  DetailsViewController.m
//  Collections
//
//  Created by Alfredo Alba on 10/3/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController


@synthesize lFirst;
@synthesize lMiddle;
@synthesize lLast;
@synthesize lAge;
@synthesize fir;
@synthesize mid;
@synthesize las;
@synthesize ag;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lFirst.text = fir;
    lMiddle.text = mid;
    lLast.text = las;
    lAge.text = ag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
