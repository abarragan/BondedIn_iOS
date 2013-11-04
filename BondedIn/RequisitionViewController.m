//
//  RequisitionViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/1/13.
//
//

#import "RequisitionViewController.h"

@interface RequisitionViewController () {
    NSDate* model;
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
    self.detailLabel.text = [model description];

}

-(void) setDate: (NSDate*) date {
    model = date;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
