//
//  ParsingJSONClass.h
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FuzzClass.h"

@protocol ParsingJSONClassDelegate <NSObject>

-(void)didFinisJSonParsing:(NSArray *)data;

@end

@interface ParsingJSONClass : NSObject

@property (weak, nonatomic) id<ParsingJSONClassDelegate> delegate;

@property (strong, nonatomic) FuzzClass             *auxFuzz;
@property (strong, nonatomic) NSMutableArray        *myFuzzArray;

- (void) starJSON:(NSDictionary *)myDictionary;

@end
