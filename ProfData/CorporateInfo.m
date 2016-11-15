//
//  CorporateInfo.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/19/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "CorporateInfo.h"

@implementation CorporateInfo
+ (instancetype)corporateInfoWithNeedData:(NSString *) data {
    CorporateInfo *info = [[CorporateInfo alloc] init];
    info.needData = data;
    return info;
}
@end
