//
//  AlexModel.m
//  HuaHuaNiu
//
//  Created by alex on 15/9/1.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "AlexModel.h"

@implementation AlexModel
-(instancetype)init{
    if (self =[super init]) {
    }
    return self;
}

+(AlexModel *)makeMainModelWithDict:(NSDictionary *)dict{
    AlexModel * model =[[AlexModel alloc]init];
    model.arceArr =[NSMutableArray array];
    model.bouArr  =[NSMutableArray array];
    model.flashArr =[NSMutableArray array];
    model.funArr =[NSMutableArray array];
    model.nearArr =[NSMutableArray array];
    model.sameArr =[NSMutableArray array];

    model.result  = [dict objectForKey:@"result"];
    model.current = [dict objectForKey:@"current"];
    
    NSArray * arr= [NSArray array];
    
    arr = [dict objectForKey:@"area"];
    for (NSDictionary * areaDict in arr) {
        AlexModel * areaModel = [AlexModel makeAreaModelWithDict:areaDict];
        [model.arceArr addObject:areaModel];
    }
    arr =[dict objectForKey:@"boutique"];
    for (NSDictionary * bouDict in arr) {
        AlexModel * bouModel =[AlexModel makeBouModelWithDict:bouDict];
        [model.bouArr addObject:bouModel];
    }
    arr =[dict objectForKey:@"flash"];
    for (NSDictionary * flashDict in arr) {
        AlexModel * flashModel =[AlexModel makeFlashModelWithDict:flashDict];
        [model.flashArr addObject:flashModel];
    }
    arr =[dict objectForKey:@"functions"];
    for (NSDictionary * funDict in arr) {
        AlexModel * funModel =[AlexModel makeFunModelWithDict:funDict];
        [model.funArr addObject:funModel];
    }
    
    arr =[dict objectForKey:@"samecity"];

    for (NSDictionary * sameDict in arr) {
        AlexModel * sameModel =[AlexModel makeSameModelWithDict:sameDict];
        [model.sameArr addObject:sameModel];
    }
    arr =[dict objectForKey:@"living_near"];

    for (NSDictionary * nearDict in arr) {
        AlexModel * nearModel =[AlexModel makeNearModelWithDict:nearDict];
        [model.nearArr addObject:nearModel];
    }

    return model;
}

+(AlexModel *)makeFunsModelWithDict:(NSDictionary *)dict{
    AlexModel * model =[[AlexModel alloc]init];
    
    NSDictionary * tmpDict =[dict objectForKey:@"account"];
    
    float n = [[tmpDict objectForKey:@"total_money"] floatValue];
    n = n * 100;
    int b =(int)n;
    model.total_money =[NSString stringWithFormat:@"%d",b];
    NSLog(@"%@",model.total_money);
    
    
    n = [[tmpDict objectForKey:@"y_addmoney"] floatValue];
    n = n * 100;
    b =(int)n;
    model.y_addmoney =[NSString stringWithFormat:@"%d",b];

    
    tmpDict =[dict objectForKey:@"flower"];
    model.y_addflower =[NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"y_addflower"]];
    model.total_flower =[NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"total_flower"]];
    
    tmpDict =[dict objectForKey:@"flower_basket"];
    model.total_flower_basket =[NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"total_flower_basket"]];
    model.y_addflower_basket =[NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"y_addflower_basket"]];
    
    tmpDict =[dict objectForKey:@"myfans"];
    model.y_addfuns =[NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"y_addfuns"]];
    model.indirect_funs =[NSString stringWithFormat:@"%d",[[tmpDict objectForKey:@"indirect_funs"] intValue] +[[tmpDict objectForKey:@"direct_funs"] intValue]];
    model.direct_funs =[NSString stringWithFormat:@"%@",[tmpDict objectForKey:@"direct_funs"]];
    
    return model;
}

+(AlexModel *)makeBindsModelWithDict:(NSDictionary *)dict{
    AlexModel * model =[[AlexModel alloc]init];
    model.bindArr = [NSMutableArray array];
    NSArray * arr =[NSArray arrayWithArray:[dict objectForKey:@"binds"]];
    for (NSDictionary * bindDict in arr) {
        AlexModel * bindModel =[AlexModel makeBindModelWithDict:bindDict];
        [model.bindArr addObject:bindModel];
    }
    return model;
}

#pragma mark --私有方法
+(AlexModel *)makeAreaModelWithDict:(NSDictionary * )dict{
    
    AlexModel * model =[[AlexModel alloc]init];
    model.arceId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"region_id"]];
    model.arceValue =[NSString stringWithFormat:@"%@",[dict objectForKey:@"region_name"]];
    return model;
    
}

+(AlexModel *)makeBouModelWithDict:(NSDictionary * )dict{
    AlexModel * model =[[AlexModel alloc]init];
    model.boutiqueTitle =[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    model.boutiquePrice =[NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
    model.boutiqueLogo =[NSString stringWithFormat:@"%@",[dict objectForKey:@"logo"]];
    model.boutiqueId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"advalue"]];
    return model;
}

+(AlexModel *)makeFlashModelWithDict:(NSDictionary * )dict{
    AlexModel * model =[[AlexModel alloc]init];
    model.flashId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"advalue"]];
    model.flashType =[NSString stringWithFormat:@"%@",[dict objectForKey:@"adtype"]];
    model.flashLogo =[NSString stringWithFormat:@"%@",[dict objectForKey:@"logo"]];
    model.flashType_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"type_id"]];
    model.flashad_id =[NSString stringWithFormat:@"%@",[dict objectForKey:@"ad_id"]];
    return model;
}

+(AlexModel *)makeFunModelWithDict:(NSDictionary * )dict{
    AlexModel * model =[[AlexModel alloc]init];
    model.funTitle =[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    model.funLogo =[NSString stringWithFormat:@"%@",[dict objectForKey:@"logo"]];
    return model;
}

+(AlexModel *)makeNearModelWithDict:(NSDictionary * )dict{
    AlexModel * model =[[AlexModel alloc]init];
    model.nearId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"advalue"]];
    model.nearlogo =[NSString stringWithFormat:@"%@",[dict objectForKey:@"logo"]];
    model.nearPhone =[NSString stringWithFormat:@"%@",[dict objectForKey:@"bindphone"]];
    model.nearStatus =[NSString stringWithFormat:@"%@",[dict objectForKey:@"bind_status"]];
    model.nearTitle =[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    return model;
}

+(AlexModel *)makeSameModelWithDict:(NSDictionary * )dict{
    AlexModel * model =[[AlexModel alloc]init];
    model.sameId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"advalue"]];
    model.sameLogo =[NSString stringWithFormat:@"%@",[dict objectForKey:@"logo"]];
    model.samePrice =[NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
    model.sameTitle =[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    model.sameType =[NSString stringWithFormat:@"%@",[dict objectForKey:@"adtype"]];
    return model;
}

+(AlexModel *)makeBindModelWithDict:(NSDictionary * )dict{
    AlexModel * model =[[AlexModel alloc]init];
    model.bind_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bind_id"]];
    model.money = [NSString stringWithFormat:@"%@",[dict objectForKey:@"money"]];
    model.store_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"store_id"]];
    model.store_logo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"store_logo"]];
    model.store_name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"store_name"]];
    model.start_date   = [NSString stringWithFormat:@"%@",[dict objectForKey:@"start_date"]];
    model.end_date = [NSString stringWithFormat:@"%@",[dict objectForKey:@"end_date"]];
    model.surplus_days = [NSString stringWithFormat:@"%@",[dict objectForKey:@"surplus_days"]];
    model.bind_days = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bind_days"]];
    model.bind_need_flower = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bind_need_flower"]];

    return model;
}


@end
