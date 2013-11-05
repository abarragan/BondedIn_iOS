//
//  Requisition.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Technology, Location, Fit;

@interface Requisition : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * briefDescription;
@property (nonatomic, retain) Technology *requisitionTechnology;
@property (nonatomic, retain) Location *requisitionLocation;
@property (nonatomic, retain) Fit *requisitionFit;

@end
