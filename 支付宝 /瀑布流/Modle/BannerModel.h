//
//  BannerModel.h
//  mokoo
//
//  Created by Mac on 15/9/2.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
//"banner_id":"banner广告ID",
//"img_url":"图片链接",
//"type":"广告类型",  1.网页广告  2.推荐活动  3.推荐模特卡
//（类型为1时跳转到网页，为2时跳转到活动 ，为3时跳转到模特卡）
//"url":"网页广告url链接",
//"id":"活动或模特卡对应ID",
//"form_user_id":"活动或模特卡对应用户ID",
//title 网页头部的title
@interface BannerModel : NSObject
@property (nonatomic,copy) NSString *banner_id;
@property (nonatomic,copy) NSString *img_url;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *form_id;
@property (nonatomic,copy) NSString *form_user_id;
@property (nonatomic,copy) NSString *title;

+(instancetype)initBannerWithDict:(NSDictionary *)dict;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com