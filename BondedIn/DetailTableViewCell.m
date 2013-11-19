//
//  DetailTableViewCell.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/19/13.
//
//

#import "DetailTableViewCell.h"
@interface DetailTableViewCell()

@property (strong, nonatomic) IBOutlet UITextView *detailTextView;

@end

@implementation DetailTableViewCell

- (IBAction)textViewDoneClicked:(id)sender {
    [self.delegate detailTableViewCellController: self detailChange: self.detailTextView.text];
    [self.detailTextView resignFirstResponder];
    
}
-(void) configureWithDetail: (NSString*) detail{
   
    self.detailTextView.delegate=self;
    //Create Toolbar
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.frame=CGRectMake(0,75,180,10);
    keyboardDoneButtonView.barStyle =UIBarStyleBlackTranslucent;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //Create button "Done"
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(textViewDoneClicked:) ];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
     
    //add a Accessory with toolbar
    self.detailTextView.inputAccessoryView = keyboardDoneButtonView;
    self.detailTextView.text=detail;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
