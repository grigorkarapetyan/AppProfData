//
//  CorporateInfo.h
//  ProfData
//
//  Created by Grigor Karapetyan on 10/19/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CorporateInfo : NSObject

@property (nonatomic,copy) NSString *needData;
+ (instancetype)corporateInfoWithNeedData:(NSString *) data;

@end
