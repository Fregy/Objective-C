//
//  BookTableViewCell.h
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbAuthor;
@property (strong, nonatomic) IBOutlet UILabel *lbPage;
@property (strong, nonatomic) IBOutlet UILabel *lbTPG;

@end
