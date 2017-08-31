//
//  AddViewController.h
//  NumberAdder
//
//  Created by Alfredo Alba on 10/5/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController

@property (strong, nonatomic) NSArray* numbersA;
@property (strong, nonatomic) NSMutableArray *arrayNumbers;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
