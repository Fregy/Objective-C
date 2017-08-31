//
//  ParsingCoreData.h
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataClass.h"
#import "Team.h"
#import "Player.h"

@protocol ParsingCoreDataDelegate <NSObject>

@optional
- (void) didDidFinishParsingTeam:(NSArray *)data;
- (void) didDidFinishParsingPlayer:(NSArray *)data;

@end

@interface ParsingCoreData : NSObject <CoreDataClassDelegate>

@property (weak, nonatomic) id<ParsingCoreDataDelegate> delegate;

@property (strong, nonatomic) CoreDataClass             *coreD;
@property (strong, nonatomic) Player                    *myPlayer;
@property (strong, nonatomic) Team                      *myTeam;

- (void)startConnection:(NSString *)Table idNumber:(NSInteger)myID;
- (void)startParsingTeam:(NSArray *)array;
- (void)startParsingPlayer:(NSArray *)array;


@end
