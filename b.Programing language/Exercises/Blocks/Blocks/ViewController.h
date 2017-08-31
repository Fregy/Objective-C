//
//  ViewController.h
//  Blocks
//
//  Created by Alfredo Alba on 9/17/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *Label10;
@property (strong, nonatomic) IBOutlet UITextField *Text10;
- (IBAction)Button10:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UILabel *LabelMap;
@property (strong, nonatomic) IBOutlet UITextField *TextMap;
- (IBAction)ButtonAdd:(UIButton *)sender;
- (IBAction)ButtonClean:(UIButton *)sender;
- (IBAction)ButtonMap:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITextView *TextViewDic;

@end

