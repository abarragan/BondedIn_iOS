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


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.delegate= self;
    if(_contactItem.fitNote!=nil){
        self.textView.text=_contactItem.fitNote.name;
    }
  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
     UITouch *touch = [[event allTouches] anyObject];
     if ([self.textView isFirstResponder] && [touch view] != self.textView) {
         [self.textView resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
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
