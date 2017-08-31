//
//  ViewController.m
//  Classes
//
//  Created by Alfredo Alba on 9/16/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "XYPoint.h"

@interface ViewController ()
    @property(weak, nonatomic)NSString * strX;
    @property(weak, nonatomic)NSString * strY;
    @property(strong, nonatomic)XYPoint * Point;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PressGC:(UIButton *)sender {
    
    self.Point = [[XYPoint alloc] init];
    
    if (![self.TextX.text  isEqualToString:@""] && ![self.TextY.text isEqualToString:@""]) {
        
        self.strX = self.TextX.text;
        self.strY = self.TextY.text;
        
        
        CGFloat strFloatX = (CGFloat)[self.strX floatValue];
        CGFloat strFloatY = (CGFloat)[self.strY floatValue];
        
        [self.Point SetPointX:strFloatX AndPointY:strFloatY];
        
        NSString * Texto = [@"The X Coordinate is: " stringByAppendingFormat:@" %.2f %@ %.2f", [self.Point GetPointX], @"\nThe Y Coordinate is: ", [self.Point GetPointY]];
    
        [self.LabelM setText:Texto];
        [UIView animateWithDuration:10 animations:^{_LabelM.center = CGPointMake([self.Point GetPointX],[self.Point GetPointY]);}];
        
     } else {
        
        self.LabelM.text = @"Please put some values first!!";
        
     }
    
}
@end
