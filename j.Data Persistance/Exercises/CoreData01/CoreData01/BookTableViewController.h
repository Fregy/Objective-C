//
//  BookTableViewController.h
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParsingCoreData.h"

@interface BookTableViewController : UITableViewController <ParsingCoreDataDelegate>

@property (strong, nonatomic) ParsingCoreData      *parsin;
@property (strong, nonatomic) NSArray              *bookArray;

@end
