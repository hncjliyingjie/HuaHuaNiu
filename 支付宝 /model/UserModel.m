//
//  UserModel.m
//  HuaHuaNiu
//
//  Created by alex on 15/9/14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+(UserModel *)makeModelWithDict:(NSDictionary *)dictx{
    UserModel *model =[[UserModel alloc]init];
    NSLog(@"%@",[dictx objectForKey:@"msg"]);
    model.result =[[dictx objectForKey:@"result"]integerValue];
    if (model.result ==1) {
    NSDictionary * dict=[[dictx objectForKey:@"retval"] objectAtIndex:0];
    model.birthday =[NSString stringWithFormat:@"%@",[dict objectForKey:@"birthday"]];
    model.phone =[NSString stringWithFormat:@"%@",[dict objectForKey:@"mobile"]];
    model.login_times =[NSString stringWithFormat:@"%@",[dict objectForKey:@"login_times"]];
    model.last_login_ip =[NSString stringWithFormat:@"%@",[dict objectForKey:@"last_login_ip"]];
    model.password =[NSString stringWithFormat:@"%@",[dict objectForKey:@"password"]];
    model.total_integral =[NSString stringWithFormat:@"%@",[dict objectForKey:@"total_integral"]];
    model.modify_userid =[NSString stringWithFormat:@"%@",[dict objectForKey:@"modify_userid"]];
    model.nick_name =[NSString stringWithFormat:@"%@",[dict objectForKey:@"nick_name"]];
    model.age =[NSString stringWithFormat:@"%@",[dict objectForKey:@"age"]];
    model.pay_password =[NSString stringWithFormat:@"%@",[dict objectForKey:@"pay_password"]];
    model.user_money =[NSString stringWithFormat:@"%@",[dict objectForKey:@"user_money"]];
    model.modify_time =[NSString stringWithFormat:@"%@",[dict objectForKey:@"modify_time"]];
    model.signature =[NSString stringWithFormat:@"%@",[dict objectForKey:@"signature"]];
    model.qq =[NSString stringWithFormat:@"%@",[dict objectForKey:@"qq"]];
    model.user_flower =[NSString stringWithFormat:@"%@",[dict objectForKey:@"user_flower"]];
    model.member_grade =[NSString stringWithFormat:@"%@",[dict objectForKey:@"member_grade"]];
    model.last_login_time =[NSString stringWithFormat:@"%@",[dict objectForKey:@"last_login_time"]];
    model.outer_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"outer_id"]];
    model.reg_time =[NSString stringWithFormat:@"%@",[dict objectForKey:@"reg_time"]];
    model.spended_money =[NSString stringWithFormat:@"%@",[dict objectForKey:@"spended_money"]];
    model.portrait =[NSString stringWithFormat:@"%@",[dict objectForKey:@"portrait"]];
    model.member_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"member_id"]];
    model.email =[NSString stringWithFormat:@"%@",[dict objectForKey:@"email"]];
    model.real_name =[NSString stringWithFormat:@"%@",[dict objectForKey:@"real_name"]];
    model.user_flower_basket =[NSString stringWithFormat:@"%@",[dict objectForKey:@"user_flower_basket"]];
    model.stauts =[NSString stringWithFormat:@"%@",[dict objectForKey:@"stauts"]];
    model.member_name =[NSString stringWithFormat:@"%@",[dict objectForKey:@"member_name"]];
    model.frozen_money =[NSString stringWithFormat:@"%@",[dict objectForKey:@"frozen_money"]];
    model.mobile =[NSString stringWithFormat:@"%@",[dict objectForKey:@"mobile"]];
    }
    
    return model;
}
@end
