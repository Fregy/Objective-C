//
//  ViewController+Colors.m
//  Category
//
//  Created by Alfredo Alba on 9/17/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController+Colors.h"

@implementation ViewController (Colors)

-(NSArray *)colors {
    
NSArray *colors;
    
    if (!colors) {
        colors = @[[UIColor blackColor],[UIColor yellowColor],[UIColor redColor],[UIColor blueColor],[UIColor whiteColor], [UIColor purpleColor], [UIColor orangeColor], [UIColor grayColor], [UIColor greenColor]];

    }
    return colors;
}

@end
