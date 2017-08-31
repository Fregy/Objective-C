//
//  ViewController.m
//  Classes
//
//  Created by Alfredo Alba on 9/23/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "ViewController.h"
#import "StockHolding.h"
#import "Portfolio.h"

@interface ViewController ()

@property (strong,nonatomic)Portfolio* myPortfolio;
@property (strong,nonatomic)StockHolding* myStock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myPortfolio = [[Portfolio alloc]init];
    self.myPortfolio.myStockHoldings = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bAdd:(UIButton *)sender {
    
    NSString* name = self.tfName.text;
    NSString* nStock = self.tfNShares.text;
    NSString* purches = self.tfPurches.text;
    NSString* current = self.tfCurrent.text;
    
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [[NSCharacterSet alloc]init ];
    
    inStringSet = [NSCharacterSet characterSetWithCharactersInString:self.tfNShares.text];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    
    if (!valid){
        self.tfInfo.text = @"Please put numbers insted of characters on Shares";
    }
    
    inStringSet = [NSCharacterSet characterSetWithCharactersInString:self.tfPurches.text];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    
    if (!valid){
        self.tfInfo.text = @"Please put numbers insted of characters on Purches";
    }
    
    inStringSet = [NSCharacterSet characterSetWithCharactersInString:self.tfCurrent.text];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    
    if (!valid){
        self.tfInfo.text = @"Please put numbers insted of characters on Current";
    }
    
    if ([name isEqualToString:@""] || [nStock isEqualToString:@""] || [purches isEqualToString:@""] || [current isEqualToString:@""]) {
        self.tfInfo.text = @"Please put all the information";
        valid = NO;
    }
    
    if (valid) {
        
        if ([nStock floatValue] < 0 || [purches floatValue] < 0 || [current floatValue] < 0) {
            self.tfInfo.text = @"Please do not use negative numbers!";
        } else {
        
            if ([name isEqualToString:@""]) {
                self.tfInfo.text = @"Please put a name for your stock!";
            }
            self.myStock = [[StockHolding alloc] init];
    
            [self.myStock setStockName:name];
            [self.myStock setNumberOfShares:[nStock floatValue]];
            [self.myStock setPurchaseSharePrices:[purches floatValue]];
            [self.myStock setCurrentSharePrices:[current floatValue]];
    
            [self.myPortfolio.myStockHoldings addObject:self.myStock];
    
            self.tfName.text = @"";
            self.tfNShares.text = @"";
            self.tfPurches.text = @"";
            self.tfCurrent.text = @"";
            
            self.tfInfo.text = @"Information added in your stock.";
        }
    }
}

- (IBAction)bConsult:(UIButton *)sender {
    
    NSString* infoText = [[NSString alloc]init];
    
    infoText = [NSString stringWithFormat:@"There are %lu stocks which I own.", [self.myPortfolio.myStockHoldings count]];
    
    self.tfInfo.text = infoText;
}

- (IBAction)bStock:(UIButton *)sender {
    NSString* infoText = [[NSString alloc]init];
    
    for (StockHolding* stock in self.myPortfolio.myStockHoldings) {
        infoText = [infoText stringByAppendingFormat:@"The name of my stock: %@\nThe number of shares I own in my stock is %d\nI bought the stock for a price of %.2f and the current price is %.2f\nThe value of my stock now is %.2f\n\n", [stock getstockName], [stock getNumberOfShares], [stock getPurchaseSharePrices], [stock costInDollars], [stock valueInDollars]];
    }
    
    self.tfInfo.text = infoText;
}

- (IBAction)bOneStock:(UIButton *)sender {
    
    NSString* infoText = [[NSString alloc]init];
    
    for (StockHolding* stock in self.myPortfolio.myStockHoldings) {
        
        if ([[stock getstockName] isEqualToString:self.tfName.text]) {
            infoText = [infoText stringByAppendingFormat:@"Stock name: %@\nThe number of shares I own in my stock is %d\nI bought the stock for a price of %.2f and the current price is %.2f\nThe value of my stock now is %.2f\n\n", [stock getstockName], [stock getNumberOfShares], [stock getPurchaseSharePrices], [stock costInDollars], [stock valueInDollars]];
        }
        
    }
    
    if ([infoText isEqualToString:@""]) {
        self.tfInfo.text = @"You do not have that Stock.";
    } else {
        self.tfInfo.text = infoText;
    }
    
    
}
@end








