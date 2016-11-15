//
//  CorporateUser+CoreDataProperties.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/29/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "CorporateUser+CoreDataProperties.h"

@implementation CorporateUser (CoreDataProperties)

+ (NSFetchRequest<CorporateUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CorporateUser"];
}

@dynamic companyName;
@dynamic headquarterAddress;
@dynamic headquarterCity;
@dynamic sector;
@dynamic type;
@dynamic employee;

@end
