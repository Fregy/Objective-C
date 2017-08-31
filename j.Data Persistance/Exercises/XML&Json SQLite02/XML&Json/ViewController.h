//
//  ViewController.h
//  XML&Json
//
//  Created by Alfredo Alba on 10/19/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "SongClass.h"
#import "SQLiteClass.h"
#import "JSONClass.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, JSONClassDelegate>
{
    sqlite3 *songDB;
}



@property (strong, nonatomic) NSArray                   *songsArray;

@property (strong, nonatomic) NSString                  *databasePath;

@property (strong, nonatomic) SQLiteClass               *sql;
@property (strong, nonatomic) JSONClass                 *json;
@property (strong, nonatomic) SongClass                 *song;

@property (strong, nonatomic) IBOutlet UITableView      *tableView;

@end

