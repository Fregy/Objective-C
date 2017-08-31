//
//  ViewController.h
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "XMLClass.h"
#import "NewsClass.h"
#import "SQLiteClass.h"
#import "GCNetworkReachability.h"


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate>
{
    sqlite3                                             *newsDB;
}

// Variables
@property (nonatomic)         BOOL                      bandC;
@property (nonatomic)         BOOL                      bandSection;
@property (strong, nonatomic) NSMutableArray            *myXMLArray;
@property (strong, nonatomic) NSString                  *databasePath;
// Special Variables

@property (strong, nonatomic) NewsClass                 *news;
@property (strong, nonatomic) XMLClass                  *xml;
@property (strong, nonatomic) SQLiteClass               *sql;
@property (strong, nonatomic) GCNetworkReachability     *reachability;
// Controlls
- (IBAction)segSection:(UISegmentedControl *)sender;
// Table View
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//

@end

