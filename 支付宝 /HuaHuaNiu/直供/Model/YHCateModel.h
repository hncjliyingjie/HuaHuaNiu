//
//  YHCateModel.h
//  花花牛
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHCateModel : NSObject
@property (nonatomic,strong) NSString *value;

@property (nonatomic,strong) NSString *parentid;
@property (nonatomic,strong) NSString *item_code;
@property (nonatomic,strong) NSString *cate_id;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
