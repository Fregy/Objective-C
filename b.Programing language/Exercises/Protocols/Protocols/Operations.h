//
//  Operations.h
//  Protocols
//
//  Created by Alfredo Alba on 9/17/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Operation <NSObject>

@required
-(void)didTheaddOperationFinished:(NSString*) result;
-(void)didThesubtraccionOperationFinished:(NSString*) result;
-(void)didThemultiplicationOperationFinished:(NSString*) result;
-(void)didThedivisionOperationFinished:(NSString*) result;

@end

@interface Operations : NSObject

@property (strong,nonatomic) id<Operation> delegate;

-(void)addOperation: (NSString*)A andB:(NSString*)B;
-(void)subtraccionOperation: (NSString*)A andB:(NSString*)B;
-(void)multiplicationOperation: (NSString*)A andB:(NSString*)B;
-(void)divisionOperation: (NSString*)A andB:(NSString*)B;

@end