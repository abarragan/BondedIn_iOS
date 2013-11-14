//
//  NoteViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/12/13.
//
//

#import <UIKit/UIKit.h>
#import "Fit.h"

@interface NoteViewController :  UIViewController <UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) Fit * contactItem;

- (void)addNote:(Fit*)contactItem;

@end
