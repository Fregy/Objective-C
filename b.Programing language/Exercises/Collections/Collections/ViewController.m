//
//  ViewController.m
//  Collections
//
//  Created by Alfredo Alba on 9/16/15.
//  Copyright (c) 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "HTable.h"

@interface ViewController ()

@property (strong,nonatomic)NSMutableDictionary * Dic;
@property (strong,nonatomic)NSString * caracter;

@property (strong, nonatomic)NSString *caracter2;
@property (strong, nonatomic)NSString *ocurrence;
@property (strong, nonatomic)NSString *original;

@property (strong, nonatomic)NSMutableString * Texto;

@property (strong, nonatomic)NSString *oracion;
@property (strong, nonatomic)NSArray *palabra;

@property (strong, nonatomic)NSMutableArray *array1;
@property (strong, nonatomic)NSMutableArray *array2;
@property (strong, nonatomic)NSMutableArray *array3;

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

- (IBAction)PressNR:(UIButton *)sender {
    
    self.Dic = [[NSMutableDictionary alloc] init];
    self.caracter = [[NSString alloc]init];
    char c;
    id count = nil;
    
    for(int i =0 ;i < self.TextNR.text.length; i++) {
        
        c = [self.TextNR.text characterAtIndex:i];
        
        self.caracter = [NSString stringWithFormat:@"%c", c];
        
        count = [self.Dic valueForKey: self.caracter];
        
        if (!count) {
            [self.Dic setValue:@1 forKey:self.caracter];
        } else {
            [self.Dic setValue:@2 forKey:self.caracter];
        }
        
    }
    
    for(int i =0 ;i < self.TextNR.text.length; i++) {
        
        c = [self.TextNR.text characterAtIndex:i];
        self.caracter = [NSString stringWithFormat:@"%c", c];
        count = [self.Dic valueForKey:self.caracter];
        
        if ([count integerValue] == 1) {
            NSString * Texto = [@"The Non-Repeatable Letter is: " stringByAppendingFormat:@" %@", self.caracter];
            self.LabelNR.text = Texto;
            break;
        }
        
    }
}

- (IBAction)PressO:(UIButton *)sender {
    
    self.Dic = [[NSMutableDictionary alloc] init];
    
    char c;
    char c2;
    id count = nil;
    self.caracter = [[NSString alloc]init];
    self.caracter2 = [[NSString alloc]init];
    self.ocurrence = [[NSString alloc]init];
    self.original = [[self.TextO.text substringToIndex:self.TextO.text.length] uppercaseString];
    
    for(int i =0 ;i < self.original.length; i++) {
        
        c = [self.original characterAtIndex:i];
        
        self.caracter = [NSString stringWithFormat:@"%c", c];
        
        count = [self.Dic valueForKey: self.caracter];
        
        if (!count) {
            [self.Dic setValue:@1 forKey:self.caracter];
        } else {
            [self.Dic setValue:@2 forKey:self.caracter];
        }
        
    }
    
    for(int i =0 ;i < self.TextO.text.length; i++) {
        
        
        c = [self.original characterAtIndex:i];
        c2 = [self.TextO.text characterAtIndex:i];
        self.caracter = [NSString stringWithFormat:@"%c", c];
        self.caracter2 = [NSString stringWithFormat:@"%c", c2];
        count = [self.Dic valueForKey:self.caracter];
        
        if ([count integerValue] == 1) {
            if (self.ocurrence.length > 0) {
                self.ocurrence = [self.ocurrence stringByAppendingFormat:@" %@", self.caracter2];
            } else {
                self.ocurrence = self.caracter2;
            }
        }
        
    }
    
    self.LabelO.text = self.ocurrence;
    
}
- (IBAction)PressR:(UIButton *)sender {
    
    self.oracion = self.TextR.text;
    self.palabra = [self.oracion componentsSeparatedByString:@" "];
    self.Texto = [NSMutableString string];
    
    for (long i = [self.palabra count]-1; i>=0;i--){
        
        [self.Texto appendFormat:@"%@ ", [self.palabra objectAtIndex:i]];
    
    }
    
    self.LabelR.text = self.Texto;
    
}
- (IBAction)PressD:(UIButton *)sender {

    self.Dic = [[NSMutableDictionary alloc] init];
    self.array1 = [[NSMutableArray alloc] initWithCapacity:100];
    self.array2 = [[NSMutableArray alloc] initWithCapacity:100];
    self.array3 = [[NSMutableArray alloc] initWithCapacity:100];
    BOOL band = NO;
    
    for (int i = 0; i <= 100; i++){
        
        for (int j=2;j<=i/2;j++) {
            if((i%j)== 0) {
                band = NO;
                break;
            } else {
                band = YES;
            }
        }
        
        if (band || i == 1 || i == 2 || i == 3) {
            [self.array1 addObject:[NSNumber numberWithInt:i]];
            band = NO;
        }
        
    }
    
    [self.Dic setValue:self.array1 forKey:@"Prime"];
    
    for (int i = 0; i <= 100; i++){
        
        if (i%2 == 1) {
            
            [self.array2 addObject:[NSNumber numberWithInt:i]];
        }
        
    }
    
    [self.Dic setValue:self.array2 forKey:@"Even"];
    
    for (int i = 0; i <= 100; i++){
        
        
        if (i%2 == 0) {
            
            [self.array3 addObject:[NSNumber numberWithInt:i]];
        }
        
    }
    
    [self.Dic setValue:self.array3 forKey:@"Odd"];
    //Print Dictionary
    for(NSString *key in [self.Dic allKeys]) {
        NSLog(@"\n %@: %@\n", key,[self.Dic objectForKey:key]);
    }
    
    self.LabelD.text = @"Prime, Even and Odd Numbers: 1 to 100";
    
}
@end
