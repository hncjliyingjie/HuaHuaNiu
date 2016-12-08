//
//  QiuZhiModel.h
//  HuaHuaNiu
//
//  Created by alex on 15/10/26.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>
//求职详情
/*
 "work_years": "43",
 "apply_join_id": "1",
 "work_place": "5",
 "add_time": "2015-10-18 22:14",

 "brower_num": 0,
 "title": "android ListView详解 - allin.android - 博客园",
 "email": "",
 "name": "lin_6725",
 "work_experience": "两年工作经验咯够不够呢默默哦哦咯哦哦监控默默哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦得得得得得得得得",
 "education": "3",
 "mobile": "15726678530",
 "member_id": "1509200905417220000"
*/

//求职列表
/*
work_years：工作年限（单位：年）
work_place：工作地点
add_time_x：发布时间
apply_join_id：主键
*/

@interface QiuZhiModel : NSObject


//详情
//列表
@property (nonatomic,strong) NSString * workYears;
@property (nonatomic,strong) NSString * workPlace;
@property (nonatomic,strong) NSString * addTime;
@property (nonatomic,strong) NSString * addPrice;
@property (nonatomic,strong) NSString * applyJoinId;
@property (nonatomic,strong) NSMutableArray * QiuzhiList;
//@property (nonatomic,strong) NSString * addTime;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * joinId;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * workExperience;
@property (nonatomic,strong) NSString * education;
@property (nonatomic,strong) NSString * mobile;
@property (nonatomic,strong) NSString * memberId;
@property (nonatomic,strong) NSString * browerNum;



+(QiuZhiModel *)makeListArrModelWith:(NSDictionary *)dict;
+(QiuZhiModel *)makeDetailModelWith:(NSDictionary *)dict;
@end
