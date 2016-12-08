//
//  TrueModel.m
//  HuaHuaNiu
//
//  Created by alex on 15/9/16.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "TrueModel.h"

@implementation TrueModel
+(TrueModel *)makeModelWithDict:(NSDictionary *)dict{
    NSLog(@"trueModel =%@",[dict objectForKey:@"msg"]);
    TrueModel * model =[[TrueModel alloc]init];
    model.areaArr =[NSMutableArray array];
    model.goodsArr =[NSMutableArray array];
    model.totalCount =[NSString stringWithFormat:@"%@",[dict objectForKey:@"totalCount"]];
    model.totalPage =[NSString stringWithFormat:@"%@",[dict objectForKey:@"totalPage"]];
    NSArray * arr =[NSArray array];
    arr =  [dict objectForKey:@"area"];
    for (NSDictionary * tmpDict in arr) {
        TrueModel * areaModel =[TrueModel makeAreaModelWith:tmpDict];
        [model.areaArr addObject:areaModel];
    }
    arr =[dict objectForKey:@"goods"];
    for (NSDictionary * tmpDict in arr) {
        TrueModel * goodsModel =[TrueModel makeGoodsModelWith:tmpDict];
        [model.goodsArr addObject:goodsModel];
    }
    return model;
}


+(TrueModel *)makeAreaModelWith:(NSDictionary *)dict{
    TrueModel * model =[[TrueModel alloc]init];
    model.region_name =[NSString stringWithFormat:@"%@",[dict objectForKey:@"region_name"]];
    model.layer =[NSString stringWithFormat:@"%@",[dict objectForKey:@"layer"]];
    model.region_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"region_id"]];
    model.sort_order =[NSString stringWithFormat:@"%@",[dict objectForKey:@"sort_order"]];
    model.parent_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"parent_id"]];

    return model;
}

+(TrueModel *)makeGoodsModelWith:(NSDictionary *)dict{
    TrueModel * model =[[TrueModel alloc]init];
    model.end_date =[NSString stringWithFormat:@"%@",[dict objectForKey:@"end_date"]];
    model.num =[NSString stringWithFormat:@"%@",[dict objectForKey:@"num"]];
    model.price =[NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
    model.total_num =[NSString stringWithFormat:@"%@",[dict objectForKey:@"total_num"]];
    model.status =[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]];
    model.goods_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"goods_id"]];
    model.gf_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"gf_id"]];
    model.store_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"store_id"]];
    model.goods_name =[NSString stringWithFormat:@"%@",[dict objectForKey:@"goods_name"]];
    model.default_image =[NSString stringWithFormat:@"%@",[dict objectForKey:@"default_image"]];
    model.start_date =[NSString stringWithFormat:@"%@",[dict objectForKey:@"start_date"]];
    model.store_name =[NSString stringWithFormat:@"%@",[dict objectForKey:@"store_name"]];
    model.brand_name =[NSString stringWithFormat:@"%@",[dict objectForKey:@"brand_name"]];
    model.summary =[NSString stringWithFormat:@"%@",[dict objectForKey:@"introduce"]];


    
    return model;
}


@end
