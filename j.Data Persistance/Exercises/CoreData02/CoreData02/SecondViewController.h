//
//  SecondViewController.h
//  CoreData02
//
//  Created by Alfredo Alba on 11/3/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditPlayerViewController.h"
#import "ParsingCoreData.h"
#import "CoreDataClass.h"
#import "Player.h"
#import "Team.h"

@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ParsingCoreDataDelegate, EditPlayerDelegate>

@property (nonatomic)         BOOL                      band;

@property (nonatomic)         NSInteger                 number;

@property (strong, nonatomic) CoreDataClass             *core;

@property (strong, nonatomic) NSArray                   *myTeam;
@property (strong, nonatomic) NSArray                   *myPlayer;
@property (strong, nonatomic) NSArray                   *myBackUpTeam;
@property (strong, nonatomic) Player                   *myBackUpPlayer;
@property (strong, nonatomic) Player                    *myModifyPlayer;

@property (strong, nonatomic) ParsingCoreData           *parsin;

- (IBAction)bSave:(UIButton *)sender;
- (IBAction)bDeletTeam:(UIButton *)sender;
- (IBAction)bUndo:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITableView      *tableView;
@end
