//
//  DetailViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/1/13.
//
//

#import "DetailViewController.h"
#import "ProfileTableViewCell.h"
#import "ProfileViewController.h"

#define favorites @"Favorites"
#define deleted @"Deleted"

@interface DetailViewController ()

- (void)configureView;
@end

@implementation DetailViewController

@synthesize tableView,rows;

#pragma mark - Managing the detail item

- (void)setDetailItems:(NSMutableArray*)newDetailItems andTypeDetail:(NSString*)typeDetail
{
    self.typeDetail=typeDetail;
    self.rows = newDetailItems;
    [self.tableView reloadData];
  
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Open the Profile View and load a  webView with the public profile LinkedIn
    if ([[segue identifier] isEqualToString:@"profileView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Fit *fit=  [self.rows objectAtIndex:indexPath.row];
        [[segue destinationViewController]setProfile:fit];
    } 
   }

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [self.rows count];
   
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    ProfileTableViewCell *cell = (ProfileTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   
    Fit *fit=  [self.rows objectAtIndex:indexPath.row];
    Profile * profile=fit.fitProfile;
    
    NSString *firstName = profile.firstName;
    NSString *lastName = profile.lastName;

    NSString *fullName=[NSString stringWithFormat:@"%@ %@.", firstName, lastName];

    [cell configureWithName:fullName city:profile.province company:profile.company imageUrl:profile.pictureUrl];
   
       
    //If is tab "Deleted" can't see the profile and select the row
    if([self.typeDetail isEqualToString:deleted]){
        cell.accessoryType=UITableViewCellAccessoryNone;
        [self.tableView setAllowsSelection:NO];
    } else {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [self.tableView setAllowsSelection:YES];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
