//
//  QiuZhiModel.m
//  HuaHuaNiu
//
//  Created by alex on 15/10/26.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "QiuZhiModel.h"

@implementation QiuZhiModel

+(QiuZhiModel *)makeListArrModelWith:(NSDictionary *)dict{
    QiuZhiModel * model =[[QiuZhiModel alloc]init];
    model.QiuzhiList =[[NSMutableArray alloc]init];
    NSArray * arr =[NSArray arrayWithArray:[dict objectForKey:@"list"]];
    if (arr!=nil) {
    for (NSDictionary * dict in arr) {
        QiuZhiModel * qiuzhiModel=[QiuZhiModel makeListModelWith:dict];
        
        [model.QiuzhiList addObject:qiuzhiModel];
    }
    }
    return model;
}
//@"name",tf1.text,@"sex",tf2.text,@"age",tf3.text,@"title",tf4.text,@"salary",tf5.text,@"mobile",tf6.text,@"work_experience",tf7.text,@"remark"
+(QiuZhiModel *)makeListModelWith:(NSDictionary *)dict{
    QiuZhiModel * model =[[QiuZhiModel alloc]init];
    model.workYears =[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_years"]];
    model.workPlace =[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_place"]];
    model.addTime =[NSString stringWithFormat:@"%@",[dict objectForKey:@"add_time_x"]];
    model.addPrice =[NSString stringWithFormat:@"期望薪资：%@元/月",[dict objectForKey:@"salary"]];
    model.applyJoinId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"apply_join_id"]];
    model.title =[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    model.name =[NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
    model.joinId=[NSString stringWithFormat:@"%@",[dict objectForKey:@"join_id"]];
    return model;
    
}


+(QiuZhiModel *)makeDetailModelWith:(NSDictionary *)dict{
    QiuZhiModel * model =[[QiuZhiModel alloc]init];
    model.addPrice =[NSString stringWithFormat:@"期望薪资：%@",[dict objectForKey:@"salary"]];
    model.workYears =[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_years"]];
    model.workPlace =[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_place"]];
    model.addTime =[NSString stringWithFormat:@"%@",[dict objectForKey:@"add_time_x"]];
    model.applyJoinId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"workapply_join_idYears"]];
    model.browerNum =[NSString stringWithFormat:@"%@",[dict objectForKey:@"brower_num"]];
    model.title =[NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    model.email =[NSString stringWithFormat:@"%@",[dict objectForKey:@"email"]];
    model.workExperience =[NSString stringWithFormat:@"%@",[dict objectForKey:@"work_experience"]];
    model.education =[NSString stringWithFormat:@"%@",[dict objectForKey:@"education"]];
    model.mobile =[NSString stringWithFormat:@"%@",[dict objectForKey:@"mobile"]];
    model.memberId =[NSString stringWithFormat:@"%@",[dict objectForKey:@"member_id"]];
    model.name =[NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];

    return model;
}
@end
