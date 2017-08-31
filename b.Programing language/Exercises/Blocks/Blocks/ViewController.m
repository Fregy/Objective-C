//
//  ViewController.m
//  Blocks
//
//  Created by Alfredo Alba on 9/17/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "classBlocks.h"

@interface ViewController ()

@property(strong,nonatomic)NSMutableArray *array;
@property(strong,nonatomic)classBlocks *cBlock;
@property NSInteger Number;
@property(strong,nonatomic)NSMutableDictionary *Dic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.array = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Button10:(UIButton *)sender {
    
    self.cBlock = [[classBlocks alloc] init];
    self.Number = [self.Text10.text integerValue];
    
    [self.cBlock methodWithParameters: self.Number withSucess:^{
    
        self.Label10.text = @"Integer is less than 10";
    
    } andFailure:^{
        
        self.Label10.text = @"Integer is bigger than 10";
    
    }];

}

- (IBAction)ButtonAdd:(UIButton *)sender {
    
    if (self.array == nil) {
        
        self.array = [[NSMutableArray alloc]init];
        
    }
    
    [self.array addObject: self.TextMap.text];
    
    self.TextMap.text = @"";
    self.TextViewDic.text = @"";
    
}

- (IBAction)ButtonClean:(UIButton *)sender {
    
    self.array = nil;
    
    self.TextMap.text = @"";
    self.LabelMap.text = @"";
    self.TextViewDic.text = @"";
    
}

- (IBAction)ButtonMap:(UIButton *)sender {
    
    self.Dic = [[NSMutableDictionary alloc] init];
    self.cBlock = [[classBlocks alloc] init];

    if (self.array != nil) {
        
        for (NSString* num in self.array) {
            
            NSString* r =[self.cBlock playingWithBlock:num and:^NSString *(NSString *num) {
                
                return [NSString stringWithFormat:@"%d",([num intValue]*2)];
                
            }];
            
            [self.Dic setValue: r forKeyPath:num];
            
            self.TextViewDic.text = [self.TextViewDic.text stringByAppendingFormat:@"%@:%@ | ", num, [self.Dic objectForKey:num]];
        }
        
        self.LabelMap.text = @"Mapped Data.";
        
        self.TextMap.text = @"";
        self.array = nil;
        
    } else {
        
        self.LabelMap.text = @"Please Add some number first.";
    
    }
    
}

@end
