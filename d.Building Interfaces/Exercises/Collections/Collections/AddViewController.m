//
//  AddViewController.m
//  Collections
//
//  Created by Alfredo Alba on 10/2/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "AddViewController.h"
#import "CollectionViewController.h"
#import "Person.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize personArray;
@synthesize age;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Person.plist"];
    
    personArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    age = [[NSString alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)stIncDec:(UIStepper *)sender {
    
    double newValue = [sender value];
    age = [NSString stringWithFormat:@"%i", (int)newValue];
    self.lbAge.text = age;
}

- (IBAction)bSave:(UIButton *)sender {
    
    NSMutableDictionary *per = [[NSMutableDictionary alloc] init];
    Person* p = [[Person alloc] init];
    BOOL band = NO;
    
    if (![self.tfFirst.text isEqualToString:@""] && ![self.tfMiddle.text isEqualToString:@""] && ![self.tfLast.text isEqualToString:@""]) {
        
        p.sFirstName = self.tfFirst.text;
        p.sMiddleName = self.tfMiddle.text;
        p.sLastName = self.tfLast.text;
        p.nAge = [NSNumber numberWithInteger: [age integerValue]];
        
        [per setObject:p.sFirstName forKey:@"First"];
        [per setObject:p.sMiddleName forKey:@"Middle"];
        [per setObject:p.sLastName forKey:@"Last"];
        [per setObject:[NSString stringWithFormat:@"%@",p.nAge] forKey:@"Age"];
        
        if (personArray == nil) {
            personArray = [[NSMutableArray alloc] initWithObjects: per,nil];
        } else {
            for (NSMutableDictionary* p in personArray) {
                if ([[p objectForKey:@"First"] isEqualToString:self.tfFirst.text] && [[p objectForKey:@"Middle"] isEqualToString:self.tfMiddle.text] && [[p objectForKey:@"Last"] isEqualToString:self.tfLast.text] && [[p objectForKey:@"Age"] isEqualToString:self.lbAge.text]) {
                    band = YES;
                    break;
                }
            }
            if (band == NO) {
                [personArray addObject:per];
                self.lbInfo.text = @"Info Added.";
                
                self.tfFirst.text = @"";
                self.tfMiddle.text = @"";
                self.tfLast.text = @"";
                self.lbAge.text = @"0";
                age = @"0";
                
            } else {
                self.lbInfo.text = @"Try with other Info.";
            }
        }
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"Person.plist"];
        
        [personArray writeToFile:filePath atomically:YES];
        
    } else {
        self.lbInfo.text = @"Please Change the Info.";
    }
    
}

- (IBAction)bClear:(UIButton *)sender {
    
    self.tfFirst.text = @"";
    self.tfMiddle.text = @"";
    self.tfLast.text = @"";
    self.lbAge.text = @"0";
    age = @"0";
}
@end
