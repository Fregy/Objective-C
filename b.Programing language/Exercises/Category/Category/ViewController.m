//
//  ViewController.m
//  Category
//
//  Created by Alfredo Alba on 9/17/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Colors.h"

@interface ViewController ()

@property (weak,nonatomic)NSArray *arrayColors;

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

- (IBAction)PressColor:(UIButton *)sender {
    
    NSInteger var = arc4random() % 8;
    
    self.arrayColors = [self  colors];
    
    id deep = [self.arrayColors objectAtIndex:var];
    
    if (deep != self.view.backgroundColor) {
        
        self.view.backgroundColor = deep;
        
    } else {
        
        deep = [self.arrayColors objectAtIndex:var+1];
        
        self.view.backgroundColor = deep;
    }
}
@end
