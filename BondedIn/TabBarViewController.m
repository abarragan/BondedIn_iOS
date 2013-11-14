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

#define tagFavorites 1
#define tagNewSearch 0
#define tagDeleted 2

#define favorites @"Favorites"
#define newSearch @"New Search"
#define deleted @"Deleted"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

@synthesize rowsFavorites, rowsNewSearch, rowsDeleted, toolbar;


- (void)setRequisitionItem:(Requisition*)newRequisitionItem
{
    if (_requisitionItem != newRequisitionItem) {
        _requisitionItem = newRequisitionItem;
              
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    int selectedTag=self.tabBar.selectedItem.tag;
    
    if(selectedTag==tagNewSearch){
        if (self.navigationItem.rightBarButtonItem == nil){
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.toolbar];
        }
        
    }
    else if(selectedTag==tagFavorites){
        if (self.navigationItem.rightBarButtonItem != nil){
            self.navigationItem.rightBarButtonItem.enabled=NO;
            self.navigationItem.rightBarButtonItem=nil;
        }
    }
    else if(selectedTag==tagDeleted){
        if (self.navigationItem.rightBarButtonItem != nil){
            self.navigationItem.rightBarButtonItem.enabled=NO;
            self.navigationItem.rightBarButtonItem=nil;
        }
        
    }
  
}

-(void)favoriteAction{
    
    NSError *error = nil;
    NSManagedObjectContext* context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    int idndex=[[self.childViewControllers objectAtIndex:0]urlIndex];
    Fit * fit= [self.rowsNewSearch objectAtIndex:index];
    fit.status=favorites;
    
    // Save the context.
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self configureTabs];
}

-(void)deleteAction{
    NSError *error = nil;
    NSManagedObjectContext* context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    int idndex=[[self.childViewControllers objectAtIndex:0]urlIndex];
    Fit * fit= [self.rowsNewSearch objectAtIndex:index];
    
    // Save the context.
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    fit.status=deleted;

  [self configureTabs];
    
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
    [[self.tabBar.items objectAtIndex:0 ]setTitle:newSearch];
    [[self.tabBar.items objectAtIndex:1 ]setTitle:favorites];
    [[self.tabBar.items objectAtIndex:2 ]setTitle:deleted];
    
    //Tag to identify de barItems
    [[self.tabBar.items objectAtIndex:0 ]setTag:tagNewSearch];
    [[self.tabBar.items objectAtIndex:1 ]setTag:tagFavorites];
    [[self.tabBar.items objectAtIndex:2 ]setTag:tagDeleted];
       
    //Toolbar to add Favorites/Deleted
    self.toolbar = [[UIToolbar alloc]
                          initWithFrame:CGRectMake(0, 0, 100, 45)];
    [self.toolbar setBarStyle: UIBarStyleDefault];
    
    // create an array for the buttons
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:5];
    
          
    // create a standard delete button with the trash icon
    //FAVORITE BUTTON
    UIBarButtonItem *favoriteButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                       target:self
                                       action:@selector(favoriteAction:)];
    favoriteButton.style = UIBarButtonItemStyleBordered;
    [buttons addObject:favoriteButton ];

    //DELETED BUTTON
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                     target:self
                                     action:@selector(deleteAction:)];
    deleteButton.style = UIBarButtonItemStyleBordered;
    [buttons addObject:deleteButton];
   
    // put the buttons in the toolbar and release them
    [self.toolbar setItems:buttons animated:NO];
   
    
    // place the toolbar into the navigation bar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.toolbar];
   
    [self configureTabs];
    
    //New search-->webViews with the profiles
    [[self.childViewControllers objectAtIndex:0]setDataSource: self];
    
    //Data of Favorites/Deleted
    [[self.childViewControllers objectAtIndex:1]setDetailItems:self.rowsFavorites andTypeDetail:favorites];
    [[self.childViewControllers objectAtIndex:2]setDetailItems:self.rowsDeleted andTypeDetail:deleted];
    
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
    [self configureView];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
