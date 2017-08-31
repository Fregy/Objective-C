//
//  XYPoint.m
//  Classes
//
//  Created by Alfredo Alba on 9/16/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "XYPoint.h"

@implementation XYPoint

-(id)pointXY {
    
    self.Xf = 0;
    self.Yf = 0;
    
    return self;
    
}

-(void)SetPointX:(float)X AndPointY:(float)Y {
    
    self.Xf = X;
    self.Yf = Y;
    
}

-(float)GetPointX {
    
    return self.Xf;
    
}

-(float)GetPointY {
    
    return self.Yf;
}

@end
