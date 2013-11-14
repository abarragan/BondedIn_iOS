//
//  Technology.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/6/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Requisition;

@interface Technology : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *technologyRequisition;
@end

@interface Technology (CoreDataGeneratedAccessors)

- (void)addTechnologyRequisitionObject:(Requisition *)value;
- (void)removeTechnologyRequisitionObject:(Requisition *)value;
- (void)addTechnologyRequisition:(NSSet *)values;
- (void)removeTechnologyRequisition:(NSSet *)values;

@end
