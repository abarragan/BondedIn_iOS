//
//  NoteViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/12/13.
//
//

#import "NoteViewController.h"
#import "ContactViewController.h"
#import "Note.h"
#import "Profile.h"
#import "AppDelegate.h"

@interface NoteViewController ()

- (IBAction)doneEditing:(id)sender;

@end

@implementation NoteViewController

@synthesize textView=_textView;

-(void)addNote:(Fit *)contactItem{
    if(_contactItem!=contactItem){
        _contactItem=contactItem;
    }
}
- (IBAction)textViewDoneClicked:(id)sender {
    [self.textView resignFirstResponder];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.delegate= self;
    if(_contactItem.fitNote!=nil){
       self.textView.text=_contactItem.fitNote.name;
    }
    
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
   self.textView.inputAccessoryView = keyboardDoneButtonView;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 }

- (IBAction)doneEditing:(id)sender {
    
    Note *note=nil;
    NSError *error = nil;
    NSManagedObjectContext* context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
 
    //if is a new note
    if(_contactItem.fitNote==nil){
        note = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Note"
                      inManagedObjectContext:context];
        
        note.name= self.textView.text;
        _contactItem.fitNote=note;
    }
    //If is editing the note
    else{
        _contactItem.fitNote.name= self.textView.text;
    }
    
    // Save the context.
    if (![context save:&error]) {
          NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    [self.navigationController popViewControllerAnimated:YES];
}
@end
