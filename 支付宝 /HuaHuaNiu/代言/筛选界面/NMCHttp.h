//
//  NMCHttp.h
//  sx
//
//  Created by 张金晶 on 16/11/27.
//  Copyright © 2016年 张金晶. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSData * data);
typedef void (^FailedBlock)(NSError * error);

@protocol NMCHttpDelegate <NSObject>

- (void)requestSuccess:(NSData *)data;
- (void)requestFailedBlock:(NSError *)error;
@end

@interface NMCHttp : NSObject

+ (void)sendHttpRequestWithUrl:(NSString *)url param:(NSDictionary *)paramDict delegate:(id<NMCHttpDelegate>)delegate;

//代理回调
- (void)sendHttpRequesWithUrl:(NSString *)url param:(NSDictionary *)paramDict delegate:(id<NMCHttpDelegate>)delegate;
//block回调
- (void)sendHttpGetRequestWithUrl:(NSString *)url param:(NSDictionary *)paramDict successBlock:(SuccessBlock)successBlock failedBlock:(FailedBlock)failedBlock;

@end
