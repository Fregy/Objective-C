//
//  CollectionViewController.h
//  Collections
//
//  Created by Alfredo Alba on 10/3/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "sqlite3.h"

@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    sqlite3 *PersonDB;
}

@property (strong, nonatomic) NSMutableArray* personArray;
@property (strong, nonatomic) NSMutableDictionary* per;
@property (strong, nonatomic) Person* p;
@property (nonatomic) BOOL band;
@property (strong, nonatomic) NSString* filePath;

- (IBAction)bLess:(UIButton *)sender;
- (NSInteger)NumberOfTable:(NSString *)path dataBase:(sqlite3 *)nameDB table:(NSString *)nameT;

@end
