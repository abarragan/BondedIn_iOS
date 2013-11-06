//
//  RequisitionViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/1/13.
//
//

#import <UIKit/UIKit.h>
#import "Requisition.h"

#define TECHNOLOGY_SECTION 0
#define LOCATION_SECTION 1

@interface RequisitionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) Requisition* requisition;


-(void) setRequisition: (Requisition*) openedRequisition;

@end
