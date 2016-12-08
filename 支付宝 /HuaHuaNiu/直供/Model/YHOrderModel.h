//
//  YHOrderModel.h
//  花花牛
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHOrderModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *value;

@property (nonatomic,strong) NSString *parentid;
@property (nonatomic,strong) NSString *item_code;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
