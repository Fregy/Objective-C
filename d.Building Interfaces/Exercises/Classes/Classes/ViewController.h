//
//  ViewController.h
//  Classes
//
//  Created by Alfredo Alba on 9/23/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// TextField
@property (strong, nonatomic) IBOutlet UITextField *tfName;
@property (strong, nonatomic) IBOutlet UITextField *tfNShares;
@property (strong, nonatomic) IBOutlet UITextField *tfPurches;
@property (strong, nonatomic) IBOutlet UITextField *tfCurrent;

// Buttons
- (IBAction)bAdd:(UIButton *)sender;
- (IBAction)bConsult:(UIButton *)sender;
- (IBAction)bStock:(UIButton *)sender;
- (IBAction)bOneStock:(UIButton *)sender;


// TextView
@property (strong, nonatomic) IBOutlet UITextView *tfInfo;

@end

