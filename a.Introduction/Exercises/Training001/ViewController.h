//
//  ViewController.h
//  Training001
//
//  Created by Alfredo Alba on 9/10/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(strong,nonatomic)NSString* myString;
@property(weak,nonatomic)NSString* p;

@property (strong, nonatomic) IBOutlet UITextField * textField;
@property (strong, nonatomic) IBOutlet UILabel * labelField;
@property (strong, nonatomic) NSArray *colors;

@end

