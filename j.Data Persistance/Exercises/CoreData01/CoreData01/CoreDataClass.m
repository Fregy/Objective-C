//
//  CoreDataClass.m
//  CoreData01
//
//  Created by Alfredo Alba on 10/28/15.
//  Copyright © 2015 Alfredo Alba. All rights reserved.
//

#import "CoreDataClass.h"
#import "AppDelegate.h"

@implementation CoreDataClass

- (BOOL)insertDataMovie:(NSString *)table allData:(NSDictionary *)data {
    
    // Get the reference to the application to access the DB (uses appdelegate.h)
    AppDelegate *appD   =   [[UIApplication sharedApplication] delegate];
    
    // Access to the data through the reference of the application
    NSManagedObjectContext  *context    =   [appD managedObjectContext];
    NSManagedObject         *newTable =   [NSEntityDescription insertNewObjectForEntityForName:table inManagedObjectContext:context];
    
    // Set the values entered
    [newTable setValue:[data objectForKey:@"title"] forKey:@"title"];
    [newTable setValue:[data objectForKey:@"main_character"] forKey:@"main_character"];
    [newTable setValue:[NSNumber numberWithInteger:[[data objectForKey:@"season"] integerValue] ] forKey:@"season"];
    
    if ([[data objectForKey:@"airing"] isEqualToString:@"YES"]) {
        [newTable setValue:[NSNumber numberWithBool:YES] forKey:@"airing"];
    } else {
        [newTable setValue:[NSNumber numberWithBool:NO] forKey:@"airing"];
    }

    // Create the error object in case if we have to use it
    NSError *error;
    error = nil;
    
    // Try for error
    if (![context save:&error]) {
        
        NSLog(@"\nInserting Error!!\n");
        return NO;
    }
    return YES;
}

- (BOOL)insertDataBook:(NSString *)table allData:(NSDictionary *)data {
    
    // Get the reference to the application to access the DB (uses appdelegate.h)
    AppDelegate *appD   =   [[UIApplication sharedApplication] delegate];
    
    // Access to the data through the reference of the application
    NSManagedObjectContext  *context    =   [appD managedObjectContext];
    NSManagedObject         *newTable   =   [NSEntityDescription insertNewObjectForEntityForName:table inManagedObjectContext:context];
    
    // Set the values entered
    [newTable setValue:[data objectForKey:@"title"] forKey:@"title"];
    [newTable setValue:[data objectForKey:@"author"] forKey:@"author"];
    [newTable setValue:[NSNumber numberWithInteger:[[data objectForKey:@"page"] integerValue] ] forKey:@"page"];
    [newTable setValue:[NSNumber numberWithFloat:[[data objectForKey:@"percentTGO"] floatValue] ] forKey:@"percentTGO"];
    
    // Create the error object in case if we have to use it
    NSError *error;
    error = nil;
    
    // Try for error
    if (![context save:&error]) {
        
        NSLog(@"\nInserting Error!!\n");
        return NO;
    }
    return YES;
}

- (void)getAllData:(NSString *)Table {

    AppDelegate                 *appD           =   [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext      *context        =   [appD managedObjectContext];
    
    NSFetchRequest              *request        =   [[NSFetchRequest alloc] initWithEntityName:Table];
    
    NSError                     *error;

    NSArray                     *results        =   [context executeFetchRequest:request error:&error];

    if (error != nil) {
        
        NSLog(@"\nGetting Error!!\n");
    }
    
    if ([Table isEqualToString:@"Movie"]) {
        [self.delegate didFinishGetAllDataMovie:results];
    } else if ([Table isEqualToString:@"Book"]) {
        [self.delegate didFinishGetAllDataBook:results];
    }
}

@end
