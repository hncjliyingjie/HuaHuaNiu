//
//  Define.h
//  HuaHuaNiu
//
//  Created by mac on 16/12/4.
//  Copyright © 2016年 张燕. All rights reserved.
//  李英杰创建,用于宏定义接口,导入头文件

#ifndef Define_h
#define Define_h

#import "UserDefaultManager.h"
#import "MBProgressHUD.h"

//首页代言-收藏接口
#define KDYCollectionURL @"/appwemedia/addcolect.do?"

//自媒体加入购物车接口
#define KZMTBuyCarURL @"%@/appwemedia/addCar.do?token=%@&id=%@&userId=%@"

//资源加入购物车接口
#define KZYBuyCarURL @"%@/appResource/addCar.do?token=%@&id=%@&userId=%@"

//资源详情界面他的评价接口
#define KZYFreebackURL @"%@/appResource/resourceDiscuss.do?token=%@&id=%@&page=%@"

//打印 API
#define KMyLog(...) NSLog(__VA_ARGS__)
#endif /* Define_h */
