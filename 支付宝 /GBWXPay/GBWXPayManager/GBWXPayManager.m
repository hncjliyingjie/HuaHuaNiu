//
//  GBWXPayManager.m
//  微信支付
//
//  Created by 张国兵 on 15/7/25.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "GBWXPayManager.h"

@interface GBWXPayManager()

@end

@implementation GBWXPayManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static GBWXPayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[GBWXPayManager alloc] init];
        
    });
    return instance;
}

/**
 *  针对多个商户的支付
 *
 *  @param orderID    支付订单号
 *  @param orderTitle 订单的商品描述
 *  @param amount     订单总额
 *  @param notifyURL  支付结果异步通知
 *  @param seller     商户号（收款账号）
 */
+(void)wxpayWithOrderID:(NSString*)orderID
             orderTitle:(NSString*)orderTitle
                 amount:(NSString*)amount
               sellerID:(NSString *)sellerID
                  appID:(NSString*)appID
              partnerID:(NSString*)partnerID{
    //微信支付的金额单位是分转化成我们比较常用的'元'
    
    NSString*realPrice=[NSString stringWithFormat:@"%.f",amount.floatValue*100];
    
    if(realPrice.floatValue<=0){
        return;
    }
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:appID mch_id:sellerID];
    //设置密钥
    [req setKey:partnerID];
    
//    GBWXPayManager *manager = [[GBWXPayManager alloc] init];
//    manager.orderId = orderID;
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo:orderID title:orderTitle price: realPrice];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
        
    }
    
}
/**
 *  单一用户
 *
 *  @param orderID    支付订单号
 *  @param orderTitle 订单的商品描述
 *  @param amount     订单总额
 */



+(void)wxpayWithOrderID:(NSString*)orderID
             orderTitle:(NSString*)orderTitle
                 amount:(NSString*)amount{
    //微信支付的金额单位是分转化成我们比较常用的'元'
    NSString*realPrice=[NSString stringWithFormat:@"%.f",amount.floatValue*100];
  
    if(realPrice.floatValue<=0){
        return;
    }
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
//    GBWXPayManager *manager = [[GBWXPayManager alloc] init];
//    manager.orderId = orderID;
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo:orderID title:orderTitle price: realPrice];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
        
    }
}


//客户端提示信息
+ (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK++++" otherButtonTitles:nil];
    
    [alter show];
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
//    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
//        if (_delegate
//            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)]) {
//            SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
//            [_delegate managerDidRecvMessageResponse:messageResp];
//        }
//    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
//        if (_delegate
//            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)]) {
//            SendAuthResp *authResp = (SendAuthResp *)resp;
//            [_delegate managerDidRecvAuthResponse:authResp];
//        }
//    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
//        if (_delegate
//            && [_delegate respondsToSelector:@selector(managerDidRecvAddCardResponse:)]) {
//            AddCardToWXCardPackageResp *addCardResp = (AddCardToWXCardPackageResp *)resp;
//            [_delegate managerDidRecvAddCardResponse:addCardResp];
//        }
//    }else
    
    
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
            {
                //调用回调的数据
//                NSString * resquestUrl = [NSString stringWithFormat:@"http://daiyancheng.cn/apporder/order_pay_success.do?token=test&order_id=%@order_type=%@",self.orderId,@"1"];
                NSString * resquestUrl = [NSString stringWithFormat:ZHIFUHD,self.orderId,@"1"];
                
                NSLog(@"微信回调数据%@",resquestUrl);
                
                [[RequestManger share] requestDataByGetWithPath:resquestUrl complete:^(NSDictionary *data) {
                    NSLog(@"%@",[data objectForKey:@"result"]);
                    NSLog(@"%@",[data objectForKey:@"msg"]);
                }];
            }
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

- (void)onReq:(BaseReq *)req {
    NSLog(@"支付成功");
//    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
//        if (_delegate
//            && [_delegate respondsToSelector:@selector(managerDidRecvGetMessageReq:)]) {
//            GetMessageFromWXReq *getMessageReq = (GetMessageFromWXReq *)req;
//            [_delegate managerDidRecvGetMessageReq:getMessageReq];
//        }
//    } else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
//        if (_delegate
//            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)]) {
//            ShowMessageFromWXReq *showMessageReq = (ShowMessageFromWXReq *)req;
//            [_delegate managerDidRecvShowMessageReq:showMessageReq];
//        }
//    } else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
//        if (_delegate
//            && [_delegate respondsToSelector:@selector(managerDidRecvLaunchFromWXReq:)]) {
//            LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
//            [_delegate managerDidRecvLaunchFromWXReq:launchReq];
//        }
//    }
}

@end
