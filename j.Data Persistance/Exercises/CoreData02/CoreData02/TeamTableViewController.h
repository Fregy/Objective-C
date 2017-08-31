//
//  TeamTableViewController.h
//  CoreData02
//
//  Created by Alfredo Alba on 10/29/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParsingCoreData.h"
#import "Team.h"

@interface TeamTableViewController : UITableViewController <ParsingCoreDataDelegate>

@property (strong, nonatomic) NSArray           *myTeam;

@property (strong, nonatomic) ParsingCoreData   *parsin;

@end
