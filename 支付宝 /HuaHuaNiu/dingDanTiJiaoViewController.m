//
//  dingDanTiJiaoViewController.m
//  HuaHuaNiu
//
//  Created by 洪慧康 on 16/3/29.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "dingDanTiJiaoViewController.h"
#import "ShouHuoDiZViewController.h"
#import "WXApi.h"
#import "ApiXml.h"
#import "GBWXPayManager.h"
#import "Order.h"
#import "Toast+UIView.h"
#import "AFNetworking.h"
#import <AlipaySDK/AlipaySDK.h>

@interface dingDanTiJiaoViewController ()
{
//    NSDictionary * DataDic;
    int  a;
    NSString *regionId;
    NSString *regionName;
    NSString *regionZipcode;
    NSString *orderid;
    NSString * prices;
}
@end

@implementation dingDanTiJiaoViewController
-(void)viewWillAppear:(BOOL)animated{
    if ([_lableAdress.text isEqualToString:@""]) {
        [_butFirst setBackgroundColor:[UIColor whiteColor]];
    }else{
        _butFirst.hidden=YES;
    }
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

- (void)viewDidLoad {
    [super viewDidLoad];
    //是否截取边角
    self.youjiButton.layer.masksToBounds = YES;
    //截取边角的半径
    self.youjiButton.layer.cornerRadius = 5;
    //设置圆角边界宽度
    self.youjiButton.layer.borderWidth = 1;
    self.youjiButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.duihuanButton.layer.masksToBounds = YES;
    self.duihuanButton.layer.cornerRadius = 5;
    self.duihuanButton.layer.borderWidth = 1;
    self.duihuanButton.layer.borderColor = [UIColor blackColor].CGColor;
    _lableTitle.text=_titleStr;
    _lableYinYuan.text=_yinYuanStr;
    _lableYunFei.text=_yunFeiStr;
    _lableZongJinEShu.text=_yunFeiStr;
    // Do any additional setup after loading the view from its nib.
    if ([self.change_type isEqualToString:@"0"]) {
        
        self.youjiButton.hidden = NO;
        self.duihuanButton.hidden = NO;
    }else if ([self.change_type isEqualToString:@"1"]){
        self.duihuanButton.hidden = NO;
        
    }else if ([self.change_type isEqualToString:@"2"]){
        self.youjiButton.hidden = NO;
    }
}



-(IBAction)adress:(id)sender{
    ShouHuoDiZViewController * svc =[[ShouHuoDiZViewController alloc]initWithDingDan:YES];
    [self.navigationController pushViewController:svc animated:YES];
    [svc makedataWithBlocks:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        _lableName.text=[dic objectForKey:@"consignee"];
        _lableTell.text=[dic objectForKey:@"mobile"];
        _lableAdress.text=[dic objectForKey:@"address"];
        
        regionId=[dic objectForKey:@"region_id"];
        regionName=[dic objectForKey:@"region_name"];
        regionZipcode=[dic objectForKey:@"zipcode"];

    }];
}
-(IBAction)youJiAction:(id)sender{
    _zhiFuView.hidden=NO;
    _lableZongJinE.hidden=NO;
    _lableZongJinEShu.hidden=NO;
    //撤销另一个的设置
    [self.duihuanButton setBackgroundImage:nil forState:UIControlStateNormal];
    self.duihuanButton.layer.borderColor = [UIColor blackColor].CGColor;
    //设置当前button
    [self.youjiButton setBackgroundImage:[UIImage imageNamed:@"duihuankuang"] forState:UIControlStateNormal];
    self.youjiButton.layer.borderColor = BarColor.CGColor;
    [_butZhiFu setTitle:@"确认支付" forState:UIControlStateNormal];
}
-(IBAction)xianChangAction:(id)sender{
    _zhiFuView.hidden=YES;
    _lableZongJinE.hidden=YES;
    _lableZongJinEShu.hidden=YES;
    //撤销另一个的设置
    [self.youjiButton setBackgroundImage:nil forState:UIControlStateNormal];
    self.youjiButton.layer.borderColor = [UIColor blackColor].CGColor;
    //设置当前button
    self.duihuanButton.layer.borderColor = BarColor.CGColor;
    [self.duihuanButton setBackgroundImage:[UIImage imageNamed:@"duihuankuang"] forState:UIControlStateNormal];
    [_butZhiFu setTitle:@"提交订单" forState:UIControlStateNormal];
}
-(IBAction)zhiFuBao:(id)sender{
    a=0;
    [_zhiFuBaoImg setImage:[UIImage imageNamed:@"zhi.png"]];
    [_weiXinImg setImage:[UIImage imageNamed:@"zhifu.png"]];
}
-(IBAction)weiXin:(id)sender{
    a=1;
    [_zhiFuBaoImg setImage:[UIImage imageNamed:@"zhifu.png"]];
    [_weiXinImg setImage:[UIImage imageNamed:@"zhi.png"]];
}
-(IBAction)queRenzhiFu:(id)sender{
    //判断收货地址
    if (regionName.length == nil) {
        //提示并退出
        UIAlertView *aaall =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择收货地址" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [aaall show];
        return;
    }
    if ( _zhiFuView.hidden==YES) {
         [self makeDingDanAdd];
        [self.navigationController popViewControllerAnimated:YES];
    }else{//邮寄
        [self makeDingDanAdd1];
        [self.navigationController popViewControllerAnimated:YES];
    }
   
}
-(void)zhiFuFangShi{
//    if (_zhiFuView.hidden==NO) {
        if (a==0) {
            // 支付宝支付
            //(@"支付宝支付");
            [self  makeZhiFuBaoZhifu];
        }
        else if (a==1){
            NSString *orderno   = [NSString stringWithFormat:@"%ld",time(0)];
            NSArray * dingArr =[NSArray array];
            NSLog(@"[GBWXPayManager sharedManager].orderId = dingStr:%@",orderid);
            dingArr =[orderid componentsSeparatedByString:@","];
            [GBWXPayManager sharedManager].delegate = self;
            [GBWXPayManager sharedManager].orderId = dingArr[0];
            
            [GBWXPayManager wxpayWithOrderID:orderno orderTitle:@"代言城" amount:_yunFeiStr];
        }
        
        else{
            
            UIAlertView *aaall =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择支付方式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [aaall show];
            return;
        }
//    }else{
    
//    }
}
-(void)makeDingDanAdd{
    NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[userdefault objectForKey:@"Useid"];
    NSString *user_name =[userdefault objectForKey:@"UserName"];
    NSString *LoginStr =[NSString stringWithFormat:@"http://daiyancheng.cn/apporder/ddorder_add.do?"] ;
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    /*
     "member_id 用户id
     user_name用户昵称
     store_id 店铺id
     goods_id:商品id
     total_silver:兑换所需银元
     change_type:兑换方式（0：邮寄 1：现场）
     fee  配送运费（兑换方式为0 时需要）
     //收货人信息
     region_id 区域id
     region_name 区域名称 例如：中国 河南省 郑州市
     address 地址
     zipcode 邮编
     phone_mob 手机
     consignee 收获人姓名"
     */
    NSArray *KeyArr =@[@"token",@"member_id",@"user_name",@"store_id",@"goods_id",@"total_silver",@"change_type",@"fee",@"region_id",@"region_name",@"address",@"zipcode",@"phone_mob",@"consignee"];
    
    NSString * str4 = [user_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",regionId);
    
    NSArray *ValueArr =@[@"test",userID,str4,_storeIdStr,_goodsIdStr,_yinYuanStr,@"1",_yunFeiStr,regionId,regionName,_lableAdress.text,regionZipcode,_lableTell.text,_lableName.text];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:ValueArr forKeys:KeyArr];

    [manager POST:LoginStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        //  支付宝提交订单的信息
        
        orderid = responseObject[@"orderid"];
        prices = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"price"]];
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [failAlView show];
        [self zhiFuFangShi];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
    }];
}

-(void)makeDingDanAdd1{
    
    NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[userdefault objectForKey:@"Useid"];
    NSString *user_name =[userdefault objectForKey:@"UserName"];
    NSString *LoginStr = @"http://daiyancheng.cn/apporder/ddorder_add.do";
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    NSArray *KeyArr =@[@"token",@"member_id",@"user_name",@"store_id",@"goods_id",@"total_silver",@"change_type",@"fee",@"region_id",@"region_name",@"address",@"zipcode",@"phone_mob",@"consignee"];
    NSString * str4 = [user_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *ValueArr =@[@"test",userID,str4,_storeIdStr,_goodsIdStr,_yinYuanStr,@"0",_yunFeiStr,regionId,regionName,_lableAdress.text,regionZipcode,_lableTell.text,_lableName.text];
    NSDictionary *dic =[[NSDictionary alloc]initWithObjects:ValueArr forKeys:KeyArr];

    [manager POST:LoginStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        //  支付宝提交订单的信息
        
        orderid = responseObject[@"orderid"];
        prices = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"price"]];
        //        //  选择支付方式
        [self zhiFuFangShi];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];

    }];

}

-(void)morendizhi{
    NSUserDefaults * userDefault =[NSUserDefaults standardUserDefaults];
    
    NSString * userid =[userDefault objectForKey:@"Useid"];
    
    NSString *ShouY = [NSString stringWithFormat:SHOUHUODIZHISR, userid];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //(@"%@",responseObject);
        NSMutableArray *  dataArr =[[NSMutableArray alloc]initWithArray:responseObject];
        if (dataArr.count > 0) {
            int n =0;
            for (NSDictionary * addDic in dataArr) {
                NSString * stre =[NSString stringWithFormat:@"%@",[addDic objectForKey:@"status"]];
                if ([stre isEqualToString:@"1"]) {
                    break;
                }
                n++;
            }
            if (dataArr.count == n) {
//                [TopAddView ViewmakedataWithdi:nil];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    
    
    
    
}
#pragma mark 支付宝支付
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
    
    NSArray * dingArr =[NSArray arrayWithArray:[orderid componentsSeparatedByString:@","]];
    NSLog(@"%@",dingArr);
    NSArray * priceArr =[NSArray arrayWithArray:[prices componentsSeparatedByString:@","]];
    
    /*
     *生成订单信息及签名
     *商户的唯一的parnter 合作者id和seller  支付宝账号。
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
        order.tradeNO =orderid; //订单ID（由商家自行制定）
    //    order.productName = product.subject; //商品标题
    order.productName = @"商品标题"; //商品标题
    //    order.productDescription = product.body; //商品描述
    order.productDescription = @"商品描述"; //商品描述
    order.amount = _yunFeiStr; //商品价格
    
        order.notifyURL = [NSString stringWithFormat:ZHIFUHD,dingArr[0],@"1"]; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkhuahuaniu";
    
    //将商品信息拼接成字符串orderSpec
    NSString *orderSpec = [order description];
    //(@"orderSpec = %@",orderSpec);
    
    //(@"%lu",(unsigned long)dingArr.count);
    
    
    NSString *orderno   = [NSString stringWithFormat:@"%ld",time(0)];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    NSDictionary *dic =@{@"token":@"test",@"order_id":orderno,@"order_amount":_yunFeiStr,@"order_desc":@"productDescription"};
    NSLog(@"%@",dic);
    
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
                    
                    //完成回调
                    
                    
                    
                    status =@"订单支付成功";
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    NSString * resquestUrl =[NSString stringWithFormat:ZHIFUHD,dingArr[0]];
                    [[RequestManger share]requestDataByGetWithPath:resquestUrl complete:^(NSDictionary *data) {
                        (@"%@",[data objectForKey:@"result"]);
                        (@"%@",[data objectForKey:@"msg"]);
                    }];
////////////////////////////////////////////////////////////////
                    
                //修改后台购买信息为已购买

//                    [self makeDingDanAdd];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
