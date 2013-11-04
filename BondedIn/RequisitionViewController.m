//
//  RequisitionViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/1/13.
//
//

#import "RequisitionViewController.h"
#import "SelectionListViewController.h"

@interface RequisitionViewController () {
    NSDate* model;
    NSArray* locations;
    NSArray* technologies;
}

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation RequisitionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Requisition";
    //self.detailLabel.text = [model description];

}

-(void) setDate: (NSDate*) date {
    model = date;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"viewTechnologies"]) {
        // TODO: Next line should call method from SelectListViewController and set corresponding variables respecting Technologies 
        [[segue destinationViewController] setArray:technologies andSetOperatingTable:@"Technology" withColumn:@"Name"];
    } else if ([[segue identifier] isEqualToString:@"viewLocations"]){
        // TODO: Next line should call method from SelectListViewController and set corresponding variables respecting Locations
        [[segue destinationViewController] setArray:locations andSetOperatingTable:@"Location" withColumn:@"Name"];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
