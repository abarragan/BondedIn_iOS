//
//  DetailViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/1/13.
//
//

#import "DetailViewController.h"
#import "ProfileTableViewCell.h"

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
    /*
    if([self.typeDetail isEqualToString:deleted]){
        [self.tableView setAllowsSelection:NO];
    } else {
        [self.tableView setAllowsSelection:YES];
    }
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Open the Profile View and load a  webView with the public profile LinkedIn
    if ([[segue identifier] isEqualToString:@"profileView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Fit *fit=  [self.rows objectAtIndex:indexPath.row];
        [[segue destinationViewController] setProfile:fit];
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
   
    /*
    
    //Style text -detailText
    cell.contentView.backgroundColor = self.tableView.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    
    NSString *firstName = profile.firstName;
    NSString *lastName = profile.lastName;
    NSString *fullName=[NSString stringWithFormat:@"%@ %@.", firstName,lastName];
    NSString *city= [NSString stringWithFormat:@"%@ %@%",@"City:",profile.province];
    NSString *company= [NSString stringWithFormat:@"%@ %@%",@"Company:",profile.company];
    
    //Firts and Last Name
    UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 200, 25.0)];
    mainLabel.text=fullName;
    mainLabel.font = [UIFont boldSystemFontOfSize:16];
    mainLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:mainLabel];
     
    //City
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 35.0, 200, 20.0)];
    secondLabel.text=city;
    secondLabel.font =  [UIFont boldSystemFontOfSize:12];
    secondLabel.textColor = [UIColor darkGrayColor];
    [cell.contentView addSubview:secondLabel];
    
    //Current Company
    UILabel *thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 200, 15.0)];
    thirdLabel.text=company;
    thirdLabel.font =  [UIFont systemFontOfSize:12];
    thirdLabel.textColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:thirdLabel];
    
    
    //Loading Asynchronous pictures
    cell.imageView.image=nil;
    NSURL* url = [NSURL URLWithString:profile.pictureUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   UIImage* image = [[UIImage alloc] initWithData:data];
                                   cell.imageView.image=image;
                               }
                               
                           }];
    CGSize itemSize = CGSizeMake(80, 80);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(5.0, 5.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
     */
    
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
