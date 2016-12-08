
//
//  ZhaoPinModel.m
//  HuaHuaNiu
//
//  Created by alex on 15/10/27.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "ZhaoPinModel.h"

@implementation ZhaoPinModel
+(ZhaoPinModel *)makeListArrModelWith:(NSDictionary *)dict{
    ZhaoPinModel * model =[[ZhaoPinModel alloc]init];
    model.ZhaoPinList =[NSMutableArray array];
    NSArray * arr =[NSArray arrayWithArray:[dict objectForKey:@"list"]];
    for (NSDictionary * tmpDict in arr) {
        ZhaoPinModel * listModel =[ZhaoPinModel makeListModelWith:tmpDict];
        [model.ZhaoPinList addObject:listModel];
    }
    return model;
}

+(ZhaoPinModel *)makeListModelWith:(NSDictionary *)dict{
    ZhaoPinModel * listModel =[[ZhaoPinModel alloc]init];
    listModel.addPrice =[NSString stringWithFormat:@"%@元/月",[dict objectForKey:@"salary"]];
    listModel.title =[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    listModel.addTime =[NSString stringWithFormat:@"%@",[dict objectForKey:@"add_time_x"]];
    listModel.joinNum =[NSString stringWithFormat:@"%@",[dict objectForKey:@"join_num"]];
    listModel.workPlace =[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_place"]];
    listModel.joinId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"join_id"]];
    listModel.pubDate =[NSString stringWithFormat:@"%@",[dict objectForKey:@"pub_date_x"]];
    return listModel;
}

+(ZhaoPinModel *)makeDetailModelWith:(NSDictionary *)dict{
    ZhaoPinModel * model = [[ZhaoPinModel alloc]init];
    model.addPrice =[NSString stringWithFormat:@"%@元/月",[dict objectForKey:@"salary"]];
    model.workYears =[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_years"]];
    model.workPlace =[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_place"]];
    model.addTime =[NSString stringWithFormat:@"%@",[dict objectForKey:@"add_time"]];
    model.joinId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"join_id"]];
    model.browerNum =[NSString stringWithFormat:@"%@",[dict objectForKey:@"brower_num"]];
    model.joinNum =[NSString stringWithFormat:@"%@",[dict objectForKey:@"join_num"]];
    model.title =[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    model.email =[NSString stringWithFormat:@"%@",[dict objectForKey:@"email"]];
    model.workRequirement =[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_requirement"]];
    NSLog(@"%@",model.workRequirement);
    model.education =[NSString stringWithFormat:@"%@",[dict objectForKey:@"education"]];
    model.name =[NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
    model.workQualification =[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_qualification"]];
    model.pubDate =[NSString stringWithFormat:@"%@",[dict objectForKey:@"pub_date"]];
    model.treatment =[NSString stringWithFormat:@"%@",[dict objectForKey:@"treatment"]];
    model.storeLogo =[NSString stringWithFormat:@"%@",[dict objectForKey:@"store_logo"]];
    NSLog(@"%@",model.storeLogo);
    model.storeTel =[NSString stringWithFormat:@"%@",[dict objectForKey:@"store_tel"]];
    model.endDate =[NSString stringWithFormat:@"%@",[dict objectForKey:@"end_date"]];
    model.age =[NSString stringWithFormat:@"%@",[dict objectForKey:@"age"]];
    model.storeName =[NSString stringWithFormat:@"%@",[dict objectForKey:@"store_name"]];


    return model;
}
@end
