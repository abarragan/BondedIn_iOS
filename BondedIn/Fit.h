//
//  Fit.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Profile, Requisition, Note;

@interface Fit : NSManagedObject

@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) Profile *fitProfile;
@property (nonatomic, retain) Note *fitNote;
@property (nonatomic, retain) Requisition *fitRequisition;

@end
