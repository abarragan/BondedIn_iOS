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
    
    //----------------------------Data example----------------------------------//
    BOOL wasCreatedDataCore = [[NSUserDefaults standardUserDefaults] boolForKey:@"wasCreatedDataCore"];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"wasCreatedDataCore"]){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"wasCreatedDataCore"];
        
        //REQUISITIONS//
        NSManagedObjectContext *context = [self managedObjectContext];
        Requisition *requisition = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Requisition"
                                    inManagedObjectContext:context];
        
        requisition.name= @"Java Script Team Lead";
        requisition.briefDescription=@"TDevSpark is seeking a self-motivated and proactive Javascript Team Lead to lead a new team to work with a cloud-based education company based in New York...";
        requisition = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Requisition"
                       inManagedObjectContext:context];
        
        
        //LOCATION//
        Location*location = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Location"
                             inManagedObjectContext:context];
        location.name=@"Buenos Aires";
        location = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Location"
                    inManagedObjectContext:context];
        location.name=@"Cordoba";
        location = [NSEntityDescription
                    insertNewObjectForEntityForName:@"Location"
                    inManagedObjectContext:context];
        location.name=@"Entre rios";

        
        //TECHNOLOGY//
        Technology *technology = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Technology"
                                  inManagedObjectContext:context];
        technology.name=@"Java";
        technology = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Technology"
                      inManagedObjectContext:context];
        technology.name=@"Java Script";
        technology = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Technology"
                      inManagedObjectContext:context];
        technology.name=@"Android";
        
        //PROFILE//
        Profile *profile = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Profile"
                            inManagedObjectContext:context];
        profile.firstName=@"Esteban";
        profile.lastName=@"Roodil";
        profile.company= @"Devspark";
        profile.province=@"Santa Fe";
        profile.city=@"Rosario";
        profile.phone=[NSNumber numberWithInt:1232656545];
        profile.pictureUrl=@"http://m.c.lnkd.licdn.com/mpr/mprx/0_9r8JGG3OmpMl-Jvn9nr6G8t1ayOgKJqnNtNQG88aAMoS7gi9s9Kzuhqhh-YC1Ozsc1CFDFtcxJTw";
        profile.publicProfileUrl=@"http://www.linkedin.com/in/estebanrodil";
        
        //RELATIONS//
        location.locationRequisition=requisition;
        technology.technologyRequisition=requisition;
        requisition.requisitionLocation=location;
        requisition.requisitionTechnology=technology;
        
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        ///----------------------------SELECT----------------------------------//
        // Test listing all FailedBankInfos from the store
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Requisitions"
                                                  inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        /*  NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
         for (Requisition *requisition in fetchedObjects) {
         NSLog(@"Name: %@", requisition.name);
         Location *location = requisition.requisitionLocation;
         NSLog(@"Name Location: %@", location.name);
         Technology *technology = requisition.requisitionTechnology;
         NSLog(@"Name Technology: %@", technology.name);
         }*/
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
