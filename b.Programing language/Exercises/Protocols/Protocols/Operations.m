//
//  Operations.m
//  Protocols
//
//  Created by Alfredo Alba on 9/17/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "Operations.h"

@implementation Operations

-(void)addOperation: (NSString*)A andB:(NSString*)B {
    
    NSInteger result = A.integerValue+B.integerValue;
    
    if (self.delegate) {
        [self.delegate didTheaddOperationFinished:[NSString stringWithFormat:@"%ld", result]];
    }
    
}
-(void)subtraccionOperation: (NSString*)A andB:(NSString*)B {
    
    NSInteger result = A.integerValue-B.integerValue;
    
    if (self.delegate) {
        [self.delegate didThesubtraccionOperationFinished:[NSString stringWithFormat:@"%ld", result]];
    }
}
-(void)multiplicationOperation: (NSString*)A andB:(NSString*)B {
    
    NSInteger result = A.integerValue*B.integerValue;
    
    if (self.delegate) {
        [self.delegate didThemultiplicationOperationFinished:[NSString stringWithFormat:@"%ld", result]];
    }
}
-(void)divisionOperation: (NSString*)A andB:(NSString*)B{
    
    NSInteger result = A.integerValue/B.integerValue;
    
    if (self.delegate) {
        [self.delegate didThedivisionOperationFinished:[NSString stringWithFormat:@"%ld", result]];
    }
}

@end