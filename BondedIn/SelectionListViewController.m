//
//  SelectionListViewController.m
//  BondedIn
//
//

#import "SelectionListViewController.h"
#import "Location.h"
#import "AppDelegate.h"

@interface SelectionListViewController ()

@property (nonatomic, strong) NSMutableArray* rows;
@property (nonatomic, strong) NSMutableArray* selectedRows;

@end

@implementation SelectionListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setArray:(NSMutableArray*) selectedItems andSetOperatingTable:(NSString*) table withColumn:(NSString*) column
{
    self.selectedRows = selectedItems;
    
    self.title = table;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext* context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSEntityDescription* entity = [NSEntityDescription entityForName:self.title inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    self.rows = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    if ([self.title isEqualToString: @"Technology"]){
        cell.textLabel.text = [[self.rows objectAtIndex:indexPath.item]  name];
    }
    else if ([self.title isEqualToString: @"Location"]) {
        cell.textLabel.text = [[self.rows objectAtIndex:indexPath.item]  city];
    }
    
    
    id object = [self.rows objectAtIndex:indexPath.item];
    
    if ([self.selectedRows containsObject:object]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else 
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    id object = [self.rows objectAtIndex:indexPath.item];
    
    if ([self.selectedRows containsObject:object]) {
        [self.selectedRows removeObjectIdenticalTo:object];
    }
    else {
        [self.selectedRows addObject:object];
    }
    [self.tableView reloadData];
}

@end
