//
//  ViewController.m
//  Protocols
//
//  Created by Alfredo Alba on 9/17/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "Operations.h"

@interface ViewController () <Operation>

@property (strong,nonatomic)Operations *op;
@property (strong,nonatomic)NSString *A;
@property (strong,nonatomic)NSString *B;
@property (strong,nonatomic)NSString *phrases;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didTheaddOperationFinished:(NSString *)result {
    self.phrases = [@"Add: " stringByAppendingString:result];
    self.LabelAdd.text = self.phrases;
}

-(void) didThesubtraccionOperationFinished:(NSString *)result {
    self.phrases = [@"Sustraction: " stringByAppendingString:result];
    self.LabelSubs.text = self.phrases;
}

-(void) didThemultiplicationOperationFinished:(NSString *)result {
    self.phrases = [@"Multiplication: " stringByAppendingString:result];
    self.LabelMul.text = self.phrases;
}

-(void) didThedivisionOperationFinished:(NSString *)result {
    self.phrases = [@"Division: " stringByAppendingString:result];
    self.LabelDiv.text = self.phrases;
}

- (IBAction)ButtonOperations:(UIButton *)sender {
    
    self.op = [[Operations alloc]init];

    self.op.delegate = self;
    
    
    if(self.TextA.text.length > 0 && self.TextB.text.length > 0) {
        
        self.A = self.TextA.text;
        self.B = self.TextB.text;
        
        [self.op addOperation:self.A andB: self.B];
        [self.op subtraccionOperation:self.A andB:self.B];
        [self.op multiplicationOperation:self.A andB:self.B];
        [self.op divisionOperation:self.A andB:self.B];
        
        
    } else {
        
        self.LabelAdd.text = @"Please";
        self.LabelSubs.text = @"Put Some";
        self.LabelMul.text = @"Info";
        self.LabelDiv.text = @"Above.";
        
    }
    
}
@end
