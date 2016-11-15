//
//  Event+CoreDataProperties.h
//  ProfData
//
//  Created by Grigor Karapetyan on 10/29/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "Event+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

+ (NSFetchRequest<Event *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *eventDate;
@property (nullable, nonatomic, copy) NSString *eventDescription;
@property (nullable, nonatomic, copy) NSString *eventName;
@property (nullable, nonatomic, retain) NSSet<IndividualUser *> *participant;

@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addParticipantObject:(IndividualUser *)value;
- (void)removeParticipantObject:(IndividualUser *)value;
- (void)addParticipant:(NSSet<IndividualUser *> *)values;
- (void)removeParticipant:(NSSet<IndividualUser *> *)values;

@end

NS_ASSUME_NONNULL_END
