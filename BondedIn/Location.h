//
//  Location.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/6/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Requisition;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * province;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSSet *locationRequisition;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addLocationRequisitionObject:(Requisition *)value;
- (void)removeLocationRequisitionObject:(Requisition *)value;
- (void)addLocationRequisition:(NSSet *)values;
- (void)removeLocationRequisition:(NSSet *)values;

@end
