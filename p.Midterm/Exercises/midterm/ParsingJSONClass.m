//
//  ParsingJSONClass.m
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ParsingJSONClass.h"

@implementation ParsingJSONClass

@synthesize auxFuzz;

- (void) starJSON:(NSDictionary *)myDictionary {
    
    self.auxFuzz                 =   [[FuzzClass alloc] init];
    _myFuzzArray            =   [[NSMutableArray alloc] init];
    
    for (NSDictionary *d in myDictionary) {
        
        auxFuzz.myID        = [d objectForKey:@"id"];;
        auxFuzz.myData      = [d objectForKey:@"data"];
        auxFuzz.myDate      = [d objectForKey:@"date"];
        auxFuzz.myType      = [d objectForKey:@"type"];
        
        [_myFuzzArray addObject:auxFuzz];
        
        auxFuzz             =   [[FuzzClass alloc] init];
    }
    
    [self.delegate didFinisJSonParsing:[_myFuzzArray copy]];
}

@end
