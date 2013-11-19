//
//  DetailTableViewCell.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/19/13.
//
//

#import <UIKit/UIKit.h>

@class DetailTableViewCell;

@protocol DetailTableViewCellDelegate <NSObject>

-(void) detailTableViewCellController: (DetailTableViewCell*) detailTableViewCell detailChange: (NSString*)detail;

@end


@interface DetailTableViewCell : UITableViewCell <UITextViewDelegate>

-(void) configureWithDetail: (NSString*) detail;
@property (weak, nonatomic) id <DetailTableViewCellDelegate> delegate;
@end
