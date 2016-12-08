//
//  RequestManger.h
//  MeiPinJie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^requestDataBlock)(NSString * info,NSMutableData * backData);
@interface RequestManger : NSObject<NSURLConnectionDataDelegate>
@property (nonatomic,copy) requestDataBlock block;
+(RequestManger *)share;

-(void)requestDataByPostWithPath:(NSString *)path dictionary:(NSDictionary *)dict complete:(void(^)(NSDictionary * data))complete;

-(void)requestDataByGetWithPath:(NSString *)path complete:(void(^)(NSDictionary * data))complete;

-(void)requestDataAtMainWithPath:(NSString *)path;
@end
