//
//  CollectionViewController.m
//  Collections
//
//  Created by Alfredo Alba on 10/3/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "CollectionViewController.h"
#import "PersonCollectionViewCell.h"
#import "DetailsViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

@synthesize personArray;
@synthesize band;
@synthesize per;
@synthesize p;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Person.plist"];
    
    personArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    p = [[Person alloc] init];
    
    if (personArray == nil) {
        
        p.sFirstName = @"Carlos";
        p.sMiddleName = @"Alfredo";
        p.sLastName = @"Alba";
        p.nAge = [NSNumber numberWithInteger: [@"26" integerValue]];
        
        per = [[NSMutableDictionary alloc] init];
        
        [per setObject:p.sFirstName forKey:@"First"];
        [per setObject:p.sMiddleName  forKey:@"Middle"];
        [per setObject:p.sLastName forKey:@"Last"];
        [per setObject:[NSString stringWithFormat:@"%@",p.nAge] forKey:@"Age"];
        
        personArray = [NSMutableArray arrayWithObjects: per,nil];
    }
    
    band = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Person.plist"];
    
    personArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return personArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonCollectionViewCell *cell = (PersonCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSMutableDictionary *auxP = [personArray objectAtIndex:(indexPath.section * 2 + indexPath.row)];
    
    p.sFirstName = [auxP objectForKey:@"First"];
    p.sMiddleName = [auxP objectForKey:@"Middle"];
    p.sLastName = [auxP objectForKey:@"Last"];
    p.nAge = [NSNumber numberWithInteger: [[auxP objectForKey:@"Age"] integerValue]];
    
    cell.lFirst.text = p.sFirstName;
    cell.lMiddle.text = p.sMiddleName;
    cell.lLast.text = p.sLastName;
    cell.lAge.text = [NSString stringWithFormat:@"%@",p.nAge];
    
    if (band == YES) {
        cell.backgroundColor = [UIColor blackColor];
    } else {
        cell.backgroundColor = [UIColor redColor];
    }
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (band == NO) {
    [self.collectionView performBatchUpdates:^{
        [personArray removeObjectAtIndex:(indexPath.section * 2 + indexPath.row)];
        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"Person.plist"];
        
        [personArray writeToFile:filePath atomically:YES];
        
    } completion:^(BOOL finished) {
        
    }];
    
        [self.collectionView reloadData];
    }
}

- (IBAction)bLess:(UIButton *)sender {
    
    if (band == YES) {
        band = NO;
        [self.collectionView reloadData];
    } else {
        band = YES;
        [self.collectionView reloadData];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
    if ([segue.identifier isEqualToString:@"showDetails"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        DetailsViewController *destViewController = segue.destinationViewController;
        
        NSMutableDictionary *auxP = [personArray objectAtIndex:(indexPath.section * 2 + indexPath.row)];
        
        p.sFirstName = [auxP objectForKey:@"First"];
        p.sMiddleName = [auxP objectForKey:@"Middle"];
        p.sLastName = [auxP objectForKey:@"Last"];
        p.nAge = [NSNumber numberWithInteger: [[auxP objectForKey:@"Age"] integerValue]];
        
        destViewController.fir = p.sFirstName;
        destViewController.mid = p.sMiddleName;
        destViewController.las = p.sLastName;
        destViewController.ag = [NSString stringWithFormat:@"%@",p.nAge];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {

    return band;
}

@end


