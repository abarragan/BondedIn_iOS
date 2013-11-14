//
//  ContactViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/11/13.
//
//

#import "ContactViewController.h"
#define email @"Mail"
#define cellPhone @"Phone"
#define note @"Note"

@interface ContactViewController ()

- (void)showEmail;
@end

@implementation ContactViewController

@synthesize cells, sections;

- (void)setContact:(Fit*)contactItem{
    
    if(_contact !=contactItem){
        
       _contact=contactItem;
        
        self.cells=[NSMutableArray array];
        self.sections=[NSMutableArray array];
        
        //sections
        [self.sections addObject:@"Contact"];
        [self.sections addObject:@"Add Note"];
        
        //cell data
        NSMutableArray* section1 = [NSMutableArray array];
        [section1 addObject:email];
        [section1 addObject:cellPhone];
        [self.cells addObject:section1];
        NSMutableArray* section2 = [NSMutableArray array];
        [section2 addObject:note];
        [self.cells addObject:section2];
    }
 
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Open the Contact View, to send mail, do a call or add a note
    if ([[segue identifier] isEqualToString:@"noteView"]) {
        [[segue destinationViewController]addNote: _contact];
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.cells objectAtIndex:section] count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.sections objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Cell to add Note
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.contentView.backgroundColor = self.tableView.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    //Cell to call and send an email
    static NSString *cellIdentifierMailAndPhone = @"Cell2";
    UITableViewCell *cellMailAndPhone = [tableView dequeueReusableCellWithIdentifier:cellIdentifierMailAndPhone];
    
    cellMailAndPhone.contentView.backgroundColor = self.tableView.backgroundColor;
    cellMailAndPhone.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    NSString *option=[[self.cells objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    //Option Mail/Phone
    if([option isEqualToString:email]|| [option isEqualToString:cellPhone]){
        
        cellMailAndPhone.textLabel.text=[[self.cells objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        return cellMailAndPhone;

    }
    //Option Note
    else if([option isEqualToString:note]){
        cell.textLabel.text=[[self.cells objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
        return cell;
    }
    return cell;
   }

- (void)showEmail {
    // Email Subject
    NSString *emailTitle =_contact.fitRequisition.name;
    // Email Content
    NSString *messageBody = @"Hear the template";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:_contact.fitProfile.mail];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *option=[[self.cells objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    //Option send an email
    if([option isEqualToString:email]){
        if(self.contact.fitProfile.mail!=nil){
            [self showEmail];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"The profile doesn't have mail associated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            
        }
    }
    //Option call phone
    else if([option isEqualToString:cellPhone]){
        
        //call phone
        if(self.contact.fitProfile.phone!=nil){
            NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",(NSString *)self.contact.fitProfile.phone];
            NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
            [[UIApplication sharedApplication] openURL:phoneURL];

        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"The profile doesn't have phone associated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            
        }
   }
}

@end
