//
//  Fit.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/7/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note, Profile, Requisition;

@interface Fit : NSManagedObject

@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) Note *fitNote;
@property (nonatomic, retain) Profile *fitProfile;
@property (nonatomic, retain) Requisition *fitRequisition;
@end

@interface Fit (CoreDataGeneratedAccessors)

- (void)addFitNoteObject:(Note *)value;
- (void)removeFitNoteObject:(Note *)value;
- (void)addFitNote:(NSSet *)values;
- (void)removeFitNote:(NSSet *)values;

@end
