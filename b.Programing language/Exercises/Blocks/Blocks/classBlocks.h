//
//  classBlocks.h
//  Blocks
//
//  Created by Alfredo Alba on 9/18/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface classBlocks : NSObject

-(void)methodWithParameters:(NSInteger)number withSucess:(void(^)())successBlock andFailure:(void(^)())failureBlock;

- (NSString*)playingWithBlock:(NSString*)number and:(NSString* (^)(NSString*num))dobleNumber;

@end
