//
//  JDModel.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/28.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDModel : NSObject
@property (strong,nonatomic)NSString *ad_type;//分享图文/链接
@property  int counts;//个数
@property (strong,nonatomic)NSString *idStr;//点击的哪一个
@property (strong,nonatomic)NSString *media_type;//5中类型、微信。qq 微博 公众号  直播
@property (strong,nonatomic)NSString *name;//任务名称
@property  int tol_count;//任务总数
@property (strong,nonatomic)UIImage *way_type;//7中发布类型
@property (strong,nonatomic)NSString *isLingqus;//7中发布类型

@end
