//
//  ParsingCoreData.m
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ParsingCoreData.h"

@implementation ParsingCoreData

- (void)startConnection:(NSString *)Table {

    _coreD              =   [[CoreDataClass alloc] init];
    _myBook             =   [[BookClass alloc] init];
    _myMovie            =   [[MovieClass alloc] init];
    
    _coreD.delegate     =   self;
    [_coreD getAllData:Table];
}

- (void)startParsingMovie:(NSArray *)array {
    
    NSMutableArray    *auxArray = [[NSMutableArray alloc] init];
    
    if ([array count] != 0) {
        
        for (int i = 0; i < [array count]; i++) {
            
            _myMovie.title  = [[array objectAtIndex:i ] valueForKey:@"title"];
            _myMovie.main   = [[array objectAtIndex:i ] valueForKey:@"main_character"];
            _myMovie.season = [[array objectAtIndex:i ] valueForKey:@"season"];
            _myMovie.airing = [[array objectAtIndex:i ] valueForKey:@"airing"];
            
            [auxArray addObject:_myMovie];
            _myMovie            =   [[MovieClass alloc] init];
        }
        
        [self.delegate didDidFinishParsing:[auxArray copy]];
    }
}

- (void)startParsingBook:(NSArray *)array {
    
    NSMutableArray    *auxArray = [[NSMutableArray alloc] init];
    
    if ([array count] != 0) {
        
        for (int i = 0; i < [array count]; i++) {
            
            _myBook.title   = [[array objectAtIndex:i ] valueForKey:@"title"];
            _myBook.author  = [[array objectAtIndex:i ] valueForKey:@"author"];
            _myBook.page    = [[array objectAtIndex:i ] valueForKey:@"page"];
            _myBook.TGO     = [[array objectAtIndex:i ] valueForKey:@"percentTGO"];
            
            [auxArray addObject:_myBook];
            _myBook             =   [[BookClass alloc] init];
        }
        
        [self.delegate didDidFinishParsing:[auxArray copy]];
    }
}

-(void)didFinishGetAllDataMovie:(NSArray *)data {
    
    [self startParsingMovie:data];
}

-(void)didFinishGetAllDataBook:(NSArray *)data {
    
    [self startParsingBook:data];
}

@end
