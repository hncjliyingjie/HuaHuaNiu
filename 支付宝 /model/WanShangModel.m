//
//  WanShangModel.m
//  HuaHuaNiu
//
//  Created by alex on 15/9/14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "WanShangModel.h"

@implementation WanShangModel
+(WanShangModel *)makeMainModelWithDict:(NSDictionary *)dict{
    NSLog(@"wanshang result====%@",[dict objectForKey:@"msg"]);
    
    WanShangModel * model =[[WanShangModel alloc]init];
    model.areaArr =[NSMutableArray array];
    model.advArr =[NSMutableArray array];
    model.flashArr =[NSMutableArray array];
    model.storesArr =[NSMutableArray array];
    
    NSArray * arr= [NSArray array];
    
    arr = [dict objectForKey:@"area"];
    for (NSDictionary * areaDict in arr) {
        WanShangModel * areaModel = [WanShangModel makeAreaModelWithDict:areaDict];
        [model.areaArr addObject:areaModel];
    }
    
    arr =[dict objectForKey:@"adv_can"];
    for (NSDictionary * advDict in arr) {
        WanShangModel * advModel =[WanShangModel makeAdvCanModelWithDict:advDict];
        [model.advArr addObject:advModel];
    }
    arr =[dict objectForKey:@"adv_flash"];
    for (NSDictionary * flashDict in arr) {
        WanShangModel * flashModel =[WanShangModel makeAdvFlashModelWithDict:flashDict];
        [model.flashArr addObject:flashModel];
    }
    arr =[dict objectForKey:@"stores"];
    for (NSDictionary * storeDict in arr) {
        WanShangModel * storeModel =[WanShangModel makeStoresModelWithDict:storeDict];
        [model.storesArr addObject:storeModel];
    }
    
    return model;
}

#pragma mark --私有方法

+(WanShangModel *)makeAreaModelWithDict:(NSDictionary * )dict{
    WanShangModel * model =[[WanShangModel alloc]init];
    model.areaId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"region_name"]];
    model.areaLayer =[NSString stringWithFormat:@"%@",[dict objectForKey:@"layer"]];
    model.areaName =[NSString stringWithFormat:@"%@",[dict objectForKey:@"region_id"]];
    model.areaOrder =[NSString stringWithFormat:@"%@",[dict objectForKey:@"sort_order"]];
    model.areaParentId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"parent_id"]];
    return model;
}

+(WanShangModel *)makeAdvCanModelWithDict:(NSDictionary * )dict{
    WanShangModel * model =[[WanShangModel alloc]init];
    model.advAdvalue =[NSString stringWithFormat:@"%@",[dict objectForKey:@"partner_id"]];
    model.advLogo =[NSString stringWithFormat:@"%@",[dict objectForKey:@"logo"]];
    model.advPositionId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"position_id"]];
    model.advType =[NSString stringWithFormat:@"%@",[dict objectForKey:@"adtype"]];
    model.advFlowers =[NSString stringWithFormat:@"%@",[dict objectForKey:@"flowers"]];
    model.advOthername =[NSString stringWithFormat:@"%@",[dict objectForKey:@"othername"]];
    model.advAdvalue =[NSString stringWithFormat:@"%@",[dict objectForKey:@"advalue"]];
    return model;
}

+(WanShangModel *)makeAdvFlashModelWithDict:(NSDictionary * )dict{
    WanShangModel * model =[[WanShangModel alloc]init];
    model.flashAd_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"ad_id"]];
    model.flashAdtype =[NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
    model.flashAdvalue =[NSString stringWithFormat:@"%@",[dict objectForKey:@"advalue"]];
    model.flashLogo =[NSString stringWithFormat:@"%@",[dict objectForKey:@"logo"]];
    model.flashPrice =[NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
    model.flashTitle =[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    model.flashType_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"type_id"]];
    return model;
}

+(WanShangModel *)makeStoresModelWithDict:(NSDictionary * )dict{
    WanShangModel * model =[[WanShangModel alloc]init];
    model.storeBaind =[NSString stringWithFormat:@"%@",[dict objectForKey:@"bind_status"]];
    model.storeName =[NSString stringWithFormat:@"%@",[dict objectForKey:@"store_name"]];
    model.storeLogo =[NSString stringWithFormat:@"%@",[dict objectForKey:@"store_logo"]];
    model.storeId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"store_id"]];
    model.storeDistance =[NSString stringWithFormat:@"%@",[dict objectForKey:@"distance"]];
    model.storeTel =[NSString stringWithFormat:@"%@",[dict objectForKey:@"tel"]];
    model.storeAddress_ll =[NSString stringWithFormat:@"%@",[dict objectForKey:@"address_ll"]];
    model.storeVoucher_status = [NSString stringWithFormat:@"%@",[dict objectForKey:@"voucher_status"]];
    model.storeHas_change = [NSString stringWithFormat:@"%@",[dict objectForKey:@"has_change"]];
    model.storeHas_free = [NSString stringWithFormat:@"%@",[dict objectForKey:@"has_free"]];
    model.storeHas_join = [NSString stringWithFormat:@"%@",[dict objectForKey:@"has_join"]];
    model.storeHas_prize = [NSString stringWithFormat:@"%@",[dict objectForKey:@"has_prize"]];
    model.storeHas_video = [NSString stringWithFormat:@"%@",[dict objectForKey:@"has_video"]];
    return model;
}
@end
