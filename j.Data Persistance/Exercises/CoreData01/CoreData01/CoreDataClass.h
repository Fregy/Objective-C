//
//  CoreDataClass.h
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CoreDataClassDelegate <NSObject>

- (void)didFinishGetAllDataMovie:(NSArray *)data;
- (void)didFinishGetAllDataBook:(NSArray *)data;

@end

@interface CoreDataClass : NSObject

@property (weak, nonatomic) id<CoreDataClassDelegate>           delegate;

- (void)getAllData:(NSString *)Table;

- (BOOL)insertDataMovie:(NSString *)table allData:(NSDictionary *)data;
- (BOOL)insertDataBook:(NSString *)table allData:(NSDictionary  *)data;

@end
