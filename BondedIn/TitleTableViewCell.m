//
//  TitleTableViewCell.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/19/13.
//
//

#import "TitleTableViewCell.h"

@interface TitleTableViewCell()
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;

@end

@implementation TitleTableViewCell

- (IBAction)textViewDoneClicked:(id)sender {
    [self.delegate titleTableViewCellController: self titleChange: self.titleTextField.text];
    [self.titleTextField resignFirstResponder];
    
}
-(void) configureWithTitle: (NSString*) title{
    
    self.titleTextField.delegate=self;
    
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
    self.titleTextField.inputAccessoryView = keyboardDoneButtonView;
    self.titleTextField.text=title;
    [self.titleTextField resignFirstResponder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
