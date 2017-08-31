//
//  ArrayClass.h
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FuzzClass.h"

@interface ArrayClass : NSObject

@property (strong, nonatomic) FuzzClass         *fuzz;

- (NSArray *)clearArrayElement:(NSArray *)primalArray;
- (NSInteger)countElement:(NSArray *)primalArray withThis:(NSString *)element;
- (NSArray *)makeArrayWithElement:(NSArray *)primalArray withThis:(NSString *)element;

@end
