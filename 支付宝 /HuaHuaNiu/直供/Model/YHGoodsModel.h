//
//  YHGoodsModel.h
//  花花牛
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHGoodsModel : NSObject
@property (nonatomic,strong) NSString *add_time;
@property (nonatomic,strong) NSString *brand_name;
@property (nonatomic,strong) NSString *default_image;
@property (nonatomic,strong) NSString *goods_id;
@property (nonatomic,strong) NSString *goods_name;
@property (nonatomic,strong) NSString *is_close;
@property (nonatomic,strong) NSString *is_show;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *original_price;
@property (nonatomic,strong) NSString *recommended;
@property (nonatomic,strong) NSString *selled_num;
@property (nonatomic,strong) NSString *store_id;
@property (nonatomic,strong) NSString *store_name;
@property (nonatomic,strong) NSString *type_id;
@property (nonatomic,strong) NSString *type_name;
@property (nonatomic,strong) NSString *wholesale_give_integral;
@property (nonatomic,assign) NSString *change_type;
@property (nonatomic,strong) NSString *distance;
@property (nonatomic,strong) NSString *has_lookers;

@property (nonatomic,strong) NSString *sale_integral;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
