//
//  HGFindModel.h
//  HiGo
//
//  Created by Think_lion on 15/7/27.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HGGoodsInfoModel,HGGoodsMainImageModel;

@interface HGFindModel : NSObject

@property (nonatomic,copy) NSString *add_time_x;  //发布时间
@property (nonatomic,copy) NSString *comment_num; //回复数
@property (nonatomic,copy) NSString *img_path;    //视频配图 战士列表用到
@property (nonatomic,copy) NSString *member_name; //会员名字
@property (nonatomic,copy) NSString *on_lookers;  //围观数
@property (nonatomic,copy) NSString *path;        //视频路径
@property (nonatomic,copy) NSString *store_id;    //店ID
@property (nonatomic,copy) NSString *store_name;  //店名字
@property (nonatomic,copy) NSString *title;       //标题
@property (nonatomic,copy) NSString *video_id;    //视频ID


//分组信息的模型
@property (nonatomic,strong)  HGGoodsInfoModel *group_info;

//主图片的模型
@property (nonatomic,strong) HGGoodsMainImageModel  *main_image;

@end
