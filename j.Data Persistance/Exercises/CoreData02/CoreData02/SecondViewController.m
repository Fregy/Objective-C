//
//  SecondViewController.m
//  CoreData02
//
//  Created by Alfredo Alba on 11/3/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _core               =   [[CoreDataClass alloc] init];
    _band               =   NO;
    _number             =   0;
    _myTeam             =   [[NSArray alloc] init];
    _myPlayer           =   [[NSArray alloc] init];
    _myBackUpTeam       =   [[NSArray alloc] init];
    _myBackUpPlayer     =   [[Player alloc] init];
    _myModifyPlayer     =   [[Player alloc] init];
    _parsin             =   [[ParsingCoreData alloc] init];
    
    _parsin.delegate    =   self;
    [_parsin startConnection:@"Team" idNumber:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    _parsin.delegate    =   self;
    [_parsin startConnection:@"Team" idNumber:0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_myTeam count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return ((Team *)[_myTeam objectAtIndex:section]).name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    _parsin.delegate    =   self;
    [_parsin startConnection:@"Player" idNumber:section];
    return [_myPlayer count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"Cell";
    
    _parsin.delegate    =   self;
    [_parsin startConnection:@"Player" idNumber:indexPath.section];
    
    UITableViewCell *cell       = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib            = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell                    = [nib objectAtIndex:0];
    }
    
    cell.textLabel.text         = ((Player *)[_myPlayer objectAtIndex:indexPath.row]).name;
    cell.detailTextLabel.text   = [NSString stringWithFormat:@"%@", ((Player *)[_myPlayer objectAtIndex:indexPath.row]).age];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return _band;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [_core deleteAttributePlayers:@"Player" withName:cell.textLabel.text];
        
        _parsin.delegate    =   self;
        [_parsin startConnection:@"Team" idNumber:indexPath.section];
        
        [_tableView reloadData];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView          =   [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 30)];
    headerView.backgroundColor  =   [UIColor colorWithRed:248.0f/255.0f
                                                    green:248.0f/255.0f
                                                     blue:255.0f/255.0f
                                                    alpha:1.0f];
    
    UILabel *headerLabel    =   [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 375, 30)];
    headerLabel.text        =   [[_myTeam objectAtIndex:section] valueForKey:@"name"];
    [headerView addSubview:headerLabel];
    
    if (_band) {
        UIButton *button    =   [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag          =   section + 1000;
        button.frame        =   CGRectMake(350, 5, 20, 20);
        [button setImage:[UIImage imageNamed:@"deleteCircle"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];

    }
        return headerView;
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
    NSInteger section       =   sender.tag - 1000;
    
    [_core deleteAttribute:@"Player" withID:section];
    [_core deleteEntity:@"Team" withName:((Team *)[_myTeam objectAtIndex:section]).name];
    
    _parsin.delegate    =   self;
    [_parsin startConnection:@"Team" idNumber:section];
    
    [_tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath          = [self.tableView indexPathForSelectedRow];
        
    EditPlayerViewController *destViewController = segue.destinationViewController;
    
    destViewController.myTeams      = _myTeam;
    destViewController.myName       = ((Player *)[_myPlayer objectAtIndex:indexPath.row]).name;
    destViewController.myAge        = [NSString stringWithFormat:@"%@", ((Player *)[_myPlayer objectAtIndex:indexPath.row]).age];
    
    _myBackUpPlayer                 = [_myPlayer objectAtIndex:indexPath.row];
    
    destViewController.delegate     = self;
}

- (IBAction)bSave:(UIButton *)sender {

    _myBackUpTeam   =   _myTeam;
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         _myModifyPlayer.name, @"name",
                         _myModifyPlayer.age, @"age", nil];
    
    [_core insertDataPlayerModify:@"Player" allData:dic idNumber:[_myModifyPlayer.teamid integerValue] withName:_myBackUpPlayer.name];
    
    [_tableView reloadData];
    
}

- (IBAction)bDeletTeam:(UIButton *)sender {
    
    if (_band) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Message"
                                      message:@"Delete Mode Off"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 _band       = NO;
                                 [_tableView reloadData];
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Message"
                                      message:@"Delete Mode On"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 _band       = YES;
                                 [_tableView reloadData];
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)bUndo:(UIButton *)sender {
    
    if (_myTeam != nil && _myBackUpTeam != nil && _myBackUpPlayer != nil && _myModifyPlayer != nil) {
        _myTeam     =   _myBackUpTeam;
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             _myBackUpPlayer.name, @"name",
                             _myBackUpPlayer.age, @"age", nil];
        
        [_core insertDataPlayerModify:@"Player" allData:dic idNumber:[_myBackUpPlayer.teamid integerValue] withName:_myModifyPlayer.name];
        
        [_tableView reloadData];
    }
}

- (void) didDidFinishParsingTeam:(NSArray *)data {
    
    _myTeam         = data;
    
    [self.tableView reloadData];
}

- (void) didDidFinishParsingPlayer:(NSArray *)data {
    
    _myPlayer       = data;
}

- (void)didFinishGetDataPlayers:(Player *)p myTeam:(NSInteger)num {
    
    _number         = num;
    _myModifyPlayer = p;
}
@end
