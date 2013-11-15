//
//  Requisition.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/7/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fit, Location, Technology;

@interface Requisition : NSManagedObject

@property (nonatomic, retain) NSString * briefDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *requisitionFit;
@property (nonatomic, retain) NSSet *requisitionLocation;
@property (nonatomic, retain) NSSet *requisitionTechnology;
@end

@interface Requisition (CoreDataGeneratedAccessors)

- (void)addRequisitionFitObject:(Fit *)value;
- (void)removeRequisitionFitObject:(Fit *)value;
- (void)addRequisitionFit:(NSSet *)values;
- (void)removeRequisitionFit:(NSSet *)values;

- (void)addRequisitionLocationObject:(Location *)value;
- (void)removeRequisitionLocationObject:(Location *)value;
- (void)addRequisitionLocation:(NSSet *)values;
- (void)removeRequisitionLocation:(NSSet *)values;

- (void)addRequisitionTechnologyObject:(Technology *)value;
- (void)removeRequisitionTechnologyObject:(Technology *)value;
- (void)addRequisitionTechnology:(NSSet *)values;
- (void)removeRequisitionTechnology:(NSSet *)values;

@end
