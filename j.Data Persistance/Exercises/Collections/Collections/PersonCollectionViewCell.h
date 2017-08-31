//
//  PersonCollectionViewCell.h
//  Collections
//
//  Created by Alfredo Alba on 10/2/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lFirst;
@property (strong, nonatomic) IBOutlet UILabel *lMiddle;
@property (strong, nonatomic) IBOutlet UILabel *lLast;
@property (strong, nonatomic) IBOutlet UILabel *lAge;


- (IBAction)sIncDec:(UIStepper *)sender;

@end
