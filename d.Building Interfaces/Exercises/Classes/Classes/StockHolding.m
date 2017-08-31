//
//  StockHolding.m
//  Classes
//
//  Created by Alfredo Alba on 9/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "StockHolding.h"

@implementation StockHolding

@synthesize numberOfShares;
@synthesize currentSharePrice;
@synthesize purchaseSharePrice;
@synthesize stockName;


- (float)costInDollars {
    return purchaseSharePrice*numberOfShares;
}

- (float)valueInDollars {
    return currentSharePrice*numberOfShares;
}

- (void)setstockName:(NSString*)name {
    stockName = name;
}

- (void)setNumberOfShares:(int)number{
    numberOfShares = number;
}

- (void)setCurrentSharePrices:(float)number{
    currentSharePrice = number;
}

- (void)setPurchaseSharePrices:(float)number{
    purchaseSharePrice = number;
}

- (NSString*)getstockName {
    return stockName;
}

- (int)getNumberOfShares {
    return numberOfShares;
}

- (float)getCurrentSharePrices {
    return currentSharePrice;
}

- (float)getPurchaseSharePrices {
    return purchaseSharePrice;
}

@end
