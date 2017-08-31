//
//  ParsingJSONClass.m
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ParsingJSONClass.h"

@implementation ParsingJSONClass

- (void) starJSON:(NSDictionary *)myDictionary {
    
    _auxSongs                   =   [[SongClass alloc] init];
    _mySongArray                =   [[NSMutableArray alloc] init];
    
    NSDictionary* topDictionary = [[myDictionary objectForKey:@"feed"] objectForKey:@"entry"];
    
    for (NSDictionary *d in topDictionary) {
        _auxSongs.myTitle     =   [[d objectForKey:@"title"] objectForKey:@"label"];
        _auxSongs.myAlbum     =   [[d objectForKey:@"im:name"]objectForKey:@"label"];
        _auxSongs.myGenre     =   [[[d objectForKey:@"category"]objectForKey:@"attributes"] objectForKey:@"term"];
        
        [_mySongArray addObject:_auxSongs];

        _auxSongs                   =   [[SongClass alloc] init];
    }
    
    [self.delegate didFinisJSonParsing:[_mySongArray copy]];
}

@end
