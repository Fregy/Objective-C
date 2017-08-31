//
//  SQLiteClass.m
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "SQLiteClass.h"

@implementation SQLiteClass

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
            NSLog(@"Table Created");
            //NSLog(@"could not prepare statement: %s\n", sqlite3_errmsg(nameBD));
        }
        sqlite3_close(nameDB);
    } else {
        NSLog(@"Failed/Create a DB");
    }
}
- (void) CreateTableForeignDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSDictionary *)nameA foreignValue:(NSString *)foreign foreignEntity:(NSString *)entity{
    
    const char *dbPath  =   [path UTF8String];
    
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        // Object to save errors:
        char* errMsg;
        
        // Create the DB
        NSString *myString = [[NSString alloc] init];
        
        for (NSString *s in [nameA allKeys]) {
            myString = [NSString stringWithFormat:@"%@, %@ %@",myString , s, [nameA objectForKey:s]];
        }
        
        const char *sql_stmt    =   [[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT %@ , FOREIGN KEY(%@) REFERENCES %@(ID))",nameT, myString, foreign, entity] cStringUsingEncoding:NSASCIIStringEncoding];
        
        // Show error if can't create a table
        if (!(sqlite3_exec(nameDB, sql_stmt, NULL, NULL, &errMsg))) {
            NSLog(@"Table Created");
            //NSLog(@"could not prepare statement: %s\n", sqlite3_errmsg(nameBD));
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
- (void) InsertElementsDBQuery:(NSString *)path dataBase:(sqlite3 *)nameDB query:(NSString *)string {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        const char *insert_stmt =   [string cStringUsingEncoding:NSASCIIStringEncoding];
        
        sqlite3_prepare_v2(nameDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
            NSLog(@"Success to Add");
        } else {
            NSLog(@"ERROR ANAL: %s\n", sqlite3_errmsg(nameDB));
            NSLog(@"Failed to Add");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(nameDB);
    }
}
// Number of elements of a DB
- (NSInteger)NumberOfTable:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT element:(NSString *)nameA {
    
    NSInteger num;
    
    if (sqlite3_open([path UTF8String], &nameDB) == SQLITE_OK)
    {
        const char* sqlStatement = [[NSString   stringWithFormat:@"SELECT COUNT(%@) FROM %@", nameA, nameT] UTF8String];
        
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
        
        NSString    *querySQL   =   [NSString   stringWithFormat:@"DELETE FROM %@ WHERE %@ IS \"%@\"", nameT, nameA,element];
        
        const char  *query_stmt =   [querySQL UTF8String];
        
        // Prepare the query
        if (sqlite3_prepare_v2(nameDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // If this worked, we must have a row if the data was there
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                sqlite3_finalize(statement);
                sqlite3_close(nameDB);
                return YES;
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(nameDB);
    }
    return NO;
}

- (BOOL) ResetTableValues:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    // Open the DB
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString    *querySQL   =   [NSString   stringWithFormat:@"DELETE FROM %@", nameT];
        
        const char  *query_stmt =   [querySQL UTF8String];
        
        // Prepare the query
        if (sqlite3_prepare_v2(nameDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // If this worked, we must have a row if the data was there
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                sqlite3_finalize(statement);
                sqlite3_close(nameDB);
                return YES;
            }
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

            sqlite3_finalize(statement);
            sqlite3_close(nameDB);
            return YES;
        }
        sqlite3_finalize(statement);
        sqlite3_close(nameDB);
    }
    
    return NO;
}

- (BOOL) ModifyElementQuery:(NSString *)path dataBase:(sqlite3 *)nameDB query:(NSString *)string {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        // convert
        const char      *insert_stmt =   [string UTF8String];
        //sqlite3_stmt    *statement2;
        
        sqlite3_prepare_v2(nameDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
            sqlite3_finalize(statement);
            sqlite3_close(nameDB);
            return YES;
        }
        sqlite3_finalize(statement);
        sqlite3_close(nameDB);
    }
    
    return NO;
}

- (BOOL) ModifyElementWithValueFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA value:(NSString *)string atrib2:(NSString *)nameA2 value:(NSString *)element {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString    *insertSQL   =   [NSString   stringWithFormat:@"UPDATE %@ SET %@ = '%@' WHERE %@ = \"%@\"", nameT, nameA, string, nameA2, element];
        
        // convert
        const char      *insert_stmt =   [insertSQL UTF8String];
        
        sqlite3_prepare_v2(nameDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            
                        
            sqlite3_finalize(statement);
            sqlite3_close(nameDB);
            return YES;
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

- (BOOL) FindElementFromDBValue:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA atrib2:(NSString *)nameA2 value:(NSString *)element {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    // Open the DB
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString    *querySQL   =   [NSString   stringWithFormat:@"SELECT %@ FROM %@ WHERE %@ = \"%@\"", nameA, nameT,nameA2,element];
        
        const char  *query_stmt =   [querySQL UTF8String];
        
        // Prepare the query
        if (sqlite3_prepare_v2(nameDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // If this worked, we must have a row if the data was there
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                sqlite3_finalize(statement);
                sqlite3_close(nameDB);
                
                return YES;
                
            } else {
                
                NSLog(@"Match not");
            }
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(nameDB);
    
    return NO;
}


- (NSString *) GetElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA atrib2:(NSString *)nameA2 value:(NSString *)element {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    // Open the DB
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString    *querySQL   =   [NSString   stringWithFormat:@"SELECT %@ FROM %@ WHERE %@ = '%@'", nameA, nameT,nameA2,element];
        
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

- (NSMutableArray *) GetElementFromDBArray:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    NSMutableArray  *auxArray = [[NSMutableArray alloc] init];
    
    // Open the DB
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString    *querySQL   =   [NSString   stringWithFormat:@"SELECT %@ FROM %@", nameA, nameT];
        
        const char  *query_stmt =   [querySQL UTF8String];
        
        // Prepare the query
        if (sqlite3_prepare_v2(nameDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // If this worked, we must have a row if the data was there
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSString *result = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
                
                [auxArray addObject: result];
                
            }
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(nameDB);
    
    return auxArray;
}

- (NSString *) GetIDFromQuery:(NSString *)path dataBase:(sqlite3 *)nameDB query:(NSString *)string {
    
    // Create SQL statement
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    // Open the DB
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString    *querySQL   =   string;
        
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
    
    return @"ERROR";
}

- (NSArray *) GetFromQueryArray:(NSString *)path dataBase:(sqlite3 *)nameDB query:(NSString *)string {
    
    NSMutableArray         *auxArray   =   [[NSMutableArray alloc] init];
    sqlite3_stmt    *statement;
    const char      *dbPath =   [path UTF8String];
    
    // Open the DB
    if (sqlite3_open(dbPath, &nameDB)==SQLITE_OK) {
        
        NSString    *querySQL   =   string;
        
        const char  *query_stmt =   [querySQL UTF8String];
        
        // Prepare the query
        if (sqlite3_prepare_v2(nameDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            
            // If this worked, we must have a row if the data was there
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSString *result = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(statement, 0)];
                
                [auxArray addObject:result];
                
            } 
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(nameDB);
    
    return auxArray;
}

- (void)saveImage:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA image:(UIImageView *)imageView {

    sqlite3_stmt *compiledStmt;
    
    if(sqlite3_open([path UTF8String], &nameDB)==SQLITE_OK){
        
        NSString *insertSQL= [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES(?)", nameT, nameA];
        
        if(sqlite3_prepare_v2(nameDB,[insertSQL cStringUsingEncoding:NSUTF8StringEncoding], -1, &compiledStmt, NULL) == SQLITE_OK){
            
            NSData *imageData=UIImagePNGRepresentation(imageView.image);
            
            sqlite3_bind_blob(compiledStmt, 1, [imageData bytes], (int)[imageData length], SQLITE_TRANSIENT);
            
            if(sqlite3_step(compiledStmt) != SQLITE_DONE ) {
                NSLog( @"Error: %s", sqlite3_errmsg(nameDB) );
            } else {
                NSLog( @"Insert into row id = %lld", (sqlite3_last_insert_rowid(nameDB)));
            }
            
            sqlite3_finalize(compiledStmt);
        }
    }
    sqlite3_close(nameDB);
}

- (void)showImage:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA image:(UIImageView *)imageView {
    
    sqlite3_stmt *compiledStmt;
    
    if(sqlite3_open([path UTF8String], &nameDB)==SQLITE_OK){
        
        NSString *insertSQL = [NSString stringWithFormat:@"SELECT %@ FROM %@", nameA, nameT];
        
        if(sqlite3_prepare_v2(nameDB,[insertSQL cStringUsingEncoding:NSUTF8StringEncoding], -1, &compiledStmt, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(compiledStmt) == SQLITE_ROW) {
                
                int length = sqlite3_column_bytes(compiledStmt, 0);
                
                NSData *imageData = [NSData dataWithBytes:sqlite3_column_blob(compiledStmt, 0) length:length];
                
                if(imageData == nil)
                    NSLog(@"No image found.");
                else
                    imageView.image = [UIImage imageWithData:imageData];
            }
        }
        sqlite3_finalize(compiledStmt);
    }
    sqlite3_close(nameDB);
}

@end
