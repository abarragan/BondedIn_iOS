//
//  SelectionListViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/4/13.
//
//

#import <UIKit/UIKit.h>

@interface SelectionListViewController : UITableViewController

- (void)setArray:(NSArray*) selectedItems andSetOperatingTable:(NSString*) table withColumn:(NSString*) column;

@end
