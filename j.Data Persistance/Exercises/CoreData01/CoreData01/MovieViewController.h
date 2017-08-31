//
//  MovieViewController.h
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataClass.h"

@interface MovieViewController : UIViewController

@property (strong, nonatomic) CoreDataClass        *coreD;

@property (strong, nonatomic) IBOutlet UITextField *tfTitle;
@property (strong, nonatomic) IBOutlet UITextField *tfMainC;
@property (strong, nonatomic) IBOutlet UITextField *tfSeasonC;

@property (strong, nonatomic) IBOutlet UISwitch *sAir;

- (IBAction)bAdd:(UIButton *)sender;


@end
