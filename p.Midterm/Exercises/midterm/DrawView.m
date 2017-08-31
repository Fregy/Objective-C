//
//  DrawView.m
//  Midterm
//
//  Created by Alfredo Alba on 10/26/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

@synthesize path;
@synthesize incrementalImage;
@synthesize pts;
@synthesize ctr;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMultipleTouchEnabled:NO];
        path = [UIBezierPath bezierPath];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    ctr = 0;
//    UITouch *touch = [touches anyObject];
//    
//    if (pts == nil) {
//        pts = [[NSMutableArray alloc] init];
//    }
//    
//    [pts addObject:[NSValue valueWithCGPoint:[touch locationInView:self]]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
//    CGPoint p = [touch locationInView:self];
//    ctr++;
//    if ([pts count] <= ctr) {
//        [pts addObject:[NSValue valueWithCGPoint:p]];
//    } else {
//        [pts replaceObjectAtIndex:ctr withObject:[NSValue valueWithCGPoint:p]];
//    }
//    
//    if (ctr == 4)
//    {
//        [pts replaceObjectAtIndex:3 withObject:[NSValue valueWithCGPoint:CGPointMake(([[pts objectAtIndex:2] CGPointValue].x + [[pts objectAtIndex:4] CGPointValue].x)/2.0, ([[pts objectAtIndex:2] CGPointValue].y + [[pts objectAtIndex:4] CGPointValue].y)/2.0)]];
//        
//        [path moveToPoint:[[pts objectAtIndex:0] CGPointValue]];
//
//        
//        [path addCurveToPoint:[[pts objectAtIndex:3] CGPointValue] controlPoint1:[[pts objectAtIndex:1] CGPointValue] controlPoint2:[[pts objectAtIndex:2] CGPointValue]];
//        
//        UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0); // ................. (1)
//        
//        if (!incrementalImage)
//        {
//            UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
//            [[UIColor whiteColor] setFill];
//            [rectpath fill];
//        }
//        [incrementalImage drawAtPoint:CGPointZero];
//        [[UIColor blackColor] setStroke];
//        
//        float speed = 0.0;
//        
//        for (int i = 0; i < 3; i++)
//        {
//            float dx = [[pts objectAtIndex:i+1] CGPointValue].x - [[pts objectAtIndex:i] CGPointValue].x;
//            float dy = [[pts objectAtIndex:i+1] CGPointValue].y - [[pts objectAtIndex:i] CGPointValue].y;
//            speed += sqrtf(dx * dx + dy * dy);
//        } // ................. (2)
//        
//#define FUDGE_FACTOR 100 // emperically determined
//        float width = FUDGE_FACTOR/speed; // ................. (3)
//        
//        [path setLineWidth:width];
//        [path stroke];
//        incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        [self setNeedsDisplay];
//        
//        [path removeAllPoints]; // ................. (4)
//        [pts replaceObjectAtIndex:0 withObject:[NSValue valueWithCGPoint:[[pts objectAtIndex:3] CGPointValue]]];
//        [pts replaceObjectAtIndex:1 withObject:[NSValue valueWithCGPoint:[[pts objectAtIndex:4] CGPointValue]]];
//        ctr = 1;
//    }
}

- (void)drawRect:(CGRect)rect
{
//    [incrementalImage drawInRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
    CGContextSetLineWidth(context, 3.0);
    CGContextMoveToPoint(context, 10.0, 10.0);
    CGContextAddLineToPoint(context, 100.0, 100.0);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self setNeedsDisplay];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self touchesEnded:touches withEvent:event];
}

@end
