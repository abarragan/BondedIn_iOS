//
//  Techonology.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Requisition;

@interface Technology : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Requisition *technologyRequisition;

@end
