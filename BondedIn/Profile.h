//
//  Profile.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fit;

@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * province;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSNumber * phone;
@property (nonatomic, retain) NSString * mail;
@property (nonatomic, retain) NSString * pictureUrl;
@property (nonatomic, retain) NSString * publicProfileUrl;
@property (nonatomic, retain) Fit *profileFit;

@end
