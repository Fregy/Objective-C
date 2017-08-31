//
//  StockHolding.h
//  Classes
//
//  Created by Alfredo Alba on 9/25/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockHolding : NSObject

@property (nonatomic)int numberOfShares;
@property (nonatomic)float currentSharePrice;
@property (nonatomic)float purchaseSharePrice;
@property (strong,nonatomic)NSString* stockName;


- (float)costInDollars;
- (float)valueInDollars;

- (void)setstockName:(NSString*)name;
- (void)setNumberOfShares:(int)number;
- (void)setCurrentSharePrices:(float)number;
- (void)setPurchaseSharePrices:(float)number;

- (NSString*)getstockName;
- (int)getNumberOfShares;
- (float)getCurrentSharePrices;
- (float)getPurchaseSharePrices;

@end
