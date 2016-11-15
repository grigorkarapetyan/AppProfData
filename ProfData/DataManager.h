//
//  DataManager.h
//  ProfData
//
//  Created by Grigor Karapetyan on 10/17/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (nonatomic,copy) NSString *needMail;
- (NSManagedObjectContext *)managedObjectContext ;

+ (instancetype)sharedManager;

- (void)saveContext;

@end
