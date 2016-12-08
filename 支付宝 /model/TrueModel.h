//
//  TrueModel.h
//  HuaHuaNiu
//
//  Created by alex on 15/9/16.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrueModel : NSObject
@property (nonatomic,copy) NSString * region_name ;
@property (nonatomic,copy) NSString * layer ;
@property (nonatomic,copy) NSString * region_id ;
@property (nonatomic,copy) NSString * sort_order ;
@property (nonatomic,copy) NSString * parent_id ;

@property (nonatomic,copy) NSString * totalPage ;
@property (nonatomic,copy) NSString * totalCount ;

@property (nonatomic,copy) NSString * end_date ;
@property (nonatomic,copy) NSString * num ;
@property (nonatomic,copy) NSString * price ;
@property (nonatomic,copy) NSString * total_num ;
@property (nonatomic,copy) NSString * status ;
@property (nonatomic,copy) NSString * goods_id ;
@property (nonatomic,copy) NSString * gf_id ;
@property (nonatomic,copy) NSString * store_id ;
@property (nonatomic,copy) NSString * goods_name ;
@property (nonatomic,copy) NSString * default_image ;
@property (nonatomic,copy) NSString * start_date ;
@property (nonatomic,copy) NSString * store_name ;
@property (nonatomic,copy) NSString * brand_name ;
@property (nonatomic,copy) NSString * summary ;


@property (nonatomic,strong) NSMutableArray * goodsArr;
@property (nonatomic,strong) NSMutableArray * areaArr;

+(TrueModel *)makeModelWithDict:(NSDictionary * )dict;

@end
