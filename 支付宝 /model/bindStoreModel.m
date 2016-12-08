//
//  bindStoreModel.m
//  HuaHuaNiu
//
//  Created by alex on 15/9/15.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "bindStoreModel.h"

@implementation bindStoreModel
+(bindStoreModel *)makeModelWithDict:(NSDictionary *)dict{
    bindStoreModel *model =[[bindStoreModel alloc]init];
    model.bindStoreArr =[NSMutableArray array];
    
    model.totalCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"totalCount"]];
    model.totalPage = [NSString stringWithFormat:@"%@",[dict objectForKey:@"totalPage"]];
    NSArray * arr =[NSArray arrayWithArray:[dict objectForKey:@"stores"]];
    for (NSDictionary * tmpDict in arr) {
        bindStoreModel * storeModel = [bindStoreModel makeStoreModelWithDict:tmpDict];
        [model.bindStoreArr addObject:storeModel];
    }
    return model;
}

+(bindStoreModel *)makeStoreModelWithDict:(NSDictionary * )dict{
    bindStoreModel * model =[[bindStoreModel alloc]init];
    model.voucher_status = [NSString stringWithFormat:@"%@",[dict objectForKey:@"voucher_status"]];
    model.has_change = [NSString stringWithFormat:@"%@",[dict objectForKey:@"has_change"]];
    model.has_free = [NSString stringWithFormat:@"%@",[dict objectForKey:@"has_free"]];
    model.has_join = [NSString stringWithFormat:@"%@",[dict objectForKey:@"has_join"]];
    model.has_prize = [NSString stringWithFormat:@"%@",[dict objectForKey:@"has_prize"]];
    model.has_video = [NSString stringWithFormat:@"%@",[dict objectForKey:@"has_video"]];
    model.bind_days = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bind_days"]];
    model.cate_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"cate_id"]];
    model.store_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"store_id"]];
    model.store_logo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"store_logo"]];
    model.bind_need_flower = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bind_need_flower"]];
    model.store_name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"store_name"]];
    model.bind_status = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bind_status"]];
    return model;
}
@end
