//
//  RequisitionViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/1/13.
//
//

#import <UIKit/UIKit.h>
#import "Requisition.h"

#define DETAILS_SECTION 0
#define TECHNOLOGY_SECTION 1
#define LOCATION_SECTION 2

@interface RequisitionViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) Requisition* requisition;

-(void) setRequisition: (Requisition*) openedRequisition;

@end
