//
//  AddPlayerViewController.h
//  CoreData02
//
//  Created by Alfredo Alba on 10/29/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataClass.h"
#import "Team.h"

@interface AddPlayerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) CoreDataClass             *core;
@property (strong, nonatomic) NSArray                   *myTeams;
@property (nonatomic)         NSInteger                 number;

@property (strong, nonatomic) IBOutlet UITextField      *tfName;
@property (strong, nonatomic) IBOutlet UITextField      *tfAge;

- (IBAction)bSave:(UIButton *)sender;

@end
