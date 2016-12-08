//
//  SeconderViewModel.m
//  HuaHuaNiu
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "SeconderViewModel.h"

@implementation SeconderViewModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    SeconderViewModel *model = [[SeconderViewModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
