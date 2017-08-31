//
//  ParsingCoreData.h
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataClass.h"
#import "MovieClass.h"
#import "BookClass.h"

@protocol ParsingCoreDataDelegate <NSObject>

- (void) didDidFinishParsing:(NSArray *)data;

@end

@interface ParsingCoreData : NSObject <CoreDataClassDelegate>

@property (weak, nonatomic) id<ParsingCoreDataDelegate> delegate;

@property (strong, nonatomic) CoreDataClass             *coreD;
@property (strong, nonatomic) BookClass                 *myBook;
@property (strong, nonatomic) MovieClass                *myMovie;

- (void)startConnection:(NSString *)Table;
- (void)startParsingMovie:(NSArray *)array;
- (void)startParsingBook:(NSArray *)array;


@end
