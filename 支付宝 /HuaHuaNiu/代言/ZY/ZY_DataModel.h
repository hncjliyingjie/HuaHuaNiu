//
//  ZY_DataModel.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/24.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZY_DataModel : NSObject
@property(strong,nonatomic)NSString *pinglunStr;
//评论数

@property(strong,nonatomic)NSString *nameStr;
//广告名称

@property(strong,nonatomic)NSString *liulanStr;
//浏览

@property(strong,nonatomic)NSString *filesStr;
//广告内容

@property(strong,nonatomic)NSString *idStr;
//点击的id

@property(strong,nonatomic)UIImage *headImg;
//图片

@end
