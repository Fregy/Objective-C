//
//  BookViewController.h
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataClass.h"

@interface BookViewController : UIViewController

@property (strong, nonatomic) CoreDataClass        *coreD;

@property (strong, nonatomic) IBOutlet UITextField *tfTitle;
@property (strong, nonatomic) IBOutlet UITextField *tfAuthor;
@property (strong, nonatomic) IBOutlet UITextField *tfPageC;
@property (strong, nonatomic) IBOutlet UITextField *tfTeeageO;


- (IBAction)bAdd:(UIButton *)sender;


@end
