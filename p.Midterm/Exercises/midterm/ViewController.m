//
//  ViewController.m
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "NewsTableViewCell.h"
#import "WebViewController.h"
#import "AFNetworking.h"

#define URLXML     [NSURL URLWithString: @"http://news.google.com/news?cf=all&ned=us&hl=en&topic=h&output=rss"]

#define mainQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bandC              =   NO;
    _bandSection        =   YES;
    
    _myXMLArray         =   [[NSMutableArray alloc] init];
    
    _sql                =   [[SQLiteClass alloc] init];
    _xml                =   [[XMLClass alloc] init];
    _news               =   [[NewsClass alloc] init];
    
    NSString* docsDirectory;
    NSArray* dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDirectory       =   [dirPaths objectAtIndex:0];
    _databasePath       =   [[NSString alloc] initWithString:[docsDirectory stringByAppendingPathComponent:@"news.db"]];
    
    NSDictionary * dic  =   [NSDictionary dictionaryWithObjectsAndKeys:
                              @"TEXT", @"NEW",
                              @"TEXT", @"LINK",
                              @"TEXT", @"HTML",
                              @"TEXT", @"FAVORITE",
                              @"TEXT", @"DESCRIPTION", nil];
    
    [_sql CreateTableDB:_databasePath dataBase:newsDB table:@"NEWS" atrib:dic];
    
    _reachability = [GCNetworkReachability reachabilityForInternetConnection];
    
    if ([_reachability isReachable])
    {
        _bandC          =   YES;
        
        dispatch_sync(mainQueue, ^{
            
            _myXMLArray = [_xml getXMLParsing:URLXML];
        });
    } else {
        if ([_sql NumberOfTable:_databasePath dataBase:newsDB table:@"NEWS" element:@"new"] > 0) {
            for (int i = 0; i < [_sql NumberOfTable:_databasePath dataBase:newsDB table:@"NEWS" element:@"new"]; i++) {
                
                _news.myNews        = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"new"] objectAtIndex:i];
                _news.myLink        = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"link"] objectAtIndex:i];
                _news.myHtml        = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"html"] objectAtIndex:i];
                _news.myDescription = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"description"] objectAtIndex:i];
                
                [_myXMLArray addObject:_news];
                
                _news                   =   [[NewsClass alloc] init];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_bandC) {
        return [_myXMLArray count];
    } else {
        return [_sql NumberOfTable:_databasePath dataBase:newsDB table:@"NEWS" element:@"new"];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsTableViewCell *cell = (NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    

    if (_bandSection) {
        
        if (_bandC) {
            cell.lbNew.text                      = ((NewsClass *)[_myXMLArray objectAtIndex:indexPath.row]).myNews;
            cell.lbDescription.text              = ((NewsClass *)[_myXMLArray objectAtIndex:indexPath.row]).myDescription;
            cell.imgFav.image                    = [UIImage imageNamed:@"N"];
            
            
            UITapGestureRecognizer *tapped       = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myFunction:)];
            cell.imgFav.tag                      = indexPath.row;
            
            cell.imgFav.userInteractionEnabled   = YES;
            tapped.numberOfTapsRequired          = 1;
            
            [cell.imgFav addGestureRecognizer:tapped];
            
            if ([_sql FindElementFromDBValue:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"new" atrib2:@"new" value:cell.lbNew.text]) {
                
                cell.imgFav.image            = [UIImage imageNamed:@"fav"];
                cell.imgFav.userInteractionEnabled   = NO;
            }
            
            return cell;
        }
    }
    if (_bandSection == NO || _bandC == NO) {
        cell.lbNew.text                      = ((NewsClass *)[_myXMLArray objectAtIndex:indexPath.row]).myNews;
        cell.lbDescription.text              = ((NewsClass *)[_myXMLArray objectAtIndex:indexPath.row]).myDescription;
        cell.imgFav.image                    = [UIImage imageNamed:@"fav"];
        
        cell.imgFav.userInteractionEnabled   = NO;
    }
    
    return cell;
}
// Delete
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsTableViewCell *cell = (NewsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([_sql DeleteElementFromDB:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"new" delete:cell.lbNew.text]) {
            
            [_myXMLArray removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }    
}
// MyFunctions
- (void) myFunction:(id) sender {
    
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    int currentRow = (int)gesture.view.tag;
    
    NewsTableViewCell * currentCell = (NewsTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentRow inSection:0]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          ((NewsClass *)[_myXMLArray objectAtIndex:currentRow]).myNews, @"new",
                          ((NewsClass *)[_myXMLArray objectAtIndex:currentRow]).myLink, @"link",
                          @"deep", @"html",
                          ((NewsClass *)[_myXMLArray objectAtIndex:currentRow]).myDescription, @"description",
                          @"fav", @"favorite", nil];
    
    [_sql InsertElementsDB:_databasePath dataBase:newsDB table:@"NEWS" atrib:dict];
    
    if ([_sql ModifyElementWithValueFromDB:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"html" value:((NewsClass *)[_myXMLArray objectAtIndex:currentRow]).myHtml atrib2:@"new" value:currentCell.lbNew.text]) {
        
        currentCell.imgFav.image  = [UIImage imageNamed:@"fav"];
        currentCell.imgFav.userInteractionEnabled   = NO;
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Update"
                                      message:@"Element Updated"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
// Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath  = [self.tableView indexPathForSelectedRow];
    
    WebViewController *vc   = (WebViewController *)segue.destinationViewController;
    
    _reachability = [GCNetworkReachability reachabilityForInternetConnection];
    
    if ([_reachability isReachable]) {
        vc.myLink           = ((NewsClass *)[_myXMLArray objectAtIndex:indexPath.row]).myLink;
        vc.bandR            = [_reachability isReachable];
    } else {
        vc.myHtml           = ((NewsClass *)[_myXMLArray objectAtIndex:indexPath.row]).myHtml;
        vc.bandR            = [_reachability isReachable];
    }
}

// Controlls
- (IBAction)segSection:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        _bandSection = YES;
        
        _reachability = [GCNetworkReachability reachabilityForInternetConnection];
        
        if ([_reachability isReachable]) {
                
            _bandC          =   YES;

            dispatch_sync(mainQueue, ^{
                
                _myXMLArray         = [_xml getXMLParsing:URLXML];
            
            });
        } else {
            if ([_sql NumberOfTable:_databasePath dataBase:newsDB table:@"NEWS" element:@"new"] > 0) {
                for (int i = 0; i < [_sql NumberOfTable:_databasePath dataBase:newsDB table:@"NEWS" element:@"new"]; i++) {
                    
                    _news.myNews        = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"new"] objectAtIndex:i];
                    _news.myLink        = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"link"] objectAtIndex:i];
                    _news.myHtml        = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"html"] objectAtIndex:i];
                    _news.myDescription = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"description"] objectAtIndex:i];
                    
                    [_myXMLArray addObject:_news];
                    
                    _news                   =   [[NewsClass alloc] init];
                }
            }
        }
    } else if (sender.selectedSegmentIndex == 1) {
        _bandSection = NO;
        
        _news                   =   [[NewsClass alloc] init];
        
        [_myXMLArray removeAllObjects];
        
        if ([_sql NumberOfTable:_databasePath dataBase:newsDB table:@"NEWS" element:@"new"] > 0) {
            for (int i = 0; i < [_sql NumberOfTable:_databasePath dataBase:newsDB table:@"NEWS" element:@"new"]; i++) {
                
                _news.myNews        = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"new"] objectAtIndex:i];
                _news.myLink        = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"link"] objectAtIndex:i];
                _news.myHtml        = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"html"] objectAtIndex:i];
                _news.myDescription = [[_sql GetElementFromDBArray:_databasePath dataBase:newsDB table:@"NEWS" atrib:@"description"] objectAtIndex:i];
                
                [_myXMLArray addObject:_news];
                
                _news                   =   [[NewsClass alloc] init];
            }
        }
    }
    
    _reachability = [GCNetworkReachability reachabilityForInternetConnection];
    
    _bandC = [_reachability isReachable];
    
    [self.tableView reloadData];
}
@end
