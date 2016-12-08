//
//  JDMoreModel.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDMoreModel : NSObject
@property(strong,nonatomic)NSString *name;//题目
@property(strong,nonatomic)NSString *end_time;//剩余时间
@property(strong,nonatomic)NSString *phone;//发布人号码
@property(strong,nonatomic)NSString *jd_cont_fisrst;//接单人次
@property(strong,nonatomic)NSString *jd_cont_secund;//接单人次
@property(strong,nonatomic)NSString *renling_type;//认领状态
@property(strong,nonatomic)NSString *content;//分享语
@property(strong,nonatomic)NSString *qrcode;//二维码
@property(strong,nonatomic)UIImage *img;//扫码任务步骤图片



@property(strong,nonatomic)NSString *share_link;//分享的链接地址
@property(strong,nonatomic)NSString *share_text;//分享语

@end
