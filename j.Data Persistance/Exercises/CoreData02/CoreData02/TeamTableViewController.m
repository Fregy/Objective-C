//
//  TeamTableViewController.m
//  CoreData02
//
//  Created by Alfredo Alba on 10/29/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "TeamTableViewController.h"
#import "AddPlayerViewController.h"
#import "AddTeamViewController.h"

#define mainQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0)

@interface TeamTableViewController ()

@end

@implementation TeamTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myTeam         =   [[NSArray alloc] init];
    _parsin         =   [[ParsingCoreData alloc] init];
    
    _parsin.delegate    =   self;
    [_parsin startConnection:@"Team" idNumber:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    _parsin.delegate    =   self;
    [_parsin startConnection:@"Team" idNumber:0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_myTeam count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell       = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib            = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell                    = [nib objectAtIndex:0];
    }
    
    cell.textLabel.text         = ((Team *)[_myTeam objectAtIndex:indexPath.row]).name;
    cell.detailTextLabel.text   = ((Team *)[_myTeam objectAtIndex:indexPath.row]).color;
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"addPlayer"]) {
        
        AddPlayerViewController *destViewController = segue.destinationViewController;
        
        destViewController.myTeams = _myTeam;
        destViewController.number  = indexPath.row;
    }
    if ([segue.identifier isEqualToString:@"addTeam"]) {
        
        AddTeamViewController *destViewController = segue.destinationViewController;
    
        destViewController.number  = [_myTeam count]+1;
    }
}

#pragma mark - Delegate

- (void) didDidFinishParsingTeam:(NSArray *)data {
    
    _myTeam = data;
    
    [self.tableView reloadData];
    
}

@end
