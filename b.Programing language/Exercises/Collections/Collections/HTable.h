//
//  HTable.h
//  Collections
//
//  Created by Alfredo Alba on 9/16/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTable : NSObject

@property int key;
@property (weak, nonatomic)NSString * valChar;

-(id)iniHTable;
-(void)SetValueHTable:(int) k AndStringValue:(NSString*)val;
-(int)GetPointK;
-(NSString*)GetPointVal;

@end
