
//
//  SentTableViewCell.m
//  HuaHuaNiu
//
//  Created by alex on 15/12/26.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "SentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"

@implementation SentTableViewCell

- (NSDictionary *)AdDict{
    if (!_AdDict) {
        _AdDict = [NSDictionary dictionary];
    }
    return _AdDict;
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)INcellmakeWithDic:(NSDictionary *)dic{
    
    self.AdDict = dic;
    
    if ([[dic objectForKey:@"logo"]  isEqual: @""]) {
//        self.IconImage.image = [UIImage imageNamed:@"default"];
    }else{

        [self.IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"logo"]]]];
    }
    
    self.NameLabel .text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
    
    self.contextLB .text =[NSString stringWithFormat:@"投放总人次:%@ 已有%@人查看",[dic objectForKey:@"total_num"],[dic objectForKey:@"look_num"]];
    
    if ([[NSString stringWithFormat:@"%@",dic[@"is_pay"]] isEqualToString:@"1"]) {
        [self.fuKuanButton setTitle:@"已付款" forState:UIControlStateNormal];
        self.fuKuanButton.userInteractionEnabled = NO;
    }else {
        [self.fuKuanButton setTitle:@"去付款" forState:UIControlStateNormal];
                self.fuKuanButton.userInteractionEnabled = YES;
    }
    
    
}


- (IBAction)fuKuanButton:(UIButton *)sender {
    
    
    [self makeZhiFuBaoZhifu];
    
}

#pragma mark 支付宝支付
-(void)makeZhiFuBaoZhifu{
    
    // NSLog(@"获取parnter 和 seller  、privateKey(私钥)")  ;
    
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
    
    /*
     *生成订单信息及签名
     *商户的唯一的parnter 合作者id和seller  支付宝账号。
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    
    //订单前拼接 AD
    NSString *adid = [NSString stringWithFormat:@"AD%@",self.AdDict[@"advalue"]];
    
    
    order.tradeNO =adid; //订单ID（由商家自行制定）
    order.productName = @"商品标题"; //商品标题
    order.productDescription = @"商品描述"; //商品描述
    NSString * priceStr =[NSString stringWithFormat:@"%@",[self.AdDict objectForKey:@"total_money"]];
    order.amount = [NSString stringWithFormat:@"%.2f",[priceStr floatValue]]; //商品价格

    order.notifyURL = [NSString stringWithFormat:ZHIFUHD,adid,@"1"]; //回调URL
    
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
//    NSString *ADid = [NSString stringWithFormat:@"AD%@",[self.AdDict objectForKey:@"advalue"]];
    NSDictionary *dic =@{@"token":@"test",@"order_id":adid,@"order_amount":[NSString stringWithFormat:@"%.2f",[priceStr floatValue]],@"order_desc":@"productDescription"};
    NSLog(@"%@",dic);
    [manager POST:ZHIFU_REQUEST parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //   获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        //                id<DataSigner> signer = CreateRSADataSigner(privateKey);
        //            NSString *signedString = [signer signString:orderSpec]; //商品信息拼接成的字符串orderSpec
        //
        NSString *signedString=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"sign"]];
        NSString *ordStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"payInfo"]];
        
        NSLog(@"%@",signedString);
        signedString =[signedString stringByReplacingOccurrencesOfString:@" " withString:@""];
        [signedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:ordStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                NSString * str2 =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"memo"]];
                
                NSLog(@"%@",str2);
                
                NSString * str =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
                NSString * status  ;
                if ([str isEqualToString:@"9000"]) {
                    status =@"订单支付成功";
                    NSString * resquestUrl =[NSString stringWithFormat:ZHIFUHD,adid];
                    [[RequestManger share]requestDataByGetWithPath:resquestUrl complete:^(NSDictionary *data) {
                        NSLog(@"%@",[data objectForKey:@"result"]);
                        NSLog(@"%@",[data objectForKey:@"msg"]);
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



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
