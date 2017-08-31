//
//  ContextClass.h
//  Midterm
//
//  Created by Alfredo Alba on 10/27/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ContextClass : NSObject

// Distance Between 2 Points
- (CGFloat)calculateDistanceBetween:(CGPoint)point1 point2:(CGPoint)point2;
// Degress with 2 points
- (CGFloat)getDegrees:(CGPoint)startingPoint secondPoint:(CGPoint) endingPoint;

- (void)makeLine:(UIView *)mainView theCanvas:(UIImageView *)view colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue theBrush:(CGFloat)brush lastPoint:(CGPoint)last currentPoint:(CGPoint)current opacityValue:(CGFloat)opacity;

- (void)makeCircle:(UIView *)mainView theCanvas:(UIImageView *)view colorRed:(CGFloat)red colorGreen:(CGFloat)green colorBlue:(CGFloat)blue theBrush:(CGFloat)brush lastPoint:(CGPoint)last currentPoint:(CGPoint)current opacityValue:(CGFloat)opacity distance:(CGFloat)diamet;

- (void)imageViewPagination:(UIView *)view principal:(UIImageView *)mainImage theCanvas:(UIImageView *)image opacityValue:(CGFloat)opacity;

@end
