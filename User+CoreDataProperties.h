//
//  User+CoreDataProperties.h
//  ProfData
//
//  Created by Grigor Karapetyan on 10/29/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSString *phone;

@end

NS_ASSUME_NONNULL_END
