//
//  ViewController.m
//  Training001
//
//  Created by Alfredo Alba on 9/10/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
-(NSArray *)colors {
    if (!_colors) _colors = @[[UIColor blackColor],[UIColor yellowColor],[UIColor redColor],[UIColor blueColor],[UIColor whiteColor], [UIColor purpleColor], [UIColor orangeColor], [UIColor grayColor]];
    return _colors;
}

- (IBAction)ibButtonPressesDown:(id)sender {
    int var = rand() % 6;
    if ([self.textField.text isEqualToString:@""]) {
        self.labelField.text=@"There is no Text to show!!";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    else {
        NSString *str = [NSString stringWithFormat: @"%@, %@", self.textField.text, @"Good Afternoon!!"];
        self.labelField.text=str;
        
        self.view.backgroundColor = [self.colors objectAtIndex:var];    }
}

@end
