//
//  ViewController.h
//  XML&Json
//
//  Created by Alfredo Alba on 10/19/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    sqlite3 *songDB;
}
// Variables
@property (strong, nonatomic) NSMutableArray    *songArray;
@property (strong, nonatomic) NSMutableArray    *artistArray;
@property (strong, nonatomic) NSString* databasePath;

// Table View
@property (strong, nonatomic) IBOutlet UITableView *tableView;

// Json
- (void)dataRetreived:(NSData*) dataResponse;
// Create Table
- (void) CreateTableDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSDictionary *)nameA;
// Get Number of Rows
- (NSInteger)NumberOfTable:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT;
// Delete Row
- (BOOL) DeleteElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA delete:(NSString *)element;
// Insert Element
- (void) InsertElementsDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSDictionary *)nameA;
// Modify Element
- (BOOL) ModifyElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA value:(NSString *)string row:(NSInteger)number;
// Find Value
- (NSString *) FindElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA row:(NSInteger)number;

@end

