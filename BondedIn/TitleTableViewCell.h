//
//  TitleTableViewCell.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/19/13.
//
//

#import <UIKit/UIKit.h>

@class TitleTableViewCell;

@protocol TitleTableViewCellDelegate <NSObject>

-(void) titleTableViewCellController: (TitleTableViewCell*) titleTableViewCell titleChange: (NSString*)title;

@end


@interface TitleTableViewCell : UITableViewCell <UITextFieldDelegate>

-(void) configureWithTitle: (NSString*) title;
@property (weak, nonatomic) id <TitleTableViewCellDelegate> delegate;
@end
