//
//  Group+CoreDataProperties.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/29/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "Group+CoreDataProperties.h"

@implementation Group (CoreDataProperties)

+ (NSFetchRequest<Group *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Group"];
}

@dynamic groupName;
@dynamic specialization;
@dynamic member;

@end
