//
//  WanShangModel.h
//  HuaHuaNiu
//
//  Created by alex on 15/9/14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WanShangModel : NSObject
//shouY Arr
@property (nonatomic,strong)NSMutableArray * areaArr;
@property (nonatomic,strong)NSMutableArray * advArr;
@property (nonatomic,strong)NSMutableArray * flashArr;
@property (nonatomic,strong)NSMutableArray * storesArr;
//area
@property (nonatomic,strong)NSString * areaName;
@property (nonatomic,strong)NSString * areaLayer;
@property (nonatomic,strong)NSString * areaId;
@property (nonatomic,strong)NSString * areaOrder;
@property (nonatomic,strong)NSString * areaParentId;
//adv_can
@property (nonatomic,strong)NSString * advPartnerId;
@property (nonatomic,strong)NSString * advLogo;
@property (nonatomic,strong)NSString * advPositionId;
@property (nonatomic,strong)NSString * advType;
@property (nonatomic,strong)NSString * advFlowers;
@property (nonatomic,strong)NSString * advOthername;
@property (nonatomic,strong)NSString * advAdvalue;
//adv_flash
@property (nonatomic,strong)NSString * flashLogo;
@property (nonatomic,strong)NSString * flashTitle;
@property (nonatomic,strong)NSString * flashPrice;
@property (nonatomic,strong)NSString * flashAd_id;
@property (nonatomic,strong)NSString * flashAdtype;
@property (nonatomic,strong)NSString * flashType_id;
@property (nonatomic,strong)NSString * flashAdvalue;
//stores
@property (nonatomic,strong)NSString * storeDistance;
@property (nonatomic,strong)NSString * storeVoucher_status;
@property (nonatomic,strong)NSString * storeHas_change;
@property (nonatomic,strong)NSString * storeHas_free;
@property (nonatomic,strong)NSString * storeHas_join;
@property (nonatomic,strong)NSString * storeHas_prize;
@property (nonatomic,strong)NSString * storeHas_video;
@property (nonatomic,strong)NSString * storeBaind;
@property (nonatomic,strong)NSString * storeAddress_ll;
@property (nonatomic,strong)NSString * storeTel;
@property (nonatomic,strong)NSString * storeCateId;
@property (nonatomic,strong)NSString * storeId;
@property (nonatomic,strong)NSString * storeLogo;
@property (nonatomic,strong)NSString * storeName;
@property (nonatomic,strong)NSString * storeCateName;


+(WanShangModel *)makeMainModelWithDict:(NSDictionary *)dict;
@end
