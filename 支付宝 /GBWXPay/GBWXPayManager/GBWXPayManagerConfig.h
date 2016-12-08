//
//  GBWXPayManagerConfig.h
//  微信支付
//
//  Created by 张国兵 on 15/7/25.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#ifndef _____GBWXPayManagerConfig_h
#define _____GBWXPayManagerConfig_h
//===================== 微信账号帐户资料=======================

#import "payRequsestHandler.h"         //导入微信支付类
#import "WXApi.h"

#define APP_ID          @"wx396076a20ac96cdb"               //APPID
#define APP_SECRET      @"3c3e03f8d9a0240aab53d9205f407d7a" //appsecret
//商户号，填写商户对应参数
#define MCH_ID          @"1239842902"
//商户API密钥，填写相应参数
#define PARTNER_ID      @"daiyancheng8888bbnkj123456654321"
//支付结果回调页面
//#define NOTIFY_URL      @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
#define NOTIFY_URL        @"http://daiyancheng.cn/apporder/order_pay_success.do?token=test&order_id=%@&oeder_type=%@"
//获取服务器端支付数据地址（商户自定义）
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"
//商户数据
//appId=wx66de4a61ba088c2f
//mchId=1261950701
//AppSecret=0716eae12d6c088f4807435cf96b48a9
//APISecret=ffjfasjfljafjajfdlajdfjaldfjajfj
//token=jason4zhu_ejiapei
//参数
//订单号：orderid
//驾校id：schoolid
//学员姓名：name
//手机号：phone
//验证码：verifynum
//随机数：randomnum
///wxpay/payModelAndViewForApp
#endif
