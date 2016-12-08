//
//  YHCityChouseModel.m
//  HuaHuaNiu
//
//  Created by zyh on 16/9/17.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "YHCityChouseModel.h"

@implementation YHCityChouseModel


+ (instancetype)modelWithDict:(NSDictionary *)dict{
    YHCityChouseModel * model = [[YHCityChouseModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    if ([key isEqualToString:@"children"]) {
//        NSMutableArray *arr = [NSMutableArray array];
//        [value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            YHCityChouseModel * model = [[YHCityChouseModel alloc] init];
//            [model setValuesForKeysWithDictionary:obj];
//            [arr addObject:model];
//        }];
//        self.childrens = arr.copy;
//    }
}

@end
