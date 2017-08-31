//
//  AddViewController.h
//  Collections
//
//  Created by Alfredo Alba on 10/2/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface AddViewController : UIViewController
{
    sqlite3 *PersonDB;
}

@property (strong, nonatomic) IBOutlet UITextField *tfFirst;
@property (strong, nonatomic) IBOutlet UITextField *tfMiddle;
@property (strong, nonatomic) IBOutlet UITextField *tfLast;
@property (strong, nonatomic) IBOutlet UILabel *lbAge;
@property (strong, nonatomic) IBOutlet UILabel *lbInfo;
@property (strong, nonatomic) NSString* age;
@property (strong, nonatomic) NSString* filePath;

@property (strong, nonatomic) NSMutableArray* personArray;

- (IBAction)stIncDec:(UIStepper *)sender;
- (IBAction)bSave:(UIButton *)sender;
- (IBAction)bClear:(UIButton *)sender;

@end
