//
//  YHOrderModel.m
//  花花牛
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YHOrderModel.h"

@implementation YHOrderModel


+ (instancetype)modelWithDict:(NSDictionary *)dict{
    YHOrderModel *model = [[YHOrderModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
