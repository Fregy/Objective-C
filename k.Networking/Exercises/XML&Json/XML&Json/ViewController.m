//
//  ViewController.m
//  XML&Json
//
//  Created by Alfredo Alba on 10/19/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"

#define URLXML      [NSURL URLWithString: @"http://itunes.apple.com/us/rss/topalbums/limit=20/xml"]
#define URLJson     [NSURL URLWithString: @"http://itunes.apple.com/us/rss/topalbums/limit=20/json"]

#define mainQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface ViewController ()

@end

@implementation ViewController

@synthesize band;
@synthesize parser;
@synthesize currentElement;
@synthesize songArray;
@synthesize artistArray;

- (void)viewDidLoad {
    [super viewDidLoad];

    band = NO;
    
    currentElement  =   [[NSString alloc] init];
    songArray       =   [[NSMutableArray alloc] init];
    artistArray     =   [[NSMutableArray alloc] init];

    NSData *data = [[NSData alloc] initWithContentsOfURL:URLXML];
    
    band = NO;
    
    parser                  =   [[NSXMLParser alloc] initWithData:data];
    parser.delegate         =   self;
    [parser parse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// XML
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([currentElement isEqualToString:@"im:name"]) {
        [songArray addObject:string];
    } else if ([currentElement isEqualToString:@"im:artist"]){
        [artistArray addObject:string];
    }
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    currentElement  =   elementName;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    currentElement  =   @"";
}

// JSON
- (void)dataRetreived:(NSData*) dataResponse {
    
    NSError *error;

    // Get all the data
    NSDictionary* dictionary  =   [NSJSONSerialization JSONObjectWithData:dataResponse options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary* topDictionary = [[dictionary objectForKey:@"feed"] objectForKey:@"entry"];
    
    for (NSDictionary *d in topDictionary) {
        NSString* songTitle =   [[d objectForKey:@"title"]objectForKey:@"label"];
        [songArray addObject:songTitle];
        
        NSString* songArtist =   [[d objectForKey:@"im:artist"]objectForKey:@"label"];
        [artistArray addObject:songArtist];
    }
    
    [self.tableView reloadData];
}

// TABLE VIEW
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [songArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (band == NO) {
        cell.textLabel.text         =   [songArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text   =   [artistArray objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text         =   [songArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text   =   [artistArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}


- (IBAction)segSection:(UISegmentedControl *)sender {
    
    songArray       =   [[NSMutableArray alloc] init];
    artistArray     =   [[NSMutableArray alloc] init];
    
    if (sender.selectedSegmentIndex == 0) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:URLXML];
        
        band = NO;
        
        parser                  =   [[NSXMLParser alloc] initWithData:data];
        parser.delegate         =   self;
        [parser parse];
        
        [self.tableView reloadData];
        
    } else if (sender.selectedSegmentIndex == 1) {
        
        band = YES;
        
        dispatch_async(mainQueue, ^{
            
            NSData  *data   =   [NSData dataWithContentsOfURL:URLJson];
            
            [self performSelectorOnMainThread:@selector(dataRetreived:) withObject:data waitUntilDone:YES];

        });
    }
}
@end
