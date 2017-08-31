//
//  MovieTableViewController.m
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "MovieTableViewController.h"
#import "MovieTableViewCell.h"
#import "MovieClass.h"

#define mainQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0)

@interface MovieTableViewController ()

@end

@implementation MovieTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _parsin             =   [[ParsingCoreData alloc] init];
    _movieArray         =   [[NSArray alloc] init];
    
    dispatch_sync(mainQueue, ^{
        
        _parsin.delegate    =   self;
        [_parsin startConnection:@"Movie"];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    _parsin.delegate    =   self;
    [_parsin startConnection:@"Movie"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_movieArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieTableViewCell *cell = (MovieTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.lbTitle.text             = ((MovieClass *)[_movieArray objectAtIndex:indexPath.row]).title;
    cell.lbMain.text              = ((MovieClass *)[_movieArray objectAtIndex:indexPath.row]).main;
    cell.lbSeason.text            = [NSString stringWithFormat:@"%@",((MovieClass *)[_movieArray objectAtIndex:indexPath.row]).season];
    
    if ([[NSString stringWithFormat:@"%@",((MovieClass *)[_movieArray objectAtIndex:indexPath.row]).airing] isEqualToString:@"0"]) {
        cell.lbAir.text           = @"NO";
    } else {
        cell.lbAir.text           = @"YES";
    }
    
    return cell;
}

-(void) didDidFinishParsing:(NSArray *)data {
    
    _movieArray = data;
    [self.tableView reloadData];
}

@end
