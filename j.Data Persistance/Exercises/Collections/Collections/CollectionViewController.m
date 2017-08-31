//
//  CollectionViewController.m
//  Collections
//
//  Created by Alfredo Alba on 10/3/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "CollectionViewController.h"
#import "PersonCollectionViewCell.h"
#import "DetailsViewController.h"
#import "sqlite3.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

@synthesize personArray;
@synthesize band;
@synthesize per;
@synthesize p;
@synthesize filePath;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    filePath = [documentsDirectory stringByAppendingPathComponent:@"Person.db"];

    personArray = [[NSMutableArray alloc] init];
    
    band = YES;
    
    const char *dbPath  =   [filePath UTF8String];
    
    if (sqlite3_open(dbPath, &PersonDB)==SQLITE_OK) {
        
        // Object to save errors:
        char* errMsg;
        
        // Create the DB
        const char *sql_stmt    =   "CREATE TABLE IF NOT EXISTS PEOPLE (ID INTEGER PRIMARY KEY AUTOINCREMENT, FIRST TEXT, MIDDLE TEXT, LAST TEXT UNIQUE, AGE TEXT)";
        
        // Show error if can't create a table
        if (!(sqlite3_exec(PersonDB, sql_stmt, NULL, NULL, &errMsg))) {
            NSLog(@"Can't Create a Table");
        }
        sqlite3_close(PersonDB);
    } else {
        NSLog(@"Failed/Create a DB");
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self NumberOfTable:filePath dataBase:PersonDB table:@"PEOPLE"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [filePath UTF8String];
    PersonCollectionViewCell *cell = (PersonCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    // Open the DB
    if (sqlite3_open(dbPath, &PersonDB)==SQLITE_OK) {
        
        NSString    *querySQL   =   [NSString   stringWithFormat:@"SELECT first, middle, last, age FROM people WHERE ID= %ld",(long)(indexPath.section * 2 + indexPath.row)+1];
        
        const char  *query_stmt =   [querySQL UTF8String];
        
        // Prepare the query
        if (sqlite3_prepare_v2(PersonDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // If this worked, we must have a row if the data was there
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSString    *firstField   =   [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
                NSString    *middleField   =   [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
                NSString    *lastField   =   [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 2)];
                NSString    *ageField   =   [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 3)];
                
                cell.lFirst.text = firstField;
                cell.lMiddle.text = middleField;
                cell.lLast.text = lastField;
                cell.lAge.text = ageField;
                
                if (band == YES) {
                    cell.backgroundColor = [UIColor blackColor];
                } else {
                    cell.backgroundColor = [UIColor redColor];
                }
                
            } else {
                
                NSLog(@"Match not");
            }
        }
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(PersonDB);
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (band == NO) {
    [self.collectionView performBatchUpdates:^{
        PersonCollectionViewCell *cell = (PersonCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        
        // Create SQL statement
        sqlite3_stmt    *statement;
        const char      *dbPath =   [filePath UTF8String];
        
        // Open the DB
        if (sqlite3_open(dbPath, &PersonDB)==SQLITE_OK) {
            
            NSString    *querySQL   =   [NSString   stringWithFormat:@"DELETE FROM people WHERE first IS '%@'",cell.lFirst.text];
            
            const char  *query_stmt =   [querySQL UTF8String];
            
            // Prepare the query
            if (sqlite3_prepare_v2(PersonDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
                
                // If this worked, we must have a row if the data was there
                if (sqlite3_step(statement) == SQLITE_DONE) {
                    
                    [personArray removeObjectAtIndex:(indexPath.section * 2 + indexPath.row)];
                    [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
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
            sqlite3_close(PersonDB);
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
        [self.collectionView reloadData];
    }
}

- (IBAction)bLess:(UIButton *)sender {
    
    if (band == YES) {
        band = NO;
        [self.collectionView reloadData];
    } else {
        band = YES;
        [self.collectionView reloadData];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        PersonCollectionViewCell *cell = (PersonCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        
        DetailsViewController *destViewController = segue.destinationViewController;
        
        destViewController.fir = cell.lFirst.text;
        destViewController.mid = cell.lLast.text;
        destViewController.las = cell.lLast.text;
        destViewController.ag = cell.lAge.text;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {

    return band;
}

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
        else
        {
            NSLog( @"Failed from sqlite3_prepare_v2. Error is:  %s", sqlite3_errmsg(nameDB) );
        }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(nameDB);
    }
    
    return num;
}

@end


