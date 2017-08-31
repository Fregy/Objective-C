//
//  DetailViewController.h
//  NavTab
//
//  Created by Alfredo Alba on 10/4/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lbLabel;
@property (strong, nonatomic) NSString* textN;
@property (strong, nonatomic) NSMutableArray* ninjaArray;

@end
