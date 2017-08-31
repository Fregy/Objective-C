//
//  ParsingCoreData.m
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ParsingCoreData.h"

@implementation ParsingCoreData

- (void)startConnection:(NSString *)Table idNumber:(NSInteger)myID {

    _coreD              =   [[CoreDataClass alloc] init];
    _myTeam             =   [[Team alloc] init];
    _myPlayer           =   [[Player alloc] init];
    
    _coreD.delegate     =   self;
    if ([Table isEqualToString:@"Team"]) {
        [_coreD getAllData:Table];
    } else {
        [_coreD getPlayers:myID];
    }
    
}

- (void)startParsingTeam:(NSArray *)array {
    
    NSMutableArray    *auxArray = [[NSMutableArray alloc] init];
    
    if ([array count] != 0) {
        
        for (int i = 0; i < [array count]; i++) {
            
            _myTeam.name   = [[array objectAtIndex:i] valueForKey:@"name"];
            _myTeam.color  = [[array objectAtIndex:i] valueForKey:@"color"];
            _myTeam.myID   = [[array objectAtIndex:i] valueForKey:@"id"];
            
            [auxArray addObject:_myTeam];
            _myTeam        =   [[Team alloc] init];
        }
        
        [self.delegate didDidFinishParsingTeam:[auxArray copy]];
    }
}

- (void)startParsingPlayer:(NSArray *)array {
    
    NSMutableArray    *auxArray = [[NSMutableArray alloc] init];
    
    if ([array count] != 0) {
        
        for (int i = 0; i < [array count]; i++) {
            
            _myPlayer.name    = [[array objectAtIndex:i] valueForKey:@"name"];
            _myPlayer.age     = [[array objectAtIndex:i] valueForKey:@"age"];
            _myPlayer.teamid  = [[array objectAtIndex:i] valueForKey:@"team"];
            
            [auxArray addObject:_myPlayer];
            _myPlayer         =   [[Player alloc] init];
        }
    }
    
    [self.delegate didDidFinishParsingPlayer:[auxArray copy]];
}


-(void)didFinishGetAllDataTeam:(NSArray *)data {
    
    [self startParsingTeam:data];
}

-(void)didFinishGetAllDataPlayer:(NSArray *)data {
    
    [self startParsingPlayer:data];
}

@end
