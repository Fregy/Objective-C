//
//  JSONClass.m
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "JSONClass.h"

@implementation JSONClass

// JSON
- (void)dataRetreived:(NSURL*) url {
    
    NSError *error;
    NSData  *data       =   [NSData dataWithContentsOfURL:url];
    
    _parsing            =   [[ParsingJSONClass alloc] init];
    
    _parsing.delegate   =   self;
    [_parsing starJSON:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error]];
}

- (void) didFinisJSonParsing:(NSArray *)data {
    [self.delegate didFinishJSon:data];
}

@end
