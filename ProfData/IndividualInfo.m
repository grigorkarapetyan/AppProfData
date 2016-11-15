//
//  IndividualInfo.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/17/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "IndividualInfo.h"

@implementation IndividualInfo
+ (instancetype)individualInfoWithNeedData:(NSString *) data {
    IndividualInfo *info = [[IndividualInfo alloc] init];
    info.needData = data;
    return info;
}
@end
