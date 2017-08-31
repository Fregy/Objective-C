//
//  XYPoint.h
//  Classes
//
//  Created by Alfredo Alba on 9/16/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYPoint : NSObject

@property float Xf;
@property float Yf;

-(id)pointXY;
-(void)SetPointX:(float) X AndPointY:(float)Y;
-(float)GetPointX;
-(float)GetPointY;
    
@end
