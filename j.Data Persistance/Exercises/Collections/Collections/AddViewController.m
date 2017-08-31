//
//  AddViewController.m
//  Collections
//
//  Created by Alfredo Alba on 10/2/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "AddViewController.h"
#import "CollectionViewController.h"
#import "Person.h"
#import "sqlite3.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize personArray;
@synthesize age;
@synthesize filePath;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    filePath = [documentsDirectory stringByAppendingPathComponent:@"Person.db"];
    
    personArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    age = [[NSString alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stIncDec:(UIStepper *)sender {
    
    double newValue = [sender value];
    age = [NSString stringWithFormat:@"%i", (int)newValue];
    self.lbAge.text = age;
}

- (IBAction)bSave:(UIButton *)sender {
    
    if (![self.tfFirst.text isEqualToString:@""] && ![self.tfMiddle.text isEqualToString:@""] && ![self.tfLast.text isEqualToString:@""]) {
        
        // Create SQL statement
        sqlite3_stmt    *statement;
        const char      *dbPath =   [filePath UTF8String];
        
        if (sqlite3_open(dbPath, &PersonDB)==SQLITE_OK) {
            
            NSString*   insertSQL   =   [NSString stringWithFormat:@"INSERT INTO PEOPLE (first, middle, last, age) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")", self.tfFirst.text, self.tfMiddle.text, self.tfLast.text, age];
            
            NSLog(@"%@", insertSQL);
            
            const char      *insert_stmt =   [insertSQL UTF8String];
            
            sqlite3_prepare_v2(PersonDB, insert_stmt, -1, &statement, NULL);
            
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                NSLog(@"Success to add People");
            } else {
                
                NSLog(@"Failed to add people");
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(PersonDB);
        }

    } else {
        self.lbInfo.text = @"Please Change the Info.";
    }
    
}

- (IBAction)bClear:(UIButton *)sender {
    
    self.tfFirst.text = @"";
    self.tfMiddle.text = @"";
    self.tfLast.text = @"";
    self.lbAge.text = @"0";
    age = @"0";
}
@end
