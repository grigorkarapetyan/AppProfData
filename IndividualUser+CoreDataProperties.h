//
//  IndividualUser+CoreDataProperties.h
//  ProfData
//
//  Created by Grigor Karapetyan on 10/29/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "IndividualUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface IndividualUser (CoreDataProperties)

+ (NSFetchRequest<IndividualUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *currentEmployer;
@property (nullable, nonatomic, copy) NSString *currentPosition;
@property (nullable, nonatomic, copy) NSDate *dateOfBirth;
@property (nullable, nonatomic, copy) NSString *education;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *interests;
@property (nullable, nonatomic, copy) NSString *languages;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *skills;
@property (nullable, nonatomic, copy) NSString *specialization;
@property (nullable, nonatomic, copy) NSString *workExperience;
@property (nullable, nonatomic, retain) NSSet<CorporateUser *> *employer;
@property (nullable, nonatomic, retain) NSSet<Event *> *event;
@property (nullable, nonatomic, retain) NSSet<Group *> *group;

@end

@interface IndividualUser (CoreDataGeneratedAccessors)

- (void)addEmployerObject:(CorporateUser *)value;
- (void)removeEmployerObject:(CorporateUser *)value;
- (void)addEmployer:(NSSet<CorporateUser *> *)values;
- (void)removeEmployer:(NSSet<CorporateUser *> *)values;

- (void)addEventObject:(Event *)value;
- (void)removeEventObject:(Event *)value;
- (void)addEvent:(NSSet<Event *> *)values;
- (void)removeEvent:(NSSet<Event *> *)values;

- (void)addGroupObject:(Group *)value;
- (void)removeGroupObject:(Group *)value;
- (void)addGroup:(NSSet<Group *> *)values;
- (void)removeGroup:(NSSet<Group *> *)values;

@end

NS_ASSUME_NONNULL_END
