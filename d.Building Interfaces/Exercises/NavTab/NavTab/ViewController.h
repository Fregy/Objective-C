//
//  ViewController.h
//  NavTab
//
//  Created by Alfredo Alba on 10/4/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray* ninjaArray;
@property(strong,nonatomic)IBOutlet UITableView *tableView;

@end

