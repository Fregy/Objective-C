//
//  SecondViewController.h
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONClass.h"
#import "ArrayClass.h"

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, JSONClassDelegate>

@property (strong, nonatomic) JSONClass                     *json;
@property (strong, nonatomic) ArrayClass                    *array;

@property (strong, nonatomic) NSArray                       *myJSonArray;

@property (strong, nonatomic) IBOutlet UISegmentedControl   *segSection;
@property (strong, nonatomic) IBOutlet UITableView          *tableView;

- (IBAction)segSection:(UISegmentedControl *)sender;

@end
