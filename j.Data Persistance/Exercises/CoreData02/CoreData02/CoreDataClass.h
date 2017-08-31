//
//  CoreDataClass.h
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"
#import "Player.h"

@protocol CoreDataClassDelegate <NSObject>

- (void)didFinishGetAllDataTeam:(NSArray *)data;
@optional
- (void)didFinishGetAllDataPlayer:(NSArray *)data;

@end

@interface CoreDataClass : NSObject

@property (weak, nonatomic) id<CoreDataClassDelegate>           delegate;

- (void)getAllData:(NSString *)Table;
- (void)getPlayers:(NSInteger)myID;

- (BOOL)insertDataTeam:(NSString *)table allData:(NSDictionary *)data idNumber:(NSInteger)myID;
- (BOOL)insertDataPlayer:(NSString *)table allData:(NSDictionary *)data idNumber:(NSInteger)myID;
- (BOOL)insertDataPlayerModify:(NSString *)table allData:(NSDictionary *)data idNumber:(NSInteger)myID withName:(NSString *)name;

- (BOOL)deleteEntity:(NSString *)table withName:(NSString *)name;
- (BOOL)deleteAttribute:(NSString *)table withID:(NSInteger)myID;
- (BOOL)deleteAttributePlayers:(NSString *)table withName:(NSString *)name;

@end
