//
//  ZYModel.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/25.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYModel : NSObject
@property(strong,nonatomic)UIImage *headImg;//顶部图片
@property(strong,nonatomic)NSString *name;//广告名称
@property(strong,nonatomic)NSString *profiles;//描述
@property(strong,nonatomic)NSString *price;//价格
@property(strong,nonatomic)NSString *province;//省
@property(strong,nonatomic)NSString *city;//城市
@property(strong,nonatomic)NSString *address;//详细地址
@property(strong,nonatomic)NSString *cover_num;//受众人群


@property(strong,nonatomic)NSString *start_time;//开始时间
@property(strong,nonatomic)NSString *end_time;//结束时间
@property(strong,nonatomic)NSString *type;//类型
@property(strong,nonatomic)NSString *height;//规格高度
@property(strong,nonatomic)NSString *width;//规格宽度

@property(strong,nonatomic)NSString *nick_name;//人的姓名

@property(strong,nonatomic)NSString *company_name;//公司名称

@property(strong,nonatomic)NSString *detail;//图文详情

@property(strong,nonatomic)UIImage *lunboImg;//轮播图

@property(strong,nonatomic)UIImage *gerenImg;//头像
@property (nonatomic, strong) NSString *iconURLStr;//头像网址


@property(strong,nonatomic)NSString *idStr;//id

//资源详情图文详情属性
@property (nonatomic, assign) CGFloat imgWidth;//图片宽度
@property (nonatomic, assign) CGFloat imgHeight;//图片高度
@property (nonatomic, strong) UIImageView *myImageView;//图片内容
@property (nonatomic, strong) UIImage *image;//图片

//资源详情评价属性
@property (nonatomic, strong) NSString *iconUrlStr;//完整的头像网络地址字符串
@property (nonatomic, strong) NSString *nickName;//昵称
@property (nonatomic, strong) NSString *time;//时间
@property (nonatomic, strong) NSString *freebackStr;//评论内容
@end
