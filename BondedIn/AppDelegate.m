//
//  AppDelegate.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/1/13.
//
//

#import "AppDelegate.h"

#import "MasterViewController.h"
#import "Technology.h"
#import "Requisition.h"
#import "Location.h"
#import "Profile.h"
#import "Fit.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    MasterViewController *controller = (MasterViewController *)navigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    
    //----------------------------Data example ONLY TO TEST----------------------------------//
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"wasCreatedDataCore"]){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"wasCreatedDataCore"];
        
        //REQUISITIONS//
        NSManagedObjectContext *context = [self managedObjectContext];
        Requisition *requisition = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Requisition"
                                    inManagedObjectContext:context];
        
        requisition.name= @"Java Script Team Lead";
        requisition.briefDescription=@"DevSpark is seeking a Javascript Team Lead";
        
        //LOCATION//
        Location *location1 = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Location"
                               inManagedObjectContext:context];
        
        location1.province= @"Buenos Aires";
        location1.city = @"Tandil";
        
        Location *location2 = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Location"
                               inManagedObjectContext:context];
        
        location2.province= @"Cordoba";
        location2.city = @"Cordoba";
        
        Location *location3 = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Location"
                               inManagedObjectContext:context];
        
        location3.province= @"Mendoza";
        location3.city = @"San Rafael";
        
        Location *location4 = [NSEntityDescription
                               insertNewObjectForEntityForName:@"Location"
                               inManagedObjectContext:context];
        
        location4.province= @"Rio Negro";
        location4.city = @"Bariloche";
        
        
        //TECHNOLOGY//
        Technology *technology1 = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Technology"
                                  inManagedObjectContext:context];
        
        technology1.name= @"Java";
        
        Technology *technology2 = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Technology"
                                  inManagedObjectContext:context];
        
        technology2.name= @"Ruby";
        
        Technology *technology3 = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Technology"
                                  inManagedObjectContext:context];
        
        technology3.name= @"JS";
        
        Technology *technology4 = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Technology"
                                  inManagedObjectContext:context];
        
        technology4.name= @"iOS";
        
        Technology *technology5 = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Technology"
                                  inManagedObjectContext:context];
        
        technology5.name= @"Android";
        
        //PROFILE//
        Profile *profile1 = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Profile"
                             inManagedObjectContext:context];
        profile1.firstName=@"Esteban";
        profile1.lastName=@"Roodil";
        profile1.company= @"Devspark";
        profile1.province=@"Santa Fe";
        profile1.city=@"Rosario";
        profile1.phone=[NSNumber numberWithInt:1232656545];
        profile1.pictureUrl=@"http://m.c.lnkd.licdn.com/mpr/mprx/0_9r8JGG3OmpMl-Jvn9nr6G8t1ayOgKJqnNtNQG88aAMoS7gi9s9Kzuhqhh-YC1Ozsc1CFDFtcxJTw";
        profile1.publicProfileUrl=@"http://www.linkedin.com/in/estebanrodil";
        
        
        Profile *profile2 = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Profile"
                             inManagedObjectContext:context];
        profile2.firstName=@"Raul";
        profile2.lastName=@"Roodil";
        profile2.company= @"Devspark";
        profile2.province=@"Santa Fe";
        profile2.city=@"Rosario";
        profile2.phone=[NSNumber numberWithInt:1232656545];
        profile2.pictureUrl=@"http://m.c.lnkd.licdn.com/mpr/mprx/0_9r8JGG3OmpMl-Jvn9nr6G8t1ayOgKJqnNtNQG88aAMoS7gi9s9Kzuhqhh-YC1Ozsc1CFDFtcxJTw";
        profile2.publicProfileUrl=@"http://www.linkedin.com/in/estebanrodil";
        
        Profile *profile3 = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Profile"
                             inManagedObjectContext:context];
        profile3.firstName=@"Pedro";
        profile3.lastName=@"Roodil";
        profile3.company= @"Devspark";
        profile3.province=@"Santa Fe";
        profile3.city=@"Rosario";
        profile3.phone=[NSNumber numberWithInt:1232656545];
        profile3.pictureUrl=@"http://m.c.lnkd.licdn.com/mpr/mprx/0_9r8JGG3OmpMl-Jvn9nr6G8t1ayOgKJqnNtNQG88aAMoS7gi9s9Kzuhqhh-YC1Ozsc1CFDFtcxJTw";
        profile3.publicProfileUrl=@"http://www.linkedin.com/in/estebanrodil";
        
        //FIT//
        Fit *fit1 = [NSEntityDescription
                     insertNewObjectForEntityForName:@"Fit"
                     inManagedObjectContext:context];
        
        fit1.status= @"Favorites";
        fit1.fitProfile=profile1;
        
        Fit *fit2 = [NSEntityDescription
                     insertNewObjectForEntityForName:@"Fit"
                     inManagedObjectContext:context];
        
        fit2.status= @"Deleted";
        fit2.fitProfile=profile2;
        
        Fit *fit3 = [NSEntityDescription
                     insertNewObjectForEntityForName:@"Fit"
                     inManagedObjectContext:context];
        
        fit3.status= @"New Search";
        fit3.fitProfile=profile3;
        
        ///RELATIONS//
        [requisition addRequisitionLocationObject:location1];
        [requisition addRequisitionLocationObject:location2];
        [requisition addRequisitionTechnologyObject: technology1];
        [requisition addRequisitionFitObject: fit1];
        [requisition addRequisitionFitObject: fit2];
        [requisition addRequisitionFitObject: fit3];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        ///------------------------------------------------------------------------//
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BondedIn" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BondedIn.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
