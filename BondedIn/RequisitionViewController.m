//
//  RequisitionViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/1/13.
//
//

#import "RequisitionViewController.h"
#import "SelectionListViewController.h"
#import "Technology.h"
#import "Location.h"
#import "AppDelegate.h"

@interface RequisitionViewController ()

/*
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
*/

@property (strong, nonatomic) NSMutableArray* locations;
@property (strong, nonatomic) NSMutableArray* technologies;

- (IBAction)doneEditing:(id)sender;

@end

@implementation RequisitionViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]){
        // any custom configuration here
        _requisition = nil;
        _locations = [NSMutableArray array];
        _technologies = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Requisition";
    /*
    if (self.requisition == nil)
        self.nameTextField.text = @"New Requisition";
    [self.nameTextField resignFirstResponder];
    [self.view endEditing:YES];
     */
}

/*
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
 */

-(void) setRequisition: (Requisition*) openedRequisition {
    _requisition = openedRequisition;
    // self.nameTextField.text = [self.requisition name];
    self.technologies = [[self.requisition.requisitionTechnology allObjects] mutableCopy];
    self.locations = [[self.requisition.requisitionLocation allObjects] mutableCopy];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([[segue identifier] isEqualToString:@"technologiesList"]) {
        [[segue destinationViewController] setArray:self.technologies andSetOperatingTable:@"Technology" withColumn:@"Name"];
    } else if ([[segue identifier] isEqualToString:@"locationsList"]){
        [[segue destinationViewController] setArray:self.locations andSetOperatingTable:@"Location" withColumn:@"Name"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == DETAILS_SECTION)
        return 2;
    if (section == TECHNOLOGY_SECTION)
        return [self.technologies count];
    else if (section == LOCATION_SECTION)
        return [self.locations count];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    if (indexPath.section == DETAILS_SECTION){
        if (indexPath.item == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
        } else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"DetailsCell" forIndexPath:indexPath];
        }
        
    } else if (indexPath.section == TECHNOLOGY_SECTION){
        cell = [tableView dequeueReusableCellWithIdentifier:@"TechnologyCell" forIndexPath:indexPath];
        cell.textLabel.text = [[self.technologies objectAtIndex:indexPath.item] name];
    }
    else if (indexPath.section == LOCATION_SECTION) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
        cell.textLabel.text = [[self.locations objectAtIndex:indexPath.item] city];
        cell.detailTextLabel.text = [[self.locations objectAtIndex:indexPath.item] province];
    }
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // [self.tableview reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewCell* cell;
    
    if (section == DETAILS_SECTION){
        cell = [tableView dequeueReusableCellWithIdentifier:@"DetailsHeaderCell"];
    } else if (section == TECHNOLOGY_SECTION){
        cell = [tableView dequeueReusableCellWithIdentifier:@"TechnologiesHeaderCell"];
    }
    else if (section == LOCATION_SECTION) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"LocationsHeaderCell"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.item == 1)
        return 150;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (IBAction)doneEditing:(id)sender {
    NSSet* newTechs = [NSSet setWithArray:self.technologies];
    NSSet* newLocations = [NSSet setWithArray:self.locations];
    
    NSManagedObjectContext* context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    if (self.requisition == nil) {
        //NEW REQUISITION
        _requisition = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"Requisition"
                                    inManagedObjectContext:context];
    } else {
        //EDITING REQUISITION
        //self.requisition.requisitionTechnology = nil;
        //self.requisition.requisitionLocation = nil;
    }
    
    // self.requisition.name = self.nameTextField.text;
    [self.requisition addRequisitionLocation:newLocations];
    [self.requisition addRequisitionTechnology:newTechs];    
    
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);	
        abort();
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
