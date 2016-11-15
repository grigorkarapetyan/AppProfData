//
//  CorporateUser+CoreDataProperties.h
//  ProfData
//
//  Created by Grigor Karapetyan on 10/29/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "CorporateUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CorporateUser (CoreDataProperties)

+ (NSFetchRequest<CorporateUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *companyName;
@property (nullable, nonatomic, copy) NSString *headquarterAddress;
@property (nullable, nonatomic, copy) NSString *headquarterCity;
@property (nullable, nonatomic, copy) NSString *sector;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, retain) NSSet<IndividualUser *> *employee;

@end

@interface CorporateUser (CoreDataGeneratedAccessors)

- (void)addEmployeeObject:(IndividualUser *)value;
- (void)removeEmployeeObject:(IndividualUser *)value;
- (void)addEmployee:(NSSet<IndividualUser *> *)values;
- (void)removeEmployee:(NSSet<IndividualUser *> *)values;

@end

NS_ASSUME_NONNULL_END
