//
//  bindStoreModel.h
//  HuaHuaNiu
//
//  Created by alex on 15/9/15.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bindStoreModel : NSObject
//绑定商家
@property (nonatomic,copy) NSString * totalCount ;
@property (nonatomic,copy) NSString * totalPage ;

@property (nonatomic,copy) NSString * voucher_status ;
@property (nonatomic,copy) NSString * has_change ;
@property (nonatomic,copy) NSString * has_free ;
@property (nonatomic,copy) NSString * has_join ;
@property (nonatomic,copy) NSString * has_prize ;
@property (nonatomic,copy) NSString * has_video ;
@property (nonatomic,copy) NSString * bind_days ;
@property (nonatomic,copy) NSString * cate_id ;
@property (nonatomic,copy) NSString * store_id ;
@property (nonatomic,copy) NSString * store_logo ;
@property (nonatomic,copy) NSString * bind_need_flower ;
@property (nonatomic,copy) NSString * store_name ;
@property (nonatomic,copy) NSString * bind_status ;
@property (nonatomic,strong) NSMutableArray * bindStoreArr;
+(bindStoreModel *)makeModelWithDict:(NSDictionary *)dict;
@end
