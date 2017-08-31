//
//  ViewController.h
//  Alertview&ActionSheet
//
//  Created by Alfredo Alba on 9/23/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate>

- (IBAction)alertButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;

@end

