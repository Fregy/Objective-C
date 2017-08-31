//
//  HTable.m
//  Collections
//
//  Created by Alfredo Alba on 9/16/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "HTable.h"

@implementation HTable

-(id)iniHTable {
    
    self.key = 0;
    self.valChar = @"";
    
    return self;
    
}

-(void)SetValueHTable:(int)k AndStringValue:(NSString *)val {
    self.key = k;
    self.valChar = val;
}

-(int)GetPointK {
    return self.key;
}

-(NSString*)GetPointVal {
    NSString * v = [[NSString alloc]init];
    v = self.valChar;
    
    return v;
}

@end
