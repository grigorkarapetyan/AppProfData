//
//  User+CoreDataProperties.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/29/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic email;
@dynamic image;
@dynamic password;
@dynamic phone;

@end
