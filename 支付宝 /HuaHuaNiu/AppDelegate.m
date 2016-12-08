 //
//  AppDelegate.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-2-4.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"

#import "ThirdViewController.h"
#import "LastViewController.h"
#import "ComeHomeViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "WanShangViewController.h"
#import "UMSocialQQHandler.h"

#import "BMapKit.h"
#import "Reachability.h"
#import <AlipaySDK/AlipaySDK.h>
#import "RootTbaarViewController.h"
#import "WXApi.h"
//#import "WXApiManager.h"
#import "GBWXPayManager.h"
#import "SendMsgToWeChatViewController.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options{
   
//   return  [UMSocialSnsService handleOpenURL:url];
   //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开发包
   
   if ([url.host isEqualToString:@"safepay"]) {
      [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                standbyCallback:^(NSDictionary *resultDic) {
                                                   NSLog(@"result = %@",resultDic);
                                                }]; }
   if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
      [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
         NSLog(@"result = %@",resultDic);
      }];
   }
   if ([[url absoluteString] rangeOfString:@"wx"].length == 2) {
      BOOL *isZhifu = [WXApi handleOpenURL:url delegate:[GBWXPayManager sharedManager]];
//      if (isZhifu) {
//         //修改订单状态
//         
//      }
      return isZhifu;
   }else{
      return  [UMSocialSnsService handleOpenURL:url];
   }
  
   
}

/**
 *  ios9以后废弃
 *
 *  @param BOOL <#BOOL description#>
 *
 *  @return <#return value description#>
 */
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return  [UMSocialSnsService handleOpenURL:url];
//}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
   return  [WXApi handleOpenURL:url delegate:[GBWXPayManager sharedManager]];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{

    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开发包
   
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      NSLog(@"result = %@",resultDic);
                                                  }]; }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
//    return YES;
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
   return [WXApi handleOpenURL:url delegate:[GBWXPayManager sharedManager]];
  
   
}

- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    BOOL connectionRequired = [curReach connectionRequired];
   
    if ( connectionRequired) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"没有网络"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
       
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

   //使用友盟
  
#warning --------------提示音
//   NSString *path = [[NSBundle mainBundle] pathForResource:@"代言城原" ofType:@"mp3"];
//   SystemSoundID soundID;
//   
//   AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
//   AudioServicesPlaySystemSound (soundID);
   //隐藏状态栏
//    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
//   [[UIApplication sharedApplication]setStatusBarHidden:true];
    // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    hostReach = [Reachability reachabilityWithHostName:@"http://www.daiyancheng.com"];
    [hostReach startNotifier];
    
    //  百度地图
     _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"FsD5EFgd414Ek1CAukQpRM9k"  generalDelegate:nil];
   
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    [UMSocialData setAppKey:@"5507c758fd98c5cdd1000244"];
//   [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;    
   
   [UMSocialQQHandler setQQWithAppId:@"1104793031" appKey:@"ARm7m0mylEInwZhO" url:FenXiangLJ];
   
   [UMSocialQQHandler setQQWithAppId:@"1104793031" appKey:@"ARm7m0mylEInwZhO" url:FenXiangshLJ];
   
   [UMSocialQQHandler setQQWithAppId:@"1104868342" appKey:@"RtsCxH1M9XTpqPwR" url:@"http://www.baidu.com"];
   
    [UMSocialWechatHandler setWXAppId:@"wx396076a20ac96cdb" appSecret:@"3c3e03f8d9a0240aab53d9205f407d7a" url:FenXiangshLJ];
   [UMSocialWechatHandler setWXAppId:@"wx396076a20ac96cdb" appSecret:@"3c3e03f8d9a0240aab53d9205f407d7a" url:FenXiangLJ];
   
   //第一个参数为新浪appkey,第二个参数为新浪secret，第三个参数是新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
//   [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:WBShareAppKey
//                                             secret:WBShareAppSecret
//                                        RedirectURL:@"http://sns.whalecloud.com"];
   //设置新浪的appKey和appSecret
//   [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
   
    [WXApi registerApp:@"wx396076a20ac96cdb" withDescription:@"代言城"];
    
    RootTbaarViewController * rovc =[[RootTbaarViewController alloc]init];
 
    self.window.rootViewController =rovc;
   
   [self enableIQKeyboardManager];
   
   //在授权完成后调用获取用户信息的方法
   
   

#pragma mark 设置功能介绍图

    return YES;
}
#pragma mark - 微信支付回调
-(void) onResp:(BaseResp*)resp
{
   NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
   NSString *strTitle;
   
   if([resp isKindOfClass:[SendMessageToWXResp class]])
   {
      strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
   }
   if([resp isKindOfClass:[PayResp class]]){
      //支付返回结果，实际支付结果需要去微信服务器端查询
      strTitle = [NSString stringWithFormat:@"支付结果"];
      
      switch (resp.errCode) {
         case WXSuccess:
            strMsg = @"支付结果：成功！";
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpayresult" object:@"1"];
            break;
            
         default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
      }
   }
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
   [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
      [UMSocialSnsService applicationDidBecomeActive];//友盟登录
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)enableIQKeyboardManager
{
   //Enabling keyboard manager
   [[IQKeyboardManager sharedManager] setEnable:YES];
   [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:50];
   //Enabling autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard.
   [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
   
   //Setting toolbar behavious to IQAutoToolbarBySubviews. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order.
   [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
   
   //Resign textField if touched outside of UITextField/UITextView.
   [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
   
}

@end
