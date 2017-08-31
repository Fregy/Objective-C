//
//  ViewController.m
//  NavTab
//
//  Created by Alfredo Alba on 10/4/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "AddViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController 

@synthesize ninjaArray;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
        
        DetailViewController *destViewController = segue.destinationViewController;
        
        destViewController.ninjaArray = ninjaArray;
        destViewController.textN = [ninjaArray objectAtIndex:indexPath.row];
    } else {
        
        AddViewController *destViewController = segue.destinationViewController;
        destViewController.ninjaArray = ninjaArray;
    }
    
}

#pragma mark - TableView
// Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
// Number of Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ninjaArray count];
}
// Cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.textLabel.text = [ninjaArray objectAtIndex:indexPath.row];
    
    return cell;
}
// Delete Rows
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [ninjaArray removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadData];
    }
}

@end
