//
//  IndividualInfo.h
//  ProfData
//
//  Created by Grigor Karapetyan on 10/17/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IndividualInfo : NSObject

@property (nonatomic,copy) NSString *needData;
+ (instancetype)individualInfoWithNeedData:(NSString *) data;

@end
