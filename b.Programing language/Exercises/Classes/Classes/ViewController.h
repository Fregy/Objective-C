//
//  ViewController.h
//  Classes
//
//  Created by Alfredo Alba on 9/16/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *LabelM;
@property (strong, nonatomic) IBOutlet UITextField *TextX;
@property (strong, nonatomic) IBOutlet UITextField *TextY;
- (IBAction)PressGC:(UIButton *)sender;

@end

