//
//  NewsTableViewCell.h
//  Midterm
//
//  Created by Alfredo Alba on 10/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *lbNew;
@property (strong, nonatomic) IBOutlet UILabel *lbDescription;
@property (strong, nonatomic) IBOutlet UIImageView *imgFav;

@property (strong, nonatomic) NSString *myHtml;

@property (strong, nonatomic) NSString *myLink;

@end
