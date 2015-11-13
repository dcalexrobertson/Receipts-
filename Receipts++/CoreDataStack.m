//
//  CoreDataStack.m
//  Every.Do
//
//  Created by Alex on 2015-11-11.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack ()

@property (nonatomic) NSManagedObjectModel *mom;
@property (nonatomic) NSPersistentStoreCoordinator *psc;

@end

@implementation CoreDataStack

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL *momdUrl = [[NSBundle mainBundle] URLForResource:@"Receipts__" withExtension:@"momd"];
        // get momd url
        
        
        _mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:momdUrl];
        // init MOM (as a private property)
        
        
        
        _psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_mom];
        // init PSC (as a private property)
        
        
        NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *docPath = [documentsDirectories firstObject];
        
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"receipts.sqlite"];
        
        NSURL *dbUrl = [NSURL fileURLWithPath:dbPath];
        // get data store url NSSearchPathFor...
        
        NSError *pscError = nil;
        
        if (![_psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbUrl options:nil error:&pscError]) {
            
            NSLog(@"Error creating persistant store %@", pscError);
        }
        // add a NSSQLiteStoreType PS to the PSC
        
        
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        // init a MOC (as a public property)
        
        
        _context.persistentStoreCoordinator = _psc;
        // set the MOCs PSC
    }
    return self;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.context;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
