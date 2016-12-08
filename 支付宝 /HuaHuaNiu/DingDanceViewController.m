//
//  DingDanceViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-28.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "DingDanceViewController.h"
#import "DIngDanceTableViewCell.h"
#import "AFNetworking.h"
#import "ProductDetailViewController.h"
#import "Toast+UIView.h"
#import "AddPLVViewController.h"
#import "StoreDetailsViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DingDanJSViewController.h"
#import "DingDanDeatilViewController.h"
@implementation Products


@end

@interface DingDanceViewController ()<DetailDelegate>

@end

@implementation DingDanceViewController




- (void)viewDidLoad {
    self.view.backgroundColor =[UIColor whiteColor];
 //   DataArr=[[NSMutableArray alloc]init];
    GroupDataArr=[[NSMutableArray alloc]init];
    [super viewDidLoad];
    [self createSelector];
    [self makeDIngData];
   
    self.navigationItem.title=@"我的订单";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame =CGRectMake(0, 0, 64, 27);
    [rightBtn  setTitle:@"全部" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(rightAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
   
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{
    //(@"全部订单");
    [self requestDataForDingDanWithPage:1 showCount:5 Statas:@"0"];
}

-(void)requestDataForDingDanWithPage:(int)page showCount:(int)count Statas:(NSString *)stats{
    NSString * userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Useid"];
    AFHTTPRequestOperationManager * manger =[AFHTTPRequestOperationManager manager];
    NSString * requestUrl;
    if ([stats isEqualToString:@"0"]) {
        requestUrl =[NSString stringWithFormat:ALLDingDan,userId,page,count];
    }else{
        requestUrl =[NSString stringWithFormat:DingDan,userId,page,count,stats];
    }
    //(@"this is  xxxxxxx %@",requestUrl);
    [self.view makeToastActivity];
    [manger GET:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.view hideToastActivity];
        //(@"data is xxxx %@",responseObject);
        GroupDataArr =[responseObject objectForKey:@"orders"];
        [_tv reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    
}

-(void)createSelector{
    UIView * selector =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 40)];
    selector.backgroundColor =BackColor;
    NSArray * selectNames =@[@"待付款",@"待收货",@"待评价",@"退款"];
    for (NSInteger i = 0; i<4; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame =CGRectMake(i*ConentViewWidth/4, 0, ConentViewWidth/4, 40);
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.alpha =0.8;
        btn.tag =i+11000;
        [btn setTitle:selectNames[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectorClick:) forControlEvents:UIControlEventTouchUpInside];
        [selector addSubview:btn];
    }
    [self.view addSubview:selector];
    
}



-(void)selectorClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 11000:
        {
            //(@"待付款");
            [self requestDataForDingDanWithPage:1 showCount:5 Statas:@"1"];

        }
            break;
        case 11001:
        {
            //(@"待收货");
            [self requestDataForDingDanWithPage:1 showCount:5 Statas:@"3,4"];

        }
            break;
        case 11002:
        {
            //(@"待评价");
            [self requestDataForDingDanWithPage:1 showCount:5 Statas:@"5"];

        }
            break;
        case 11003:
        {
            //(@"退款");
            [self requestDataForDingDanWithPage:1 showCount:5 Statas:@"8,9"];
            
        }
            break;
            
        default:
            break;
    }
}
#pragma  mark 创建数据
-(void)makeDIngData{
    [self.view makeToastActivity];
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
   NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
  
   NSString * ShouY = [NSString stringWithFormat:ALLDingDan, userID,1,5];
    //(@"%@",ShouY);
   ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        GroupDataArr =[responseObject objectForKey:@"orders"];
        [self makeTVView];
  
        if(GroupDataArr.count == 0){
            UILabel * tisishsl =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
            tisishsl.textAlignment = NSTextAlignmentCenter;
            tisishsl.text =@"暂无数据";
            tisishsl.font =[UIFont systemFontOfSize:13];
            [self.view addSubview:tisishsl];
            tisishsl.tag =100;
        }
        
        else{
            UILabel * tisi =(UILabel *)[self.view  viewWithTag:100];
            tisi.hidden = YES;
        }
        
        [self.view hideToastActivity];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    
    

}
-(void)makeTVView{
IOS_Frame
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 40, ConentViewWidth, ConentViewHeight-40) style:UITableViewStyleGrouped];
    _tv.delegate =self;
    _tv.dataSource =self;
    [self.view addSubview:_tv];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  //  return DataArr.count;
    
    NSArray * Arr =[GroupDataArr[section] objectForKey:@"order_goods"];
    return Arr.count;
    
}
//设置tableview中的分组个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return GroupDataArr.count;
}

//设置每个分组的头和尾的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    NSString * statue =[NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"status"]];
    //(@"xxxxx %@",statue);

    
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * statue =[NSString stringWithFormat:@"%@",[GroupDataArr[indexPath.section] objectForKey:@"status"]];

    NSString * ordId =[NSString stringWithFormat:@"%@",[GroupDataArr[indexPath.section] objectForKey:@"order_id"]];
    
    DingDanDeatilViewController * dddvc =[[DingDanDeatilViewController alloc]initWithStats:statue andOrdId:ordId];
    dddvc.delegate =self;
    dddvc.hidesBottomBarWhenPushed =YES;
    
    [self.navigationController pushViewController:dddvc animated:YES];
  
}
//设置每个分组的头视图为一个按钮
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * baView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 30)];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 320, 30);
    [btn setBackgroundColor:[UIColor clearColor]];
    NSString *titleStr;
    if ([GroupDataArr[section] objectForKey:@"seller_name"]){
        titleStr = [NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"seller_name"]];
    }else{
    titleStr = [NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"store_name"]];
    }

    UILabel * lane =[[UILabel alloc]initWithFrame:CGRectMake(20, 5, ConentViewWidth -120, 20)];
    lane.text =titleStr;
    lane.font =[UIFont systemFontOfSize:14];
    // [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 200+section;
    
    UILabel * DDStLabel =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth - 115, 5,110, 20)];
    DDStLabel.font =[UIFont systemFontOfSize:14];
    
    NSString * statue =[NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"status"]];
    //(@"statue == %@",statue);
    if ( [statue isEqualToString:@"5"]) {
    DDStLabel.text =@"买家已发货";
        //self.StatuLabel.text=@"卖家已发货";
    }
    else if([statue isEqualToString:@"3"]){
        DDStLabel.text =@"等待卖家发货";
     //   self.StatuLabel.text=@"等待卖家发货";
    }else if([statue isEqualToString:@"4"]){
        DDStLabel.text =@"卖家已发货";
     //   self.StatuLabel.text=@"卖家已发货";
    }else if([statue isEqualToString:@"6"]){
        DDStLabel.text =@"交易成功";
      //  self.StatuLabel.text=@"交易成功";
    }else if([statue isEqualToString:@"2"]){
        DDStLabel.text =@"交易已取消";
   //     self.StatuLabel.text=@"交易已取消";
    }else if([statue isEqualToString:@"1"]){
        DDStLabel.text =@"买家未付款";
        //     self.StatuLabel.text=@"交易已取消";
    }else{
        DDStLabel.text =@"订单已过期失效";
     //   self.StatuLabel.text=@"等待买家付款";
    }

    
    
//    [baView addSubview:DDStLabel];
    [baView addSubview:lane];
    [baView addSubview:btn];
    baView.backgroundColor = BackColor;
    return baView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * FootView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 40)];
    FootView.backgroundColor = BackColor;
    UILabel *lin =[[UILabel alloc]initWithFrame:CGRectMake(0, 29, ConentViewWidth, 0.5)];
    lin.backgroundColor =[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    [FootView addSubview:lin];
    UIView * tmpView =[[UIView alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth, 10)];
    tmpView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [FootView addSubview:tmpView];

    
    UILabel *lb =[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 200, 20)];
    lb.textColor =[UIColor orangeColor];
    lb.font =[UIFont systemFontOfSize:12];
    [FootView addSubview:lb];
 
    NSString * statue =[NSString stringWithFormat:@"%@",[GroupDataArr[section] objectForKey:@"status"]];
    //(@"Statue = %@\n",statue);
    
    if ( [statue isEqualToString:@"1"]) {
        //self.StatuLabel.text=@"卖家已发货";
        lb.text =@"订单状态: 待付款";
    }
    else if([statue isEqualToString:@"2"]){
        lb.text =@"订单状态: 已取消";
        //   self.StatuLabel.text=@"等待卖家发货";
    }else if([statue isEqualToString:@"3"]){
        lb.text =@"订单状态: 待发货";

        //   self.StatuLabel.text=@"卖家已发货";
    }else if([statue isEqualToString:@"4"]){
        lb.text =@"订单状态: 已发货";

        //  self.StatuLabel.text=@"交易成功";
    }else if([statue isEqualToString:@"5"]){
        lb.text =@"订单状态: 已收货";

        //     self.StatuLabel.text=@"交易已取消";
    }else if([statue isEqualToString:@"6"]){
        lb.text =@"订单状态: 交易完成";
        
        //     self.StatuLabel.text=@"交易已取消";
    }else if([statue isEqualToString:@"7"]){
        lb.text =@"订单状态: 过期失效";
        
        //     self.StatuLabel.text=@"交易已取消";
    }else if([statue isEqualToString:@"8"]){
        lb.text =@"订单状态: 退款中";
        
        //     self.StatuLabel.text=@"交易已取消";
    }else if([statue isEqualToString:@"9"]){
        lb.text =@"订单状态: 已退款";
        
        //     self.StatuLabel.text=@"交易已取消";
    }
    
    
  return FootView;


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        DIngDanceTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DIngDanceTableViewCell" owner:self options:nil]lastObject];
    }
    NSArray  *Arr =[GroupDataArr[indexPath.section] objectForKey:@"order_goods"];
    NSDictionary * dic =Arr[indexPath.row];
    
    [cell cellMakeWIthDic:dic];
    
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return  cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//每个分组脚的点击事件
-(void)FootbtnClick:(UIButton *)Btn{
    
        
        
//        //(@"去付款 *  %d",Btn.tag- 400);
//
//        // 要支付的订单
   NSDictionary * DingDZdic =  [[NSDictionary alloc]initWithDictionary:GroupDataArr[Btn.tag -400]];

    DingDanJSViewController * ds =[[DingDanJSViewController alloc]initWithDic:DingDZdic];
    [self.navigationController pushViewController:ds animated:YES];
    


}

//每个分组头的事件
-(void)btnClick:(UIButton *)btn{
    //(@"%@",[GroupDataArr[btn.tag-200] objectForKey:@"seller_name"]);
    // 商家详情
    NSString * Soresid;
    if ([GroupDataArr[btn.tag-200] objectForKey:@"store_id"]) {
        Soresid =[ NSString stringWithFormat:@"%@",[GroupDataArr[btn.tag-200] objectForKey:@"store_id"]];

    }else{
    Soresid =[ NSString stringWithFormat:@"%@",[GroupDataArr[btn.tag-200] objectForKey:@"seller_id"]];
    }
    StoreDetailsViewController * svc =[[StoreDetailsViewController alloc]initWithStr:Soresid];
    [self.navigationController pushViewController:svc animated:YES];
    }

#pragma mark 支付宝支付
-(void)makeZhiFuBaoZhifuWiThDic:(NSDictionary * )MYdic {
    
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
    NSString *seller = @"bbnkjzg@126.com";// 支付宝账号
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
    order.tradeNO = orderStr ;   //@"123123";  //订单ID（由商家自行制定）
    //    order.productName = product.subject; //商品标题
    order.productName = @"测试";  //商品标题
    //    order.productDescription = product.body; //商品描述
    order.productDescription = @"真的是测试";  //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[acount floatValue]];  //商品价格
    order.notifyURL = [NSString stringWithFormat:ZHIFUHD,@"1"]; //回调URL

    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkhuahuaniu";
    
    //将商品信息拼接成字符串orderSpec
    NSString *orderSpec = [order description];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    NSDictionary *dic =@{@"token":@"test",@"order_id":orderStr,@"order_amount":[NSString stringWithFormat:@"%.2f",[acount floatValue]],@"order_desc":@"productDescription"};
    //(@"%@",dic);
    [manager POST:ZHIFU_REQUEST parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

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
                    NSString * resquestUrl =[NSString stringWithFormat:ZHIFUHD,orderStr];
                    [[RequestManger share]requestDataByGetWithPath:resquestUrl complete:^(NSDictionary *data) {
                        //(@"%@",[data objectForKey:@"result"]);
                        //(@"%@",[data objectForKey:@"msg"]);
                    }];
                }
                else if ([str isEqualToString:@"8000"]) {
                    status =@"正在处理中";
                }
                else if ([str isEqualToString:@"6001"]) {
                    status =@"用户中途取消";
                    NSString * resquestUrl =[NSString stringWithFormat:ZHIFUHD,orderStr];
                    [[RequestManger share]requestDataByGetWithPath:resquestUrl complete:^(NSDictionary *data) {
                        //(@"%@",[data objectForKey:@"result"]);
                        //(@"%@",[data objectForKey:@"msg"]);
                    }];
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

-(void)reloadTabelView{
    [self requestDataForDingDanWithPage:1 showCount:5 Statas:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
