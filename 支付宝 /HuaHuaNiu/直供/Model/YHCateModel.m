//
//  YHCateModel.m
//  花花牛
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YHCateModel.h"

@implementation YHCateModel
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    YHCateModel *model = [[YHCateModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _cate_id = value;
    }
}
@end
