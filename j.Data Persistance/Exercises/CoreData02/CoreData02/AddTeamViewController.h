//
//  AddTeamViewController.h
//  CoreData02
//
//  Created by Alfredo Alba on 10/29/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataClass.h"

@interface AddTeamViewController : UIViewController

@property (strong, nonatomic) CoreDataClass             *core;

@property (nonatomic)         NSInteger                 number;

@property (strong, nonatomic) IBOutlet UITextField      *tfName;

@property (strong, nonatomic) IBOutlet UITextField      *tfColor;
- (IBAction)bSave:(UIButton *)sender;


@end
