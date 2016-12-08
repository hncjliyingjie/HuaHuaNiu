//
//  dingDanModel.m
//  HuaHuaNiu
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "dingDanModel.h"

@implementation dingDanModel
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    dingDanModel *model = [[dingDanModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
