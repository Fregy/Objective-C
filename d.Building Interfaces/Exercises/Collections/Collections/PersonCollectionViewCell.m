//
//  PersonCollectionViewCell.m
//  Collections
//
//  Created by Alfredo Alba on 10/2/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "PersonCollectionViewCell.h"

@implementation PersonCollectionViewCell

@synthesize lFirst;
@synthesize lMiddle;
@synthesize lLast;
@synthesize lAge;

- (IBAction)sIncDec:(UIStepper *)sender {
    
    double newValue = [sender value];
    
    lAge.text = [NSString stringWithFormat:@"%i", (int)newValue];
}

@end
