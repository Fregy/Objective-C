//
//  DrawView.h
//  Midterm
//
//  Created by Alfredo Alba on 10/26/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property (strong, nonatomic) UIBezierPath      *path;
@property (strong, nonatomic) UIImage           *incrementalImage;
@property (strong, nonatomic) NSMutableArray    *pts;
@property (nonatomic) uint                      ctr;

@end
