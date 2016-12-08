//
//  YHGoodsModel.m
//  花花牛
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YHGoodsModel.h"

@implementation YHGoodsModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    YHGoodsModel *model = [[YHGoodsModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
