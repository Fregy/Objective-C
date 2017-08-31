//
//  ContextClass.m
//  Midterm
//
//  Created by Alfredo Alba on 10/27/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ContextClass.h"

@implementation ContextClass

// Distance Between 2 Points
- (CGFloat)calculateDistanceBetween:(CGPoint)point1 point2:(CGPoint)point2
{
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx*dx + dy*dy );
}
// Degress with 2 points
- (CGFloat) getDegrees:(CGPoint)startingPoint secondPoint:(CGPoint) endingPoint
{
    CGPoint originPoint = CGPointMake(endingPoint.x - startingPoint.x, endingPoint.y - startingPoint.y); // get origin point to origin by subtracting end from start
    float bearingRadians = atan2f(originPoint.y, originPoint.x); // get bearing in radians
    float bearingDegrees = bearingRadians * (180.0 / M_PI); // convert to degrees
    bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)); // correct discontinuity
    return bearingDegrees;
}

- (void)makeLine:(UIView *)mainView theCanvas:(UIImageView *)view colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue theBrush:(CGFloat)brush lastPoint:(CGPoint)last currentPoint:(CGPoint)current opacityValue:(CGFloat)opacity {
    
    UIGraphicsBeginImageContext(mainView.frame.size);
    [view.image drawInRect:CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), last.x, last.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), current.x, current.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    view.image = UIGraphicsGetImageFromCurrentImageContext();
    [view setAlpha:opacity];
    UIGraphicsEndImageContext();
}

- (void)makeCircle:(UIView *)mainView theCanvas:(UIImageView *)view colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue theBrush:(CGFloat)brush lastPoint:(CGPoint)last currentPoint:(CGPoint)current opacityValue:(CGFloat)opacity distance:(CGFloat)diamet{
    
    UIGraphicsBeginImageContext(mainView.frame.size);
    [view.image drawInRect:CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height)];
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextAddArc(UIGraphicsGetCurrentContext(), last.x, last.y, diamet, 0, 2 * 3.1416, 1);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    view.image = UIGraphicsGetImageFromCurrentImageContext();
    [view setAlpha:opacity];
    UIGraphicsEndImageContext();
}

- (void)imageViewPagination:(UIView *)view principal:(UIImageView *)mainImage theCanvas:(UIImageView *)image opacityValue:(CGFloat)opacity {
    
    UIGraphicsBeginImageContext(mainImage.frame.size);
    [mainImage.image drawInRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [image.image drawInRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    image.image = nil;
    UIGraphicsEndImageContext();
}

@end
