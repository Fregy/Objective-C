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

- (BOOL)insertDataTeam:(NSString *)table allData:(NSDictionary *)data idNumber:(NSInteger)myID {
    
    // Get the reference to the application to access the DB (uses appdelegate.h)
    AppDelegate *appD   =   [[UIApplication sharedApplication] delegate];
    
    // Access to the data through the reference of the application
    NSManagedObjectContext  *context    =   [appD managedObjectContext];
    
    NSEntityDescription *entityPerson = [NSEntityDescription entityForName:table inManagedObjectContext:context];
    NSManagedObject *newTeam = [[NSManagedObject alloc] initWithEntity:entityPerson insertIntoManagedObjectContext:context];
    
    // Set the values entered
    
    [newTeam setValue:[data objectForKey:@"name"] forKey:@"name"];
    [newTeam setValue:[data objectForKey:@"color"] forKey:@"color"];
    [newTeam setValue:[NSNumber numberWithInteger:myID] forKey:@"id"];
    
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

- (BOOL)insertDataPlayer:(NSString *)table allData:(NSDictionary *)data idNumber:(NSInteger)myID {
    
    // Get the reference to the application to access the DB (uses appdelegate.h)
    AppDelegate *appD   =   [[UIApplication sharedApplication] delegate];
    
    // Access to the data through the reference of the application
    NSManagedObjectContext  *context    =   [appD managedObjectContext];
    
    NSEntityDescription *entityPerson = [NSEntityDescription entityForName:table inManagedObjectContext:context];
    NSManagedObject *newPlayer = [[NSManagedObject alloc] initWithEntity:entityPerson insertIntoManagedObjectContext:context];
    
    // Set the values entered
    [newPlayer setValue:[data objectForKey:@"name"] forKey:@"name"];
    [newPlayer setValue:[NSNumber numberWithInt:[[data objectForKey:@"age"] intValue]] forKey:@"age"];
    [newPlayer setValue:[NSNumber numberWithInteger:myID] forKey:@"team"];
    
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

- (BOOL)insertDataPlayerModify:(NSString *)table allData:(NSDictionary *)data idNumber:(NSInteger)myID withName:(NSString *)name {
    
    // Get the reference to the application to access the DB (uses appdelegate.h)
    AppDelegate *appD   =   [[UIApplication sharedApplication] delegate];
    
    // Access to the data through the reference of the application
    NSManagedObjectContext  *context    =   [appD managedObjectContext];
    
    NSFetchRequest              *request        =   [[NSFetchRequest alloc] initWithEntityName:@"Player"];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name == %@", name];
    
    request.predicate = pred;
    
    NSError                     *error;
    
    NSArray                     *results        =   [context executeFetchRequest:request error:&error];
    
    NSManagedObject* newPlayer = [results objectAtIndex:0];
    
    // Set the values entered
    [newPlayer setValue:[data objectForKey:@"name"] forKey:@"name"];
    [newPlayer setValue:[NSNumber numberWithInt:[[data objectForKey:@"age"] intValue]] forKey:@"age"];
    [newPlayer setValue:[NSNumber numberWithInteger:myID] forKey:@"team"];
    
    // Create the error object in case if we have to use it
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
    
    [self.delegate didFinishGetAllDataTeam:results];
}

- (void)getPlayers:(NSInteger)myID {
 
    AppDelegate                 *appD           =   [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext      *context        =   [appD managedObjectContext];
    
    NSFetchRequest              *request        =   [[NSFetchRequest alloc] initWithEntityName:@"Player"];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ANY team == %@", [NSNumber numberWithInteger:myID]];
    
    request.predicate = pred;
    
    NSError                     *error;
    
    NSArray                     *results        =   [context executeFetchRequest:request error:&error];
    
    if (error != nil) {
        
        NSLog(@"\nGetting Error!!\n");
    }
    
    [self.delegate didFinishGetAllDataPlayer:results];
}

- (BOOL)deleteEntity:(NSString *)table withName:(NSString *)name {
    
    AppDelegate                 *appD           =   [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext      *context        =   [appD managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name == %@", name];
    
    request.predicate = pred;
    
    [request setEntity:[NSEntityDescription entityForName:table inManagedObjectContext:context]];
    [request setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    //error handling goes here
    for (NSManagedObject *result in results) {
        [context deleteObject:result];
    }
    
    if (![context save:&error]) {
        
        NSLog(@"\nDeleting Error!!\n");
        return NO;
    }
    return YES;
}

- (BOOL)deleteAttribute:(NSString *)table withID:(NSInteger)myID {
    
    AppDelegate                 *appD           =   [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext      *context        =   [appD managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"ANY team == %@", [NSNumber numberWithInteger:myID]];
    
    request.predicate = pred;
    
    [request setEntity:[NSEntityDescription entityForName:table inManagedObjectContext:context]];
    [request setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    //error handling goes here
    for (NSManagedObject *result in results) {
        [context deleteObject:result];
    }
    
    if (![context save:&error]) {
        
        NSLog(@"\nDeleting Error!!\n");
        return NO;
    }
    return YES;
}

- (BOOL)deleteAttributePlayers:(NSString *)table withName:(NSString *)name {
    
    AppDelegate                 *appD           =   [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext      *context        =   [appD managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name == %@", name];
    
    request.predicate = pred;
    
    [request setEntity:[NSEntityDescription entityForName:table inManagedObjectContext:context]];
    [request setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    //error handling goes here
    for (NSManagedObject *result in results) {
        [context deleteObject:result];
    }
    
    if (![context save:&error]) {
        
        NSLog(@"\nDeleting Error!!\n");
        return NO;
    }
    return YES;
}

@end
