//
//  NMCHttp.m
//  sx
//
//  Created by 张金晶 on 16/11/27.
//  Copyright © 2016年 张金晶. All rights reserved.
//

#import "NMCHttp.h"
//用代理和block两种方法从服务器请求数据
@interface NMCHttp ()<NSURLConnectionDataDelegate>
@property (nonatomic , assign) NSURLConnection * connection;
@property (nonatomic, assign) id <NMCHttpDelegate> delegate;
@property (nonatomic , strong) NSMutableData * resultData;
@property (nonatomic , copy) SuccessBlock successBlock;
@property (nonatomic , copy) FailedBlock failedBlock;

@end

@implementation NMCHttp
+ (void)sendHttpRequestWithUrl:(NSString *)url param:(NSDictionary *)paramDict delegate:(id<NMCHttpDelegate>)delegate{
    NMCHttp * http = [NMCHttp new];
    
    [http sendHttpRequesWithUrl:url param:paramDict delegate:delegate];
    
}
//get
- (void)sendHttpRequesWithUrl:(NSString *)url param:(NSDictionary *)paramDict delegate:(id<NMCHttpDelegate>)delegate{
    
    _delegate = delegate;
    NSURL * urlT = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",url,[self paramStr:paramDict]]];
    NSURLRequest * request = [NSURLRequest requestWithURL:urlT];
    
    _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}
//post

- (void)sendPostHttpRequestWithUrl:(NSString *)url param:(NSDictionary *)paramDict delegate:(id<NMCHttpDelegate>)delegate{
    
}
//block的回调
- (void)sendHttpGetRequestWithUrl:(NSString *)url param:(NSDictionary *)paramDict successBlock:(SuccessBlock)successBlock failedBlock:(FailedBlock)failedBlock{
    _successBlock = successBlock;
    _failedBlock = failedBlock;
    NSURL * urlT = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",url,[self paramStr:paramDict]]];
    NSURLRequest * request = [NSURLRequest requestWithURL:urlT];
    _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

//如果传递的有个参数的话 把这个参数拼接到http当中，bottm is dictionary -> nssstring
- (NSString *)paramStr:(NSDictionary *)paramDict{
    NSMutableArray * reult = [NSMutableArray new];
    for (NSString * item in paramDict) {
        NSString * temp = [NSString stringWithFormat:@"%@=%@",item,[paramDict objectForKey:item]];
        [reult addObject:temp];
        
    }
    return  [reult componentsJoinedByString:@"&"];
    
}
//开始请求数据
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _resultData = [NSMutableData new];
}
//请求数据完成
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //添加数据
    [_resultData appendData:data];
}
//请求数据完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"回调成功了");
    if(_delegate && [_delegate respondsToSelector:@selector(requestSuccess:)]){
        [self.delegate requestSuccess:_resultData];
    }
    
    if(_successBlock){
        _successBlock(_resultData);
    }
}

//请求数据失败

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"回调失败了");
    if(_delegate && [_delegate respondsToSelector:@selector(failWithError:)]){
        [self.delegate requestFailedBlock:error];
    }
    if(_failedBlock){
        _failedBlock(error);
    }
}


@end
