//
//  classBlocks.m
//  Blocks
//
//  Created by Alfredo Alba on 9/18/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "classBlocks.h"

@implementation classBlocks

-(void)methodWithParameters:(NSInteger)number withSucess:(void(^)())successBlock andFailure:(void(^)())failureBlock {
    
    if((int)number < 10) {
        
        successBlock();
        
    }else {
        
        failureBlock();
    }
}

- (NSString*)playingWithBlock:(NSString*)number and:(NSString* (^)(NSString*num))dobleNumber {
    
    return dobleNumber(number);
    
}

@end
