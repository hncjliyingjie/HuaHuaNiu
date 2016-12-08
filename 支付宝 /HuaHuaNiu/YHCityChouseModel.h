//
//  YHCityChouseModel.h
//  HuaHuaNiu
//
//  Created by zyh on 16/9/17.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCityChouseModel : NSObject
//城市名称
@property (nonatomic,strong) NSString *region_name;
//县级市名称
@property (nonatomic,strong) NSArray *childrens;

@property (nonatomic,strong) NSString *layer;
//@property (nonatomic,strong) NSString *region_name;
//@property (nonatomic,strong) NSString *region_name;
//@property (nonatomic,strong) NSString *region_name;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
