//
//  AddViewController.m
//  NumberAdder
//
//  Created by Alfredo Alba  on 10/5/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize numbersA;
@synthesize arrayNumbers;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    numbersA = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
// Number of Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [numbersA count];
}
// Cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.textLabel.text = [numbersA objectAtIndex:indexPath.row];
    
    return cell;
}
// Row Selection
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Do you want to Add this Number?"
                                  message:[numbersA objectAtIndex:indexPath.row]
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             if (arrayNumbers == nil) {
                                 arrayNumbers = [[NSMutableArray alloc] init];
                             }
                             [arrayNumbers addObject:[numbersA objectAtIndex:indexPath.row]];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             [self performSegueWithIdentifier:@"numberAdded" sender:self];
                         }];
    
    [alert addAction:ok]; // add action to uialertcontroller
    
}

@end
