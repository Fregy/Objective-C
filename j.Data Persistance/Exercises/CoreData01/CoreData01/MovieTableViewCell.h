//
//  MovieTableViewCell.h
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbMain;
@property (strong, nonatomic) IBOutlet UILabel *lbSeason;
@property (strong, nonatomic) IBOutlet UILabel *lbAir;


@end
