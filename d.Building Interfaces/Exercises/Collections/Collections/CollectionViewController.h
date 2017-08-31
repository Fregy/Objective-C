//
//  CollectionViewController.h
//  Collections
//
//  Created by Alfredo Alba on 10/3/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray* personArray;
@property (strong, nonatomic) NSMutableDictionary* per;
@property (strong, nonatomic) Person* p;
@property (nonatomic) BOOL band;

- (IBAction)bLess:(UIButton *)sender;

@end
