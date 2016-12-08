//
//  UserModel.h
//  HuaHuaNiu
//
//  Created by alex on 15/9/14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic,strong) NSString * birthday;
@property (nonatomic,strong) NSString * phone;
@property (nonatomic,strong) NSString * login_times;
@property (nonatomic,strong) NSString * last_login_ip;
@property (nonatomic,strong) NSString * password;
@property (nonatomic,strong) NSString * total_integral;
@property (nonatomic,strong) NSString * modify_userid;
@property (nonatomic,strong) NSString * nick_name;
@property (nonatomic,strong) NSString * age;
@property (nonatomic,strong) NSString * pay_password;
@property (nonatomic,strong) NSString * user_money;
@property (nonatomic,strong) NSString * modify_time;
@property (nonatomic,strong) NSString * signature;
@property (nonatomic,strong) NSString * qq;
@property (nonatomic,strong) NSString * user_flower;
@property (nonatomic,strong) NSString * member_grade;
@property (nonatomic,strong) NSString * last_login_time;
@property (nonatomic,strong) NSString * outer_id;
@property (nonatomic,strong) NSString * spended_money;
@property (nonatomic,strong) NSString * reg_time;
@property (nonatomic,strong) NSString * portrait;
@property (nonatomic,strong) NSString * member_id;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSString * real_name;
@property (nonatomic,strong) NSString * user_flower_basket;
@property (nonatomic,strong) NSString * stauts;
@property (nonatomic,strong) NSString * member_name;
@property (nonatomic,strong) NSString * frozen_money;
@property (nonatomic,strong) NSString * mobile;
@property (nonatomic,assign) NSInteger  result;

+(UserModel *)makeModelWithDict:(NSDictionary *)dictx;
@end
