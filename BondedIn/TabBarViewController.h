//
//  TabBarViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/8/13.
//
//

#import <UIKit/UIKit.h>
#import "Requisition.h"
#import "WebCollectionViewController.h"

@interface TabBarViewController : UITabBarController <WebCollectionViewControllerDataSource>

@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) Requisition* requisitionItem;
@property (strong, nonatomic) NSMutableArray *rowsFavorites;
@property (strong, nonatomic) NSMutableArray *rowsNewSearch;
@property (strong, nonatomic) NSMutableArray *rowsDeleted;
@property (strong, nonatomic) UIToolbar* toolbar;

@end
