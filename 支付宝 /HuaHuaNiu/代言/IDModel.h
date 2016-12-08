//
//  IDModel.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/27.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDModel : NSObject
@property(strong,nonatomic)NSString *nameStr;
@property(strong,nonatomic)NSString *idStr;
@property (nonatomic, strong) NSString *provinceName;//省级名字
@property (nonatomic, strong) NSString *province_id;//省级id
@property (nonatomic, strong) NSString *cityName;//市级名字
@property (nonatomic, strong) NSString *city_id;//市级id
@end
