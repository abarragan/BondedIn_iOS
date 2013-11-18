//
//  ProfileTableViewCell.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/18/13.
//
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewCell : UITableViewCell


-(void) configureWithName: (NSString*) name city: (NSString*) city company: (NSString*) company imageUrl: (NSString*) imageUrl;
@end
