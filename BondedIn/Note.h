//
//  Note.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/7/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fit;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Fit *noteFit;

@end
