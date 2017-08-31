//
//  BookTableViewController.m
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "BookTableViewController.h"
#import "BookTableViewCell.h"
#import "BookClass.h"

#define mainQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0)

@interface BookTableViewController ()

@end

@implementation BookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _parsin             =   [[ParsingCoreData alloc] init];
    _bookArray          =   [[NSArray alloc] init];
    
    dispatch_sync(mainQueue, ^{
        
        _parsin.delegate    =   self;
        [_parsin startConnection:@"Book"];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    _parsin.delegate    =   self;
    [_parsin startConnection:@"Book"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_bookArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BookTableViewCell *cell = (BookTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.lbTitle.text          = ((BookClass *)[_bookArray objectAtIndex:indexPath.row]).title;
    cell.lbAuthor.text         = ((BookClass *)[_bookArray objectAtIndex:indexPath.row]).author;
    cell.lbPage.text           = [NSString stringWithFormat:@"%@",((BookClass *)[_bookArray objectAtIndex:indexPath.row]).page];
    cell.lbTPG.text            = [NSString stringWithFormat:@"%@",((BookClass *)[_bookArray objectAtIndex:indexPath.row]).TGO];
    
    return cell;
}


-(void) didDidFinishParsing:(NSArray *)data {
    
    _bookArray = data;
    [self.tableView reloadData];
}

@end
