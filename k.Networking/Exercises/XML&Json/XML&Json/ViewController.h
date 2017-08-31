//
//  ViewController.h
//  XML&Json
//
//  Created by Alfredo Alba on 10/19/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSXMLParserDelegate,UITableViewDelegate, UITableViewDataSource>

// Variables

@property (nonatomic) BOOL band;
- (IBAction)segSection:(UISegmentedControl *)sender;
// Table View
@property (strong, nonatomic) IBOutlet UITableView *tableView;

// XML
@property (strong, nonatomic) NSXMLParser       *parser;
@property (strong, nonatomic) NSString          *currentElement;
@property (strong, nonatomic) NSMutableArray    *songArray;
@property (strong, nonatomic) NSMutableArray    *artistArray;

// Json
- (void)dataRetreived:(NSData*) dataResponse;

@end

