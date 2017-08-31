//
//  SecondViewController.m
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "SecondViewController.h"
#import "WebViewController.h"
#import "UIImageView+AFNetworking.h"

#define URLJSON     [NSURL URLWithString: @"http://dev.fuzzproductions.com/MobileTest/test.json"]

#define mainQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0)

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _json               =   [[JSONClass alloc] init];
    _array              =   [[ArrayClass alloc] init];
    _myJSonArray        =   [[NSMutableArray alloc] init];
    
    dispatch_sync(mainQueue, ^{
        
        _json.delegate      =   self;
        [_json dataRetreived:URLJSON];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_myJSonArray count] == 0) {
        return 0;
    }
    
    if (_segSection.selectedSegmentIndex == 1) {
        _myJSonArray = [_array makeArrayWithElement:_myJSonArray withThis:@"text"];
        
    } else if (_segSection.selectedSegmentIndex == 2) {
        _myJSonArray = [_array makeArrayWithElement:_myJSonArray withThis:@"image"];
    }
    
    return [_myJSonArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (_segSection.selectedSegmentIndex == 0) {
        
        cell.textLabel.text         =   ((FuzzClass *)[_myJSonArray objectAtIndex:indexPath.row]).myData;
        cell.detailTextLabel.text   =   ((FuzzClass *)[_myJSonArray objectAtIndex:indexPath.row]).myDate;
        
        if ([((FuzzClass *)[_myJSonArray objectAtIndex:indexPath.row]).myType isEqualToString:@"image"]) {
            NSURL *url = [NSURL URLWithString:((FuzzClass *)[_myJSonArray objectAtIndex:indexPath.row]).myData];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            UIImage *placeholderImage = [UIImage imageNamed:@"noImage"];
            
            __weak UITableViewCell *weakCell = cell;
            
            [cell.imageView setImageWithURLRequest:request
                                  placeholderImage:placeholderImage
                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                               
                                               weakCell.imageView.image = image;
                                               [weakCell setNeedsLayout];
                                               
                                           } failure:nil];
        }
        
    } else if (_segSection.selectedSegmentIndex == 1) {
        
        cell.textLabel.text         =   ((FuzzClass *)[_myJSonArray objectAtIndex:indexPath.row]).myData;
        cell.detailTextLabel.text   =   ((FuzzClass *)[_myJSonArray objectAtIndex:indexPath.row]).myDate;
        cell.imageView.image        =   [UIImage imageNamed:@""];
        
    } else if (_segSection.selectedSegmentIndex == 2) {
        cell.textLabel.text         =   @"";
        cell.detailTextLabel.text   =   @"";
        
        NSURL *url = [NSURL URLWithString:((FuzzClass *)[_myJSonArray objectAtIndex:indexPath.row]).myData];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        UIImage *placeholderImage = [UIImage imageNamed:@"noImage"];
        
        __weak UITableViewCell *weakCell = cell;
        
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:placeholderImage
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           
                                           weakCell.imageView.image = image;
                                           [weakCell setNeedsLayout];
                                           
                                       } failure:nil];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    WebViewController *vc   = (WebViewController *)segue.destinationViewController;
    
    vc.myLink           = @"https://www.raywenderlich.com";
    vc.bandR            = YES;
}

- (IBAction)segSection:(UISegmentedControl *)sender {
    
    dispatch_sync(mainQueue, ^{
        
        _json.delegate      =   self;
        [_json dataRetreived:URLJSON];
        
    });
    
    [self.tableView reloadData];
}

- (void)didFinishJSon:(NSArray *)data {
    
    _myJSonArray    =   data;
    _myJSonArray    =   [_array clearArrayElement:_myJSonArray];
    [self.tableView reloadData];
}

@end
