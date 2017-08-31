//
//  ViewController.h
//  Protocols
//
//  Created by Alfredo Alba on 9/17/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *LabelAdd;
@property (strong, nonatomic) IBOutlet UILabel *LabelSubs;
@property (strong, nonatomic) IBOutlet UILabel *LabelMul;
@property (strong, nonatomic) IBOutlet UILabel *LabelDiv;
@property (strong, nonatomic) IBOutlet UITextField *TextA;
@property (strong, nonatomic) IBOutlet UITextField *TextB;

- (IBAction)ButtonOperations:(UIButton *)sender;

@end
