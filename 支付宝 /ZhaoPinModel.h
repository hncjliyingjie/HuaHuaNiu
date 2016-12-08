//
//  ZhaoPinModel.h
//  HuaHuaNiu
//
//  Created by alex on 15/10/27.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhaoPinModel : NSObject
//详情
//列表
@property (nonatomic,strong) NSMutableArray * ZhaoPinList;

@property (nonatomic,strong) NSString * workYears;
@property (nonatomic,strong) NSString * workQualification;
@property (nonatomic,strong) NSString * pubDate;
@property (nonatomic,strong) NSString * treatment;
@property (nonatomic,strong) NSString * storeLogo;
@property (nonatomic,strong) NSString * education;
@property (nonatomic,strong) NSString * joinId;
@property (nonatomic,strong) NSString * workRequirement;
@property (nonatomic,strong) NSString * storeTel;
@property (nonatomic,strong) NSString * endDate;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * addPrice;
@property (nonatomic,strong) NSString * browerNum;
@property (nonatomic,strong) NSString * joinNum;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSString * age;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * workPlace;
@property (nonatomic,strong) NSString * addTime;
@property (nonatomic,strong) NSString * storeName;


@property (nonatomic,strong) NSString * workExperience;
@property (nonatomic,strong) NSString * mobile;
@property (nonatomic,strong) NSString * memberId;
@property (nonatomic,strong) NSString * salary;

+(ZhaoPinModel *)makeListArrModelWith:(NSDictionary *)dict;
+(ZhaoPinModel *)makeDetailModelWith:(NSDictionary *)dict;

@end
