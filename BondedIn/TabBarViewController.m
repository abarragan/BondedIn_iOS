//
//  TabBarViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/8/13.
//
//

#import "TabBarViewController.h"
#import "DetailViewController.h"
#import "Fit.h"
#import "AppDelegate.h"

#define tagFavorites 0
#define tagNewSearch 1
#define tagDeleted 2

#define favorites @"Favorites"
#define newSearch @"New Search"
#define deleted @"Deleted"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

@synthesize rowsFavorites, rowsNewSearch, rowsDeleted;


- (void)setRequisitionItem:(Requisition*)newRequisitionItem
{
    if (_requisitionItem != newRequisitionItem) {
        _requisitionItem = newRequisitionItem;
              
    }
}

-(void) webCollectionViewController: (WebCollectionViewController*) webViewCollectionController buttonPressedIsLeft: (BOOL)isLeft{
    
    
    NSError *error = nil;
    NSManagedObjectContext* context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    int index=[[self.childViewControllers objectAtIndex: tagNewSearch]urlIndex];
    Fit * fit= [self.rowsNewSearch objectAtIndex:index];
    
    //add to favorite
    if(isLeft){
       
        fit.status=favorites;
        
        // Save the context.
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [self configureTabs];
        //Data of Favorites
        [[self.childViewControllers objectAtIndex:tagFavorites]setDetailItems:self.rowsFavorites andTypeDetail:favorites];
    }
    //add to deleted
    else{
        fit.status=deleted;
        
        // Save the context.
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [self configureTabs];
        //Data of deleted
        [[self.childViewControllers objectAtIndex:tagDeleted]setDetailItems:self.rowsDeleted andTypeDetail:deleted];
    }

}

- (void)configureTabs{
    
    // Update the user interface for the detail item.
    if (_requisitionItem) {
        
        NSSet *profilesSet= _requisitionItem.requisitionFit;
        NSMutableArray *fits= [NSMutableArray arrayWithArray:[profilesSet allObjects]];
        
        self.rowsFavorites = [NSMutableArray array];
        self.rowsDeleted=[NSMutableArray array];
        self.rowsNewSearch=[NSMutableArray array];
        
        for (Fit *fitResult in fits){
            Fit *fit = fitResult;
            
            if([fit.status isEqualToString:favorites]){
                [self.rowsFavorites addObject:fit];
            }
            else if([fit.status isEqualToString:newSearch]){
                [self.rowsNewSearch addObject:fit];
            }
            else if([fit.status isEqualToString:deleted]){
                [self.rowsDeleted addObject:fit];
            }
        }
     }
    
}
- (void)configureView
{
     //BarItems titles
    [[self.tabBar.items objectAtIndex:tagNewSearch ]setTitle:newSearch];
    [[self.tabBar.items objectAtIndex:tagFavorites]setTitle:favorites];
    [[self.tabBar.items objectAtIndex:tagDeleted ]setTitle:deleted];
    [self configureTabs];
    
    //New search-->webViews with the profiles
    [[self.childViewControllers objectAtIndex:tagNewSearch]setDataSource: self];
    [[self.childViewControllers objectAtIndex:tagNewSearch]setDelegate:self];
   
    //Data of Favorites
    [[self.childViewControllers objectAtIndex:tagFavorites]setDetailItems:self.rowsFavorites andTypeDetail:favorites];
    
    //Data of Deleted
    [[self.childViewControllers objectAtIndex:tagDeleted]setDetailItems:self.rowsDeleted andTypeDetail:deleted];
    
}

-(int) urlCountInWebCollectionViewController: (WebCollectionViewController*) webViewCollectionController{
   return [self.rowsNewSearch count];
}
-(NSString*) webCollectionViewController: (WebCollectionViewController*) webViewCollectionController urlForIndex: (int) index{
   
    Fit *fit=  [self.rowsNewSearch objectAtIndex:index];
    return fit.fitProfile.publicProfileUrl;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setViewControllers: [NSArray arrayWithObjects: [self.childViewControllers objectAtIndex:1], [self.childViewControllers objectAtIndex:0], [self.childViewControllers objectAtIndex:2], nil]];
    [self configureView];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
