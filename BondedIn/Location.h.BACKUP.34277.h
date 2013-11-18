//
//  Location.h
//  BondedIn
//
<<<<<<< HEAD
//  Created by Silvio Jaureguibehere on 11/7/13.
=======
//  Created by Silvio Jaureguibehere on 11/6/13.
>>>>>>> Requisition Detail Functionality
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Requisition;

@interface Location : NSManagedObject

<<<<<<< HEAD
@property (nonatomic, retain) NSString * province;
@property (nonatomic, retain) NSString * city;
=======
@property (nonatomic, retain) NSString * name;
>>>>>>> Requisition Detail Functionality
@property (nonatomic, retain) NSSet *locationRequisition;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addLocationRequisitionObject:(Requisition *)value;
- (void)removeLocationRequisitionObject:(Requisition *)value;
- (void)addLocationRequisition:(NSSet *)values;
- (void)removeLocationRequisition:(NSSet *)values;

@end
