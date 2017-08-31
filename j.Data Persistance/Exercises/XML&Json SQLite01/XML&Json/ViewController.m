//
//  ViewController.m
//  XML&Json
//
//  Created by Alfredo Alba on 10/19/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "sqlite3.h"

#define URLJson     [NSURL URLWithString: @"http://itunes.apple.com/us/rss/topalbums/limit=20/json"]

#define mainQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ViewController ()

@end

@implementation ViewController

@synthesize databasePath;

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString* docsDirectory;
    NSArray* dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Get the path to the DB
    docsDirectory   =   [dirPaths objectAtIndex:0];
    databasePath    =   [[NSString alloc] initWithString:[docsDirectory stringByAppendingPathComponent:@"songs.db"]];
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"TEXT UNIQUE", @"SONG",
                          @"TEXT", @"ARTIST",
                          @"TEXT", @"FAVORITE", nil];
    
    [self CreateTableDB:databasePath dataBase:songDB table:@"SONGS" atrib:dic];
    
    dispatch_sync(mainQueue, ^{
        
        NSData  *data   =   [NSData dataWithContentsOfURL:URLJson];
        
        [self performSelectorOnMainThread:@selector(dataRetreived:) withObject:data waitUntilDone:YES];
        
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// JSON
- (void)dataRetreived:(NSData*) dataResponse {
    
    NSError *error;

    // Get all the data
    NSDictionary* dictionary  =   [NSJSONSerialization JSONObjectWithData:dataResponse options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary* topDictionary = [[dictionary objectForKey:@"feed"] objectForKey:@"entry"];
    
    for (NSDictionary *d in topDictionary) {
        NSString* songTitle =   [[d objectForKey:@"im:name"]objectForKey:@"label"];
        NSString* songArtist =   [[d objectForKey:@"im:artist"]objectForKey:@"label"];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              songTitle, @"song",
                              songArtist, @"artist",
                              @"", @"favorite", nil];
        
        [self InsertElementsDB:databasePath dataBase:songDB table:@"SONGS" atrib:dict];
        
    }
    
    [self.tableView reloadData];
}

// TABLE VIEW
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self NumberOfTable:databasePath dataBase:songDB table:@"SONGS"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text         =   [self FindElementFromDB:databasePath dataBase:songDB table:@"SONGS" atrib:@"song" row:indexPath.row+1];
    cell.detailTextLabel.text   =   [self FindElementFromDB:databasePath dataBase:songDB table:@"SONGS" atrib:@"artist" row:indexPath.row+1];;
    cell.imageView.image        =   [UIImage imageNamed:[self FindElementFromDB:databasePath dataBase:songDB table:@"SONGS" atrib:@"favorite" row:indexPath.row+1]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([self ModifyElementFromDB:databasePath dataBase:songDB table:@"SONGS" atrib:@"favorite" value:@"fav" row:indexPath.row+1]) {
        cell.imageView.image = [UIImage imageNamed:@"fav"];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([self DeleteElementFromDB:databasePath dataBase:songDB table:@"SONGS" atrib:@"song" delete:cell.textLabel.text]) {
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }    
}

// CREATE TABLE DB
- (void) CreateTableDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSDictionary *)nameA {

    const char *dbPath  =   [path UTF8String];
    
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        // Object to save errors:
        char* errMsg;
        
        // Create the DB
        NSString *myString = [[NSString alloc] init];
        
        for (NSString *s in [nameA allKeys]) {
            myString = [NSString stringWithFormat:@"%@, %@ %@",myString , s, [nameA objectForKey:s]];
        }
        
        const char *sql_stmt    =   [[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT %@)",nameT, myString] cStringUsingEncoding:NSASCIIStringEncoding];
        
        // Show error if can't create a table
        if (!(sqlite3_exec(nameDB, sql_stmt, NULL, NULL, &errMsg))) {
            NSLog(@"Can't Create a Table");
        }
        sqlite3_close(nameDB);
    } else {
        NSLog(@"Failed/Create a DB");
    }
}
// INSERT Elements on DB
- (void) InsertElementsDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSDictionary *)nameA {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString *myString = [[NSString alloc] init];
        NSString *myStringValues = [[NSString alloc] init];
        
        for (NSString *s in [nameA allKeys]) {
            if ([myString isEqualToString:@""]) {
                myString = [NSString stringWithFormat:@"%@" , s];
            } else {
                myString = [NSString stringWithFormat:@"%@, %@",myString , s];
            }
            
            if ([myStringValues isEqualToString:@""]) {
                myStringValues = [NSString stringWithFormat:@"\"%@\"", [nameA objectForKey:s]];
            } else {
                myStringValues = [NSString stringWithFormat:@"%@, \"%@\"",myStringValues , [nameA objectForKey:s]];
            }
        }
        
        const char *insert_stmt =   [[NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",nameT, myString, myStringValues] cStringUsingEncoding:NSASCIIStringEncoding];
        
        sqlite3_prepare_v2(nameDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
            NSLog(@"Success to Add");
        } else {
            
            NSLog(@"Failed to Add");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(nameDB);
    }
}
// Number of elements of a DB
- (NSInteger)NumberOfTable:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT {
    
    NSInteger num;
    
    if (sqlite3_open([path UTF8String], &nameDB) == SQLITE_OK)
    {
        const char* sqlStatement = [[NSString   stringWithFormat:@"SELECT COUNT(*) FROM %@", nameT] UTF8String];
        
        sqlite3_stmt *statement;
        
        if( sqlite3_prepare_v2(nameDB, sqlStatement, -1, &statement, NULL) == SQLITE_OK )
        {
            //Loop through all the returned rows (should be just one)
            while( sqlite3_step(statement) == SQLITE_ROW )
            {
                num = sqlite3_column_int(statement, 0);
            }
        }
        else {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(nameDB) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(nameDB);
    }
    
    return num;
}
// Delete Row from DB
- (BOOL) DeleteElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA delete:(NSString *)element {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    // Open the DB
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString    *querySQL   =   [NSString   stringWithFormat:@"DELETE FROM %@ WHERE %@ IS '%@'", nameT, nameA,element];
        
        const char  *query_stmt =   [querySQL UTF8String];
        
        // Prepare the query
        if (sqlite3_prepare_v2(nameDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // If this worked, we must have a row if the data was there
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                sqlite3_finalize(statement);
                sqlite3_close(nameDB);
                return YES;
            }
        } else {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:@"Record Not Found"
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        sqlite3_finalize(statement);
        sqlite3_close(nameDB);
    }
    return NO;
}

- (BOOL) ModifyElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA value:(NSString *)string row:(NSInteger)number {

    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString*   insertSQL   =   [NSString stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE ID = %ld", nameT, nameA, string,(long)number];
        
        // convert
        const char      *insert_stmt =   [insertSQL UTF8String];
        //sqlite3_stmt    *statement2;
        
        sqlite3_prepare_v2(nameDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Update"
                                          message:@"Element Updated"
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
            sqlite3_finalize(statement);
            sqlite3_close(nameDB);
            return YES;
        } else {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:@"Failed on Update"
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        sqlite3_finalize(statement);
        sqlite3_close(nameDB);
    }

    return NO;
}

- (NSString *) FindElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA row:(NSInteger)number {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    // Open the DB
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString    *querySQL   =   [NSString   stringWithFormat:@"SELECT %@ FROM %@ WHERE ID = %ld", nameA, nameT,(long)number];
        
        const char  *query_stmt =   [querySQL UTF8String];
        
        // Prepare the query
        if (sqlite3_prepare_v2(nameDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // If this worked, we must have a row if the data was there
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSString *result = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
                
                sqlite3_finalize(statement);
                sqlite3_close(nameDB);
                
                return result;
                
            } else {
                
                NSLog(@"Match not");
            }
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(nameDB);
    
    return @"";
}

@end
