//
//  AlexModel.h
//  HuaHuaNiu
//
//  Created by alex on 15/9/1.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlexModel : NSObject
//首页参数
@property (nonatomic,copy) NSString * result;

@property (nonatomic,copy) NSString * current;

@property (nonatomic,copy) NSString * arceId;
@property (nonatomic,copy) NSString * arceValue;
@property (nonatomic,copy) NSString * arceChildren;
@property (nonatomic,strong) NSMutableArray * arceArr;

@property (nonatomic,copy) NSString * funTitle;
@property (nonatomic,copy) NSString * funLogo;
@property (nonatomic,strong) NSMutableArray * funArr;

@property (nonatomic,copy) NSString * boutiqueTitle;
@property (nonatomic,copy) NSString * boutiqueId;
@property (nonatomic,copy) NSString * boutiquePrice;
@property (nonatomic,copy) NSString * boutiqueLogo;
@property (nonatomic,strong) NSMutableArray * bouArr;

@property (nonatomic,copy) NSString * nearTitle;
@property (nonatomic,copy) NSString * nearId;
@property (nonatomic,copy) NSString * nearlogo;
@property (nonatomic,copy) NSString * nearStatus;
@property (nonatomic,copy) NSString * nearPhone;
@property (nonatomic,strong) NSMutableArray * nearArr;

@property (nonatomic,copy) NSString * flashType_id;
@property (nonatomic,copy) NSString * flashad_id;
@property (nonatomic,copy) NSString * flashType;
@property (nonatomic,copy) NSString * flashId;
@property (nonatomic,copy) NSString * flashLogo;
@property (nonatomic,strong) NSMutableArray * flashArr;

@property (nonatomic,copy) NSString * sameId;
@property (nonatomic,copy) NSString * sameType;
@property (nonatomic,copy) NSString * samePrice;
@property (nonatomic,copy) NSString * sameLogo;
@property (nonatomic,copy) NSString * sameTitle;
@property (nonatomic,strong) NSMutableArray * sameArr;


//我的粉丝
@property (nonatomic,copy) NSString * y_addfuns;
@property (nonatomic,copy) NSString * indirect_funs;
@property (nonatomic,copy) NSString * direct_funs;

@property (nonatomic,copy) NSString * total_money;
@property (nonatomic,copy) NSString * y_addmoney;

@property (nonatomic,copy) NSString * total_flower_basket;
@property (nonatomic,copy) NSString * y_addflower_basket;

@property (nonatomic,copy) NSString * total_flower;
@property (nonatomic,copy) NSString * y_addflower;

//我来代言
@property (nonatomic,copy) NSString * bind_id;
@property (nonatomic,copy) NSString * bind_days;
@property (nonatomic,copy) NSString * bind_need_flower;
@property (nonatomic,copy) NSString * bind_status;

@property (nonatomic,copy) NSString * start_date;
@property (nonatomic,copy) NSString * end_date;

@property (nonatomic,copy) NSString * store_id;
@property (nonatomic,copy) NSString * store_name;
@property (nonatomic,copy) NSString * store_logo;

@property (nonatomic,copy) NSString * money;
@property (nonatomic,copy) NSString * surplus_days;
@property (nonatomic,strong)NSMutableArray * bindArr;

//真的免费
@property (nonatomic,copy) NSString * goods_name;
@property (nonatomic,copy) NSString * gf_id;
@property (nonatomic,copy) NSString * summary;
@property (nonatomic,copy) NSString * default_image;

//获取代金券
@property (nonatomic,copy) NSString * voucher ;
@property (nonatomic,copy) NSString * distance;



+(AlexModel *)makeMainModelWithDict:(NSDictionary *)dict;
+(AlexModel *)makeFunsModelWithDict:(NSDictionary *)dict;
+(AlexModel *)makeBindsModelWithDict:(NSDictionary *)dict;
+(AlexModel *)makeRealFreeModelWithDict:(NSDictionary *)dict;
+(AlexModel *)makeVoucherModelWithDict:(NSDictionary *)dict;
+(AlexModel *)makeGoodDetailModelWithDict:(NSDictionary *)dict;
+(AlexModel *)makeStoreGoodsModelWithDict:(NSDictionary *)dict;
+(AlexModel *)makeStoreDetailModelWithDict:(NSDictionary *)dict;




@end
