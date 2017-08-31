//
//  SQLiteClass.h
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface SQLiteClass : NSObject

- (void) CreateTableDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSDictionary *)nameA;
- (void) InsertElementsDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSDictionary *)nameA;
- (NSInteger)NumberOfTable:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT element:(NSString *)nameA;
- (BOOL) ResetTableValues:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT;
- (BOOL) DeleteElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA delete:(NSString *)element;
- (BOOL) ModifyElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA value:(NSString *)string row:(NSInteger)number;
- (BOOL) ModifyElementWithValueFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA value:(NSString *)string atrib2:(NSString *)nameA2 value:(NSString *)element;
- (NSString *) FindElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA row:(NSInteger)number;
- (NSString *) GetElementFromDB:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA atrib2:(NSString *)nameA2 value:(NSString *)element;
- (NSMutableArray *) GetElementFromDBArray:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA;
- (BOOL) FindElementFromDBValue:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA atrib2:(NSString *)nameA2 value:(NSString *)element;
- (void)showImage:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA image:(UIImageView *)imageView;
- (void)saveImage:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT atrib:(NSString *)nameA image:(UIImageView *)imageView;
@end
