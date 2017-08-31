//
//  AddViewController.h
//  Collections
//
//  Created by Alfredo Alba on 10/2/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *tfFirst;
@property (strong, nonatomic) IBOutlet UITextField *tfMiddle;
@property (strong, nonatomic) IBOutlet UITextField *tfLast;
@property (strong, nonatomic) IBOutlet UILabel *lbAge;
@property (strong, nonatomic) IBOutlet UILabel *lbInfo;
@property (strong, nonatomic) NSString* age;

@property (strong, nonatomic) NSMutableArray* personArray;

- (IBAction)stIncDec:(UIStepper *)sender;
- (IBAction)bSave:(UIButton *)sender;
- (IBAction)bClear:(UIButton *)sender;

@end
