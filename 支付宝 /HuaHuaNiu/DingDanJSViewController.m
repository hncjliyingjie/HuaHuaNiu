//
//  DingDanJSViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15/6/24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "DingDanJSViewController.h"
#import "AddresslView.h"
#import "AFNetworking.h"
#import "ShouHuoDiZViewController.h"
#import "TJDDDTableViewCell.h"
#import "FangShiTableViewCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "Toast+UIView.h"
#import "WXApi.h"
#import "ApiXml.h"
#import "WXApiRequestHandler.h"
#import "CommonUtil.h"
#import "GBWXPayManager.h"
@interface DingDanJSViewController ()

@end

@implementation DingDanJSViewController
-(id)initWithDic:(NSDictionary *)dic{
    self =[super init];
    if (self) {
        // 里面的参数可能不是想要的 这里的参数 是 直接 购买的 不是 提交的订单
        DataDic =[[NSDictionary alloc]initWithDictionary:dic];
        //(@"zongjine  %@",DataDic);
        
        if([DataDic objectForKey:@"order_amount"]){
        allprice =[NSString stringWithFormat:@"%@",[DataDic objectForKey:@"order_amount"]];
        }else{
        allprice =[NSString stringWithFormat:@"%@",[DataDic objectForKey:@"total_price"]];
        }
    
       dingStr =[NSString stringWithFormat:@"%@",[DataDic objectForKey:@"order_id"]];
        //(@"%@",dingStr);
        [GBWXPayManager sharedManager].orderId = dingStr;
        order_type =[NSString stringWithFormat:@"%@",[DataDic objectForKey:@"order_type"]];
        
    }
    return self;
}
- (void)viewDidLoad {
    a = 20;
    mmmm =  NO;
    [super viewDidLoad];
    AddressDic=[[NSDictionary alloc]init];
    
    self.navigationItem.title=@"立即支付";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.view.backgroundColor = BackColor;
  //  [self maketopAFDD];
   // [self morendizhi];
    // 从购物车获取数据[self makeDingdanData];
    [self makeTabele];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//制作tableview
-(void)makeTabele{
    IOS_Frame
   UIView *footViews =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 130)];
    footViews.backgroundColor=BackColor;
    
    // 支付宝的组   xuan YES  选中     Image 图片  name    description 描述
    NSMutableDictionary * Firstdic =[[NSMutableDictionary alloc]init];
    [Firstdic setValue:@"NO" forKey:@"xuan"];
    [Firstdic setValue:@"60x60" forKey:@"Image"];
    [Firstdic setValue:@"支付宝支付" forKey:@"name"];
    [Firstdic setValue:@"推荐安装支付宝客户端的用户使用" forKey:@"description"];
    // 微信支付
    NSMutableDictionary *Secdic =[[NSMutableDictionary alloc]init];
    [Secdic setObject:@"NO" forKey:@"xuan"];
    [Secdic setValue:@"qwi" forKey:@"Image"];
    [Secdic setValue:@"微信" forKey:@"name"];
    [Secdic setValue:@"推荐安装微信客户端的用户使用" forKey:@"description"];
    ZhiFDataArr =[[NSMutableArray alloc]init];
    [ZhiFDataArr addObject:Firstdic];
    [ZhiFDataArr addObject:Secdic];
    
    
    //  支付的tableview 放到 footView上边
    ZhiTv =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 45 *ZhiFDataArr.count) style:UITableViewStylePlain];
    ZhiTv.delegate =self;
    ZhiTv.dataSource =self;
    ZhiTv.bounces = NO;
    ZhiTv.scrollEnabled = NO;
    ZhiTv.backgroundColor = BackColor;
    
    
    footViews.frame =CGRectMake(0,0, ConentViewWidth, 40 + 45*ZhiFDataArr.count);
    [footViews addSubview:ZhiTv];
    
    
   
    [self.view addSubview:footViews];
    
    UIView * buyView =[[UIView alloc]initWithFrame:CGRectMake(0,ConentViewHeight - 40, ConentViewWidth, 40)];
    buyView.backgroundColor =[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    UILabel * zhilabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 70, 40)];
    zhilabel.text =@"支付金额:";
    zhilabel.font =[UIFont systemFontOfSize:13];
    AllPricelabel =[[UILabel alloc]initWithFrame:CGRectMake(75, 0, 100, 40)];
    AllPricelabel.font =[UIFont systemFontOfSize:13];
    AllPricelabel.textColor =[UIColor redColor];
    AllPricelabel.text =[NSString stringWithFormat:@"￥ %@",allprice];
    UIButton * querenBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    querenBtn.frame =CGRectMake(ConentViewWidth - 70, 5, 65, 30);
    [querenBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    querenBtn.titleLabel.font =[UIFont systemFontOfSize:13];
    
    [querenBtn addTarget:self action:@selector(QueRenAxtion) forControlEvents:UIControlEventTouchUpInside];
    [querenBtn setBackgroundColor:[UIColor colorWithRed:247/255.0 green:125/255.0 blue:137/255.0 alpha:1]];
    querenBtn.layer.cornerRadius = 4;
    [buyView addSubview:querenBtn];
    [buyView addSubview:zhilabel];
    [buyView addSubview:AllPricelabel];
    
    [self.view addSubview:buyView];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 66) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}
#pragma  mark 支付
-(void)QueRenAxtion{
    if (a==0) {
        // 支付宝支付
        //(@"支付宝支付");
        [self  makeZhiFuBaoZhifu];
    }
    else if (a==1){
        NSArray * dingArr =[NSArray array];
        NSArray * price =[NSArray array];
        dingArr =[dingStr componentsSeparatedByString:@","];
        price =[allprice componentsSeparatedByString:@","];
//        NSString *orderno   = [NSString stringWithFormat:@"%ld",time(0)];
        
        [GBWXPayManager wxpayWithOrderID:dingArr[0] orderTitle:@"代言城" amount:price[0]];
    }
    
    else{
        
        UIAlertView *aaall =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择支付方式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [aaall show];
        return;
    }
}

    
   #pragma mark UItableview 代理
// 返回每一组的行数
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return ZhiFDataArr.count;
 
}
// 分组个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
        return 1;
 
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 45;
  
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
           return 1;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
           return 1;
 
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     FangShiTableViewCell * lcell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (lcell == nil) {
            lcell =[[[NSBundle mainBundle]loadNibNamed:@"FangShiTableViewCell" owner:self options:nil]lastObject];
        }
        NSMutableDictionary * ddic =ZhiFDataArr[indexPath.row];
        [lcell cellMakeWithDicss:ddic];
        
        return lcell;
       
    
    //    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    //    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==ZhiTv) {
        a   = (int)indexPath.row;
        mmmm = YES;
        for ( NSMutableDictionary * diic  in ZhiFDataArr) {
            [diic setValue:@"NO" forKey:@"xuan"];
        }
        NSMutableDictionary * Sdic =ZhiFDataArr[indexPath.row];
        [Sdic setValue:@"YES" forKey:@"xuan"];
        
        // 把其他的置为 NO 选中的职位YES; 获取 使用什么支付的
       
        
        [ZhiTv reloadData];
    }
}
// 显示默认地址
-(void)morendizhi{
    NSUserDefaults * userDefault =[NSUserDefaults standardUserDefaults];
    
    NSString * userid =[userDefault objectForKey:@"Useid"];
    
    NSString *ShouY = [NSString stringWithFormat:SHOUHUODIZHISR, userid];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *  dataArr =[[NSMutableArray alloc]initWithArray:responseObject];
        if (dataArr.count > 0) {
            for (NSDictionary * addDic in dataArr) {
                NSString * stre =[NSString stringWithFormat:@"%@",[addDic objectForKey:@"state"]];
                if ([stre isEqualToString:@"1"]) {
                    AddressDic = addDic;
                }
            }
            [TopAddView ViewmakedataWithdi:AddressDic];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
}

-(void)maketopAFDD{
    IOS_Frame
    TopAddView =[[[NSBundle mainBundle]loadNibNamed:@"AddresslView" owner:self options:nil]lastObject];
    TopAddView.frame =CGRectMake(0, 0, ConentViewWidth, TopAddView.frame.size.height);
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapActions)];
    [TopAddView addGestureRecognizer:tap];
    [self.view addSubview:TopAddView];
    
}
-(void)TapActions{
    ShouHuoDiZViewController * svc =[[ShouHuoDiZViewController alloc]initWithDingDan:YES];
    [self.navigationController pushViewController:svc animated:YES];
    [svc makedataWithBlocks:^(NSDictionary *dic) {
        AddressDic  =dic;
        
        [TopAddView ViewmakedataWithdi:dic];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 支付宝支付 正常
-(void)makeZhiFuBaoZhifu{

    // //(@"获取parnter 和 seller  、privateKey(私钥)")  ;

    /*
     *点击获取prodcut实例并初始化订单信息   自己赋值的话不用 Product
     */

    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */

    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911222877472";//合作者ID
    NSString *seller = @"bbnkjzg@126.com";  // 支付宝账号
    NSString *privateKey = @"-----BEGIN RSA PRIVATE KEY-----MIICXAIBAAKBgQC9RWd8SWkBxYUMngeaFoxAXr6fvV4GtvLWXZtaEoEUyiiQpRhPgDwedDCaiU/HmR60D7YO/VoVYu/4v8iStOmuPIydYpliGp5fR0RzVAYT6sdVXskc+AHTGvxHxKLc+0a0yoYMv2PjYXiWb/5+AP2A+rlfiG0Xz+O5JtmsU/A37QIDAQABAoGAFcOVUsVePcXotrq1RRKyrfQ3F0c/OKZw5hV9d64JCcr1Pyy8zueAAkB6FksT0W/aB/qGhNK9ORhXX9MtzTDgbeX/JPJIx7eXyaYRWOuYtwC+N9FXrz0O09qRI47F9UR8yTvLOxKqSJlSSEv4ZwPRiVy4YE4twVIEuJo2pOHZ5EECQQDk0bcX3ZVlZrGsoufs+m++2hjJ40JPyc2ahSpHfVqPv2yhSWa9qUP7h9Vw4qEZ1zO1kNRnGT/EeYQUQIB0XimfAkEA08EM1WjYG/XemBVZgIkbbPjnQ2LYUmhdO8/F/AILCImIjIzbV/eohAIXeevubJDtq0grP0mIsp17OTbS/YGK8wJBAIjpBmFsPtCeYp8GFjlQG36ZZo2dwfaVq8TR+tstoPszsV7L2YKP/dJJkydpIrWgcxsnXj+V9varMqEfevylvscCQCV0WBjHWrJXYu/zlsktdzRnMkCxEyJAY31Y2uQgWGNCMGzr3UBKBfyTgiOGn72ERQWu1jdzgkJVqJ4OHHPKnhECQDiFSTo26YFd7tshv2ASo8PRJsObuI1LnkN6VpPoApAY    YzlIlYkVOC49jAfiJorn2pZGPKX+d1gdJpy1Aq9CLyc=-----END RSA PRIVATE KEY-----";// RSA密钥
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/

    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    //(@"cccc %@",dingStr);
    NSArray * dingArr =[NSArray array];
    NSArray * price =[NSArray array];

        dingArr =[dingStr componentsSeparatedByString:@","];
         price =[allprice componentsSeparatedByString:@","];
//    NSArray * fee =[allprice componentsSeparatedByString:@","];

    

    /* 
     *生成订单信息及签名
     *商户的唯一的parnter 合作者id和seller  支付宝账号。
     */
    //将商品信息赋予AlixPayOrder的成员变量
    //(@"%@",DataDic);
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO =dingArr[0]; //订单ID（由商家自行制定）
    //    order.productName = product.subject; //商品标题
    order.productName = @"商品标题"; //商品标题
    //    order.productDescription = product.body; //商品描述
    order.productDescription = @"商品描述"; //商品描述
//    float  n1 =[allprice[i] floatValue]+[[NSString stringWithFormat:@"%@",[DataDic objectForKey:@"fee"]]floatValue];
    order.amount =price[0];  //商品价格
    //  order.amount = [NSString stringWithFormat:@"%.2f",0.01]; //商品价格
    order.notifyURL = [NSString stringWithFormat:ZHIFUHD,dingStr,order_type]; //回调URL

    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";

    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkhuahuaniu";

    //将商品信息拼接成字符串orderSpec
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);



        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        NSDictionary *dic =@{@"token":@"test",@"order_id":dingArr[0],@"order_amount":price[0],@"order_desc":@"productDescription"};
        //(@"%@",dic);
        [manager POST:ZHIFU_REQUEST parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

            //   获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode

            NSString *signedString=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"sign"]];
            NSString *ordStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"payInfo"]];

            //将签名成功字符串格式化为订单字符串,请严格按照该格式
            NSString *orderString = nil;
            if (signedString != nil) {
                orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                               orderSpec, signedString, @"RSA"];

                [[AlipaySDK defaultService] payOrder:ordStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    //(@"reslut = %@",resultDic);
                    NSString * str2 =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"memo"]];

                    //(@"%@",str2);

                    NSString * str =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                    NSString * status  ;
                    if ([str isEqualToString:@"9000"]) {
                        status =@"订单支付成功";
                       NSString * requestUrl =[NSString stringWithFormat:ZHIFUHD,dingArr[0]];
                        RequestManger * manger = [RequestManger share];
                        [manger requestDataByGetWithPath:requestUrl complete:^(NSDictionary *data) {
                            if ([data objectForKey:@"error"]) {
                                //(@"%@",[data objectForKey:@"error"]);
                            }else{
                                //(@"%@",[data objectForKey:@"result"]);
                            }
                        }];

                    }
                    else if ([str isEqualToString:@"8000"]) {
                        status =@"正在处理中";
                        
                    }
                    else if ([str isEqualToString:@"6001"]) {
                        status =@"用户中途取消";
                    }
                    else if ([str isEqualToString:@"6002"]) {
                        status =@"网络连接出错";
                    }
                    else{
                        status =@"网络连接出错";
                    }

                    UIAlertView * ResultAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:status delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    ResultAlView.tag= 66;
                    [ResultAlView show];
                }];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }];
    }
//微信支付
-(void)makeweixinzhifu{
    
    

    NSString *urlString   = @"http://daiyancheng.cn/apporder/wxpay.do?token=test&member_id=1511050259289160000&body=123&total_price=2&ip=192.168.1.120&orderid=213";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"url:%@",urlString);
        NSLog(@"%@",dict);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timeStamp"];
                NSLog(@"%@",dict);
                NSLog(@"%@",[dict objectForKey:@"timeStamp"]);
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
//                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                req.partnerId           = [dict objectForKey:@"parentid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"nonceStr"];
                req.timeStamp           = [stamp intValue];
                req.package             = @"Sign=WXPay";
                req.sign                =[dict objectForKey:@"paySign"];
                NSLog(@"%@",[dict objectForKey:@"paySign"]);

                [WXApi sendReq:req];
            }else{
                [self alert:@"提示信息" msg:[dict objectForKey:@"msg"]];
            }
        }else{
            [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
        }
    }else{//response = nil
        [self alert:@"提示信息" msg:@"服务器返回错误"];
    }
    
    
}
- (NSString *)genSign:(NSDictionary *)signParams
{
    // 排序
    NSArray *keys = [signParams allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 生成
    NSMutableString *sign = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [sign appendString:key];
        [sign appendString:@"="];
        [sign appendString:[signParams objectForKey:key]];
        [sign appendString:@"&"];
    }
    NSString *signString = [[sign copy] substringWithRange:NSMakeRange(0, sign.length - 1)];
    
    NSString *result = [CommonUtil sha1:signString];
    NSLog(@"--- Gen sign: %@", result);
    return result;
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
    
}
/*   3   支付完成之后 会返回到这个 方法里面    （主要是验证是否支付成功从后台获取数据 来显示） */
-(void)onResp:(BaseResp *)resp{
    
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
                
            {
                strMsg = @"支付结果：成功！";
                //(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                NSString * resquestUrl =[NSString stringWithFormat:ZHIFUHD,dingStr];
                
                
                NSLog(@"%@",resquestUrl);
                
                [[RequestManger share]requestDataByGetWithPath:resquestUrl complete:^(NSDictionary *data) {
                    (@"%@",[data objectForKey:@"result"]);
                    (@"%@",[data objectForKey:@"msg"]);
                }];
            }
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                //(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}

@end
