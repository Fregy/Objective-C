//
//  ViewController.h
//  Collections
//
//  Created by Alfredo Alba on 9/16/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
//Non-Repeated
@property (strong, nonatomic) IBOutlet UILabel *LabelNR;
@property (strong, nonatomic) IBOutlet UITextField *TextNR;
- (IBAction)PressNR:(UIButton *)sender;
//Ocurrences
@property (strong, nonatomic) IBOutlet UILabel *LabelO;
@property (strong, nonatomic) IBOutlet UITextField *TextO;
- (IBAction)PressO:(UIButton *)sender;
//Reverses
@property (strong, nonatomic) IBOutlet UILabel *LabelR;
@property (strong, nonatomic) IBOutlet UITextField *TextR;
- (IBAction)PressR:(UIButton *)sender;
//Dictionary
@property (strong, nonatomic) IBOutlet UILabel *LabelD;
- (IBAction)PressD:(UIButton *)sender;

@end

