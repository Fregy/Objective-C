//
//  Player.h
//  CoreData02
//
//  Created by Alfredo Alba on 10/30/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

@interface Player : NSObject

@property (nullable, nonatomic, retain) NSString    *age;
@property (nullable, nonatomic, retain) NSString    *name;
@property (nullable, nonatomic, retain) NSString    *teamid;//NSManagedObject

@end
