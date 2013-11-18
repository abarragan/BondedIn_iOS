//
//  DetailViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/1/13.
//
//

#import <UIKit/UIKit.h>
#import "Requisition.h"
#import "ProfileViewController.h"
#import "Profile.h"
#import "Fit.h"


@interface DetailViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableViewCell *tableViewCell;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *rows;
@property (strong, nonatomic) NSString *typeDetail;
- (void)setDetailItems:(NSMutableArray*)newDetailItems andTypeDetail:(NSString*)typeDetail;


@end
