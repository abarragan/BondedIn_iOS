//
//  ContactViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/11/13.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Fit.h"
#import "Profile.h"
#import "Requisition.h"
#import "NoteViewController.h"
#import "Note.h"

@interface ContactViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic)  NSMutableArray *cells;
@property (strong, nonatomic)  NSMutableArray *sections;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Fit * contact;

- (void)setContact:(Fit*)contactItem;

@end
