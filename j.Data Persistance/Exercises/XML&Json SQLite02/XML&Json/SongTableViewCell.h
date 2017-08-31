//
//  SongTableViewCell.h
//  XML&Json
//
//  Created by Alfredo Alba on 10/22/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lbSong;
@property (strong, nonatomic) IBOutlet UILabel *lbAlbum;
@property (strong, nonatomic) IBOutlet UILabel *lbGenre;

@property (strong, nonatomic) IBOutlet UIImageView *imgFav;

@end
