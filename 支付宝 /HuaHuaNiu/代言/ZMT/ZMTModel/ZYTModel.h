//
//  ZYTModel.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/6.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *自媒体列表信息
 **/

@interface ZYTModel : NSObject

@property (strong,nonatomic)NSString *name;//自媒体列表中的名字

@property (strong,nonatomic) NSString *friendNumber;//自媒体列表中的好友数量

@property(strong,nonatomic)NSString *price;//自媒体列表中的广告价格

@property(strong,nonatomic)NSString *collect;//自媒体列表中的收藏数量

@property(strong,nonatomic)UIImage *img;//自媒体列表中的图片

@property(strong,nonatomic)NSString *listId;//列表id
@end
