//
//  Secondermodel.h
//  HuaHuaNiu
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeconderViewModel.h"

@interface Secondermodel : NSObject

/*
 msg = "\U67e5\U8be2\U5931\U8d25";
 result = 0;
 totalCount = 0;
 totalPage = 0;
 
 */
@property (nonatomic,assign) int *result;
@property (nonatomic,assign) int *totalCount;
@property (nonatomic,strong) NSString *msg;

@property (nonatomic,assign) int *totalPage;

/////////////////////////
@property (nonatomic,assign) int *currentPage;


+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
