//
//  RequestManger.m
//  MeiPinJie
//
//  Created by mac on 15/8/19.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "RequestManger.h"
#import "AFNetworking.h"
@implementation RequestManger{
    NSMutableData * _backData;
}
+(RequestManger *)share{
    static RequestManger * manger = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manger =[[RequestManger alloc]init];
    });
    return manger;
}
//异步 post
-(void)requestDataByPostWithPath:(NSString *)path dictionary:(NSDictionary *)dict complete:(void(^)(NSDictionary * data))complete{
    AFHTTPRequestOperationManager * manger =[AFHTTPRequestOperationManager manager];
//    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSString * cookie = [[NSUserDefaults standardUserDefaults]objectForKey:@"Set-Cookie"];
    [manger.requestSerializer setValue:cookie forHTTPHeaderField:@"Set-Cookie"];
    [manger POST:path parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response respondsToSelector:@selector(allHeaderFields)]) {
            NSDictionary *dicitonary = [operation.response allHeaderFields];
            id cookie = [dicitonary objectForKey:@"Set-Cookie"];
            [[NSUserDefaults standardUserDefaults]setObject:cookie forKey:@"Set-Cookie"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        complete(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary * dic =[NSDictionary dictionaryWithObjectsAndKeys:error,@"error", nil];
        complete(dic);
    }];
}
//get
-(void)requestDataByGetWithPath:(NSString *)path complete:(void(^)(NSDictionary * data))complete{
    AFHTTPRequestOperationManager * manger =[AFHTTPRequestOperationManager manager];
//    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"text/html",nil];
    [manger GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        complete(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary * dic =[NSDictionary dictionaryWithObjectsAndKeys:error,@"error", nil];
        complete(dic);
    }];
}

//同步
-(void)requestDataAtMainWithPath:(NSString *)path{
    _backData =[NSMutableData data];
    NSURLRequest * request =[NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark --RequestDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.block(@"start",nil);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_backData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    self.block(@"finish",_backData);
    
}
@end
