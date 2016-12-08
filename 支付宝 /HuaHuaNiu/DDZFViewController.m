//
//  DDZFViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/12.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "DDZFViewController.h"
#import "Masonry.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "GBWXPayManager.h"
#import "WXApi.h"
@interface DDZFViewController ()
@property (weak, nonatomic) IBOutlet UILabel *accountYuenLbl;//账户余额
@property (weak, nonatomic) IBOutlet UILabel *zf_textLbl;
- (IBAction)qdxdAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *zf_btn;//支付宝按钮
@property (weak, nonatomic) IBOutlet UIButton *wx_btn;//微信按钮

@property (weak, nonatomic) IBOutlet UILabel *sumPriceLbl;//应付总金额位置
@property (weak, nonatomic) IBOutlet UIView *shareView;//分享朋友圈的view

@property (weak, nonatomic) IBOutlet UIView *bigView;//支付方式的框
@property (weak, nonatomic) IBOutlet UIButton *qdzfBtn;//确定支付按钮
@property (weak, nonatomic) IBOutlet UILabel *tsLbl;//友情提示
@property (weak, nonatomic) IBOutlet UIView *grayView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;//确定支付View
@property (weak, nonatomic) IBOutlet UIButton *syBtn;//使用按钮
@property (weak, nonatomic) IBOutlet UIImageView *syImagView;//使用前的图标

@property(strong,nonatomic)NSString *sum_price;//总金额

@property(strong,nonatomic)UIButton *tempBtn;

@end

@implementation DDZFViewController
{
    NSString *orderId;
    NSString * prices;
    NSDictionary * DataDic;
    double accountNumber;//账户余额
    double shengToPayNumber;//还需支付的金额
    double needToPayNumber;//应付总额
    
    
}

-(void)initWithSumPrice:(NSString *)price{
    
    _sum_price=price;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"订单支付";
    //获取余额
    [self huoquYuEn];
    [self ViewWithStyle];
    //读取上个页面传过来的数据
    [self readData];
    
    // 读取订单数据:
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    orderId = [defaults objectForKey:@"orderId"];
    NSLog(@"%@",orderId);
}
//获取余额
-(void)huoquYuEn{
    
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString * userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    
    NSString * ShouY = [NSString stringWithFormat:YONGHUMessage, userID];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"xxxxxxxx%@",responseObject);
        float number =[[responseObject objectForKey:@"total_integral"] floatValue];
        number/=100;
        accountNumber=number;
        self.accountYuenLbl.text=[NSString stringWithFormat:@"￥ %.2f",number];
        NSUserDefaults * userDefault =[NSUserDefaults standardUserDefaults];
        [userDefault setObject:self.accountYuenLbl.text forKey:@"account"];
        [userDefault setObject:responseObject  forKey:@"gerenxinxi"];
        [userDefault synchronize];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
        //(@"cook load failed ,%@",error);
    }];
}
-(void)readData{

    //  读取数据:
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    //保存下来的分享平台
    BOOL wxSelected=[defaults boolForKey:@"wxselected"];
    BOOL wbSelected=[defaults boolForKey:@"wbselected"];
    BOOL qqSelected=[defaults boolForKey:@"qqselected"];
    NSMutableArray *array=[NSMutableArray array];
    if (wxSelected==YES) {
        UIImage *img=[UIImage imageNamed:@"wx_new"];
        [array addObject:img];
        
    }
    if (wbSelected==YES) {
        UIImage *img=[UIImage imageNamed:@"wb_new"];
        [array addObject:img];
    }
    if (qqSelected==YES) {
        UIImage *img=[UIImage imageNamed:@"qq_new"];
        [array addObject:img];
    }
    
    //设置图片的宽
    CGFloat imageW=30;
    //设置图片的高
    CGFloat imageH=30;
    //设置图片的y
    CGFloat imageY=10;
    //添加图片
    for (int i=0; i <array.count; i++)
    {
        UIImageView *imageView=[[UIImageView alloc]init];
        //每张图片的x
        CGFloat imageX= self.view.frame.size.width-(i *imageW+30);
        
        //设置imageview的frame
        imageView.frame=CGRectMake(imageX, imageY, imageW, imageH);
        
        //设置每张图片的名字
        imageView.image=[array objectAtIndex:i];

        [self.shareView addSubview:imageView];
    }
   
}

-(void)ViewWithStyle{
    
    self.bigView.layer.cornerRadius=5;
    self.bigView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.bigView.layer.borderWidth=0.5;
    
    self.qdzfBtn.layer.cornerRadius=12;
    
    self.tsLbl.text=@"友情提示:\r\n1.订单审核未通过，任务未完成等情况，系统会退回相应资金到消费账户。\r\n2.消费账户只能用于消费，不可提现。\r\n3.任何疑问请咨询：400-1818-878。";
    
    [self.syBtn addTarget:self action:@selector(syDone:) forControlEvents:UIControlEventTouchUpInside];
    //显示总金额
    self.sumPriceLbl.text=[NSString stringWithFormat:@"%@元",_sum_price];
    //应付总额
    needToPayNumber=_sum_price.doubleValue;
    
    //给支付宝和微信添加点击事件
    [self.zf_btn addTarget:self action:@selector(zfAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.wx_btn addTarget:self action:@selector(zfAction:) forControlEvents:UIControlEventTouchUpInside];
    self.zf_btn.tag=0;
    self.wx_btn.tag=1;
   
}

#pragma mark 点击事件
-(void)zfAction:(id)sender{
    UIButton *btn=sender;
    if (btn.tag==0) {
       
        [self.zf_btn setImage:[UIImage imageNamed:@"selected_blue_new"] forState:UIControlStateNormal];
        [self.wx_btn setImage:[UIImage imageNamed:@"selected_gray_new"] forState:UIControlStateNormal];
        
    }
    if (btn.tag==1) {
        [self.wx_btn setImage:[UIImage imageNamed:@"selected_blue_new"] forState:UIControlStateNormal];
        [self.zf_btn setImage:[UIImage imageNamed:@"selected_gray_new"] forState:UIControlStateNormal];
    }
     btn.selected=!btn.selected;
    _tempBtn=btn;
}

//点击使用按钮
-(void)syDone:(id)sender{

    UIButton *btn=sender;
    
    if (btn.selected==YES) {
       
        self.syImagView.image=[UIImage imageNamed:@"select.png"];
        shengToPayNumber=-(accountNumber-needToPayNumber);
        self.zf_textLbl.text=[NSString stringWithFormat:@"使用支付余额%.2f元还需要支付%.2f元",accountNumber,shengToPayNumber];
        
    }
    if (btn.selected==NO) {
        self.syImagView.image=[UIImage imageNamed:@"quan.png"];
        shengToPayNumber=needToPayNumber;
        self.zf_textLbl.text=[NSString stringWithFormat:@"未使用支付余额,还需要支付%.2f元",shengToPayNumber];
        
    }
    btn.selected=!btn.selected;

}

#pragma mark 微信支付
-(void)makeWXZhifu{
    
    [GBWXPayManager wxpayWithOrderID:orderId orderTitle:@"代言城" amount:@"0.01"];

}

-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            caseWXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
//                NSlog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
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
    
    /*
     *生成订单信息及签名
     *商户的唯一的parnter 合作者id和seller  支付宝账号。
     */
    //将商品信息赋予AlixPayOrder的成员变量
    
    NSArray * dingArr =[NSArray arrayWithArray:[orderId componentsSeparatedByString:@","]];
    NSLog(@"%@",dingArr);
    NSArray * priceArr =[NSArray arrayWithArray:[prices componentsSeparatedByString:@","]];
    
    //(@"%d",dingArr.count);
    //    int n =1;
    //    if ([dingArr[1] isEqualToString:@""]) {
    //        n =dingArr.count ;
    //    }else{
    //        dingArr =[NSArray arrayWithObject:dingStr];
    //    }
    
    //(@"%@",DataDic);
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO =dingArr[0]; //订单ID（由商家自行制定）
    //    order.productName = product.subject; //商品标题
    order.productName = @"商品标题"; //商品标题
    //    order.productDescription = product.body; //商品描述
    order.productDescription = @"商品描述"; //商品描述
//    order.amount = [Sedic objectForKey:@"amount"]; //商品价格
    
    //pay_no 支付宝接口的预付款订单
    //pay_message 支付信息
    //id 订单orderID
    order.notifyURL = [NSString stringWithFormat:@"%@%@%@%@%@%@",ZHIFUURL,@"100",@"0.1",@"0",order.productDescription,orderId]; //回调URL
    
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
    
    
    //测试金额
    NSString *str=@"0.1";
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *dic =@{@"token":@"test",@"order_id":orderId,@"total_price":str,@"body":@"发布广告"};
    NSLog(@"%@",dic);
    [manager POST:ZHIFU_QIANMING parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //   获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
        //    id<DataSigner> signer = CreateRSADataSigner(privateKey);
        //NSString *signedString = [signer signString:orderSpec]; //商品信息拼接成的字符串orderSpec
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
         NSLog(@"支付宝签名请求%@",dict);
        NSString *signedString=[NSString stringWithFormat:@"%@",[dict objectForKey:@"sign"]];

        NSString *ordStr=[NSString stringWithFormat:@"%@",[dict objectForKey:@"payInfo"]];
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderSpec, signedString, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:ordStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                NSLog(@"支付成功返回的数据%@",resultDic);
                NSString * str2 =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"memo"]];
                NSString * str =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
//                NSLog(@"支付成功返回的数据%@",resultDic);
                
//                NSString *str11=[self dictionaryToJson:resultDic];
//                NSLog(@"词典转成字符串返回的数据%@",str11);
                NSString *result=[resultDic objectForKey:@"result"];
                NSArray *listArray=[result componentsSeparatedByString:@"&"];
                NSLog(@"分割后的数组%@",listArray);
                //取第一串
                NSString *firstStr=[listArray objectAtIndex:0];
                //按“ \ ”分割
                NSArray *firstArray=[firstStr componentsSeparatedByString:@"\\"];
               
                NSString *secoundStr=[firstArray objectAtIndex:0];
                //按“ " ”分割
                NSArray *secoudArray=[secoundStr componentsSeparatedByString:@"\""];
                
                NSString *partner=[secoudArray objectAtIndex:1];
                                      
                NSLog(@"最终分割的字符%@",partner);
            
                NSString *accountMoney=[NSString stringWithFormat:@"%f",accountNumber];
                
                NSString * status  ;
                if ([str isEqualToString:@"9000"]) {
                    status =@"订单支付成功";
                    NSString * resquestUrl =[NSString stringWithFormat:ZHIFUURL,accountMoney,str,@"0",partner,order.productDescription,orderId];
                    NSLog(@"打印出来的回调地址%@",resquestUrl);
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
        NSLog(@"%@",error);
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
    }];
    
}

//词典转换为字符串

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
//确定下单
- (IBAction)qdxdAction:(id)sender {
    
    if (_tempBtn.tag==0) {
        [self makeZhiFuBaoZhifu];
    }
    if (_tempBtn.tag==1) {
        [self makeWXZhifu];
    }
}
@end
