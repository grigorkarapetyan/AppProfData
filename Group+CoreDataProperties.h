//
//  Group+CoreDataProperties.h
//  ProfData
//
//  Created by Grigor Karapetyan on 10/29/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "Group+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Group (CoreDataProperties)

+ (NSFetchRequest<Group *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *groupName;
@property (nullable, nonatomic, copy) NSString *specialization;
@property (nullable, nonatomic, retain) NSSet<IndividualUser *> *member;

@end

@interface Group (CoreDataGeneratedAccessors)

- (void)addMemberObject:(IndividualUser *)value;
- (void)removeMemberObject:(IndividualUser *)value;
- (void)addMember:(NSSet<IndividualUser *> *)values;
- (void)removeMember:(NSSet<IndividualUser *> *)values;

@end

NS_ASSUME_NONNULL_END
