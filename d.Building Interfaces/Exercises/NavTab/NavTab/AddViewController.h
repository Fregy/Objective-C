//
//  AddViewController.h
//  NavTab
//
//  Created by Alfredo Alba on 10/4/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *tfText;
@property (strong, nonatomic) NSMutableArray* ninjaArray;
- (IBAction)bAdd:(UIButton *)sender;

@end
