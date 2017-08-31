//
//  ArrayClass.m
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ArrayClass.h"

@implementation ArrayClass

- (NSArray *)clearArrayElement:(NSArray *)primalArray{
    
    NSMutableArray *auxArray     =  [[NSMutableArray alloc] init];
    
    for (FuzzClass *f  in primalArray) {
        if (![f.myData isEqualToString:@""] && f.myData != nil) {
            if (![f.myDate  isEqualToString:@""] && f.myDate != nil) {
                
                [auxArray addObject:f];
            }
        }
    }
    
    return [auxArray copy];
}

- (NSInteger)countElement:(NSArray *)primalArray withThis:(NSString *)element {
    NSInteger count =   0;
    
    for (FuzzClass *f in primalArray) {
        
        if ([f.myType isEqualToString:element]) {
            count++;
        }
    }
    
    return count;
}

- (NSArray *)makeArrayWithElement:(NSArray *)primalArray withThis:(NSString *)element {
    
    NSMutableArray *auxArray     =  [[NSMutableArray alloc] init];
    
    for (FuzzClass *f in primalArray) {
    
        if ([f.myType isEqualToString:element]) {
            [auxArray addObject:f];
        }
    }
    
    return [auxArray copy];
}
@end
