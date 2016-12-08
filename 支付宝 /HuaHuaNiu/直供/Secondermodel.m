//
//  Secondermodel.m
//  HuaHuaNiu
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "Secondermodel.h"

@implementation Secondermodel
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    Secondermodel *model = [[Secondermodel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
