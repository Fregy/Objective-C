//
//  DetailsViewController.h
//  Collections
//
//  Created by Alfredo Alba on 10/3/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lFirst;
@property (strong, nonatomic) IBOutlet UILabel *lMiddle;
@property (strong, nonatomic) IBOutlet UILabel *lLast;
@property (strong, nonatomic) IBOutlet UILabel *lAge;

@property (strong, nonatomic) NSString* fir;
@property (strong, nonatomic) NSString* mid;
@property (strong, nonatomic) NSString* las;
@property (strong, nonatomic) NSString* ag;

@end
