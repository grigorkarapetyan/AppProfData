//
//  IndividualUser+CoreDataProperties.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/29/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "IndividualUser+CoreDataProperties.h"

@implementation IndividualUser (CoreDataProperties)

+ (NSFetchRequest<IndividualUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"IndividualUser"];
}

@dynamic city;
@dynamic currentEmployer;
@dynamic currentPosition;
@dynamic dateOfBirth;
@dynamic education;
@dynamic firstName;
@dynamic interests;
@dynamic languages;
@dynamic lastName;
@dynamic skills;
@dynamic specialization;
@dynamic workExperience;
@dynamic employer;
@dynamic event;
@dynamic group;

@end
