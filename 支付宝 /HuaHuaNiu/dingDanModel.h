//
//  dingDanModel.h
//  HuaHuaNiu
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dingDanModel : NSObject

/*
 
 "token",@"member_id",@"user_name",@"store_id",@"region_id",@"region_name",@"address",@"zipcode",@"phone_mob",@"consignee",@"shippingid",@"shippingfee"
 */
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *member_id;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSString *store_id;
@property (nonatomic,strong) NSString *region_id;
@property (nonatomic,strong) NSString *region_name;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *zipcode;
@property (nonatomic,strong) NSString *phone_mob;
@property (nonatomic,strong) NSString *consignee;
@property (nonatomic,strong) NSString *shippingid;
@property (nonatomic,strong) NSString *shippingfee;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
