//
//  ThirdViewController.h
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "SQLiteClass.h"
#import "ContextClass.h"


@interface ThirdViewController : UIViewController <UIActionSheetDelegate>
{
    sqlite3                                             *drawDB;
}

@property (strong, nonatomic) SQLiteClass               *sql;

@property (strong, nonatomic) ContextClass              *context;

@property (nonatomic) CGPoint                           lastPoint;
@property (nonatomic) CGFloat                           red;
@property (nonatomic) CGFloat                           green;
@property (nonatomic) CGFloat                           blue;
@property (nonatomic) CGFloat                           brush;
@property (nonatomic) CGFloat                           opacity;

@property (nonatomic) BOOL                              bandFree;
@property (nonatomic) BOOL                              bandLine;
@property (nonatomic) BOOL                              bandCircle;
@property (nonatomic) BOOL                              mouseSwiped;

@property (nonatomic) CGPoint                           currentPoint;

@property (weak, nonatomic) IBOutlet UIImageView        *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView        *tempImage;

@property (strong, nonatomic) NSString                  *databasePath;

- (void)colorLine:(NSInteger)color;
- (void)saveImage;

- (IBAction)bFree:(UIButton *)sender;
- (IBAction)bLine:(UIButton *)sender;
- (IBAction)bCircle:(UIButton *)sender;
- (IBAction)bClear:(UIButton *)sender;

@end
