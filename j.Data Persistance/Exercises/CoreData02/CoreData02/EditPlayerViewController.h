//
//  EditPlayerViewController.h
//  CoreData02
//
//  Created by Alfredo Alba on 10/29/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"
#import "Player.h"

@protocol EditPlayerDelegate <NSObject>

- (void)didFinishGetDataPlayers:(Player *)p myTeam:(NSInteger)num;

@end

@interface EditPlayerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id<EditPlayerDelegate>      delegate;

@property (strong, nonatomic) Player                    *p;

@property (nonatomic)         NSInteger                 myRow;
@property (nonatomic)         NSInteger                 number;
@property (strong, nonatomic) NSArray                   *myTeams;
@property (strong, nonatomic) NSString                  *myAge;
@property (strong, nonatomic) NSString                  *myName;

@property (strong, nonatomic) IBOutlet UITextField      *tfName;
@property (strong, nonatomic) IBOutlet UITextField      *tfAge;

@property (strong, nonatomic) IBOutlet UIPickerView     *myPickerView;

- (IBAction)bChange:(UIButton *)sender;

@end
