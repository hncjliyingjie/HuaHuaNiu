 //
//  GWTJViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "GWTJViewController.h"
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
#import "GBWXPayManager.h"
//#import "WXApiRequestHandler.h"
//#import "WXApiManager.h"
//#import "RespForWeChatViewController.h"
//#import "Constant.h"
#import "DataSigner.h"

@implementation Product


@end

@interface GWTJViewController ()
{
    NSString * prices;
    NSDictionary * Sedic;
    NSString *orderno;
}

@end

@implementation GWTJViewController
-(id)initWithDic:(NSDictionary *)dic{
    self =[super init];
    if (self) {
        DataDic =[[NSDictionary alloc]initWithDictionary:dic];
    }
    return self;
}
- (void)viewDidLoad {
    NSLog(@"%@",dingStr);
      orderno = [NSString stringWithFormat:@"%ld",time(0)];
    a = 20;
    mmmm =  NO;
    [super viewDidLoad];
    AddressDic=[[NSDictionary alloc]init];
    
    self.navigationItem.title=@"提交订单";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    GroupArr =[[NSMutableArray alloc]init];
    self.view.backgroundColor = BackColor;
    [self maketopAFDD];
    [self morendizhi];
    // 从购物车获取数据
    [self makeDingdanData];
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
//请求订单数据
-(void)makeDingdanData{
  StoreIdstr = @"";
    PeiSongStr =@"";
    YunFeiStr =@"";
    GroupArr =[[NSMutableArray alloc]initWithArray:[DataDic objectForKey:@"list"]];
    //(@"%@",GroupArr);
    for (NSDictionary * StoreDic  in GroupArr) {
        NSArray * goodArr =[[NSArray alloc]initWithArray:[StoreDic objectForKey:@"goods"]];
       
        StoreIdstr =[NSString stringWithFormat:@"%@,%@",StoreIdstr,[goodArr[0] objectForKey:@"store_id"]];
        

        PeiSongStr =[NSString stringWithFormat:@"%@,%@",PeiSongStr,[StoreDic objectForKey:@"spec_id"]];
        
        YunFeiStr =[NSString stringWithFormat:@"%@,%@",YunFeiStr , [StoreDic objectForKey:@"fee"]];
    }
    StoreIdstr =[StoreIdstr stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    PeiSongStr =[PeiSongStr stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    YunFeiStr =[YunFeiStr stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    
}
//制作tableview
-(void)makeTabele{
IOS_Frame
    _tv =[[UITableView alloc]initWithFrame:CGRectMake(0, 70, ConentViewWidth, ConentViewHeight-70) style:UITableViewStyleGrouped];
    _tv.delegate=self;
    _tv.dataSource =self;
    
    _tv.backgroundColor =BackColor;
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
   
    
       footViews.frame =CGRectMake(0, 0, ConentViewWidth, 40 + 45*ZhiFDataArr.count);
    [footViews addSubview:ZhiTv];
    
    
    _tv.tableFooterView =footViews;
    [self.view addSubview:_tv];
    
    UIView * buyView =[[UIView alloc]initWithFrame:CGRectMake(0,ConentViewHeight - 40, ConentViewWidth, 40)];
    buyView.backgroundColor =[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8];
    UILabel * zhilabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 70, 40)];
    zhilabel.text =@"支付金额:";
    zhilabel.font =[UIFont systemFontOfSize:13];
    AllPricelabel =[[UILabel alloc]initWithFrame:CGRectMake(75, 0, 100, 40)];
    AllPricelabel.font =[UIFont systemFontOfSize:13];
    AllPricelabel.textColor =[UIColor redColor];
    AllPricelabel.text =[NSString stringWithFormat:@"￥ %@",[DataDic objectForKey:@"amount"]];
    NSLog(@"%@",[DataDic objectForKey:@"amount"]);
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
    [self makeDingDanAdd];
}
-(void)zhiFuFangShi{
    if (a==0) {
        // 支付宝支付
        //(@"支付宝支付");
        [self  makeZhiFuBaoZhifu];
    }
    
    else if (a==1){
        NSArray * dingArr =[NSArray array];
        NSLog(@"[GBWXPayManager sharedManager].orderId = dingStr:%@",dingStr);
        dingArr =[dingStr componentsSeparatedByString:@","];
        NSLog(@"%@",dingArr[0]);
        //        price =[allprice componentsSeparatedByString:@","];
        NSString *orderno   = [NSString stringWithFormat:@"%ld",time(0)];
        [GBWXPayManager sharedManager].orderId = dingArr[0];
        [GBWXPayManager wxpayWithOrderID:orderno orderTitle:@"代言城" amount:[DataDic objectForKey:@"amount"]];
        //        [self makeweixinzhifu];
        //        NSString *res = [WXApiRequestHandler jumpToBizPay];
        //        if( ![@"" isEqual:res] ){
        //            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //
        //            [alter show];
        //        }
        
        ////      微信支付
        ////         (@"微信支付");
    }
    
    else{
        
        UIAlertView *aaall =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择支付方式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [aaall show];
        return;
    }
    
    
    
    
    
    

}
#pragma mark 提交订单
-(void)makeDingDanAdd{
//
//    //  提交的订单  商家的id号
//  //  //(@"store -=  %@,  AddressDic  = %@",StoreIdstr,AddressDic);
//    // 先提交订单  成功之后 在  去支付
//    
//    
    NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[userdefault objectForKey:@"Useid"];
    NSString *user_name =[userdefault objectForKey:@"UserName"];
    // NSUserDefaults *Userdefault =[NSUserDefaults standardUserDefaults];
    
    NSString *LoginStr =[NSString stringWithFormat:AddDingDan] ;
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
//
//    
//    /*
//     user_id 用户id
//     user_name用户昵称
//     store_id 店铺id用逗号隔开
//     region_id 区域id
//     region_name 区域名称 例如：中国	河南省	郑州市
//     address 地址
//     zipcode 邮编
//     phone_mob 手机
//     consignee 收获人姓名
//     
//     */

    NSArray *KeyArr =@[@"token",@"member_id",@"user_name",@"store_id",@"region_id",@"region_name",@"address",@"zipcode",@"phone_mob",@"consignee",@"shippingid",@"shippingfee"];


    NSString * str1 =[NSString stringWithFormat:@"%@",[AddressDic objectForKey:@"region_id"]];
    NSString * str2 =[NSString stringWithFormat:@"%@",[AddressDic objectForKey:@"zipcode"]];
    NSString * str3 =[NSString stringWithFormat:@"%@",[AddressDic objectForKey:@"mobile"]];
    
    NSString * str4 = [[user_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * str5 = [[AddressDic objectForKey:@"address"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
    NSString * str6 = [[AddressDic objectForKey:@"consignee"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
    NSString * str7 = [[AddressDic objectForKey:@"region_name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];




    NSArray *ValueArr =@[@"test",userID,str4,StoreIdstr,str1,str7,str5,str2,str3,str6,@"0,0",YunFeiStr];
    
       NSDictionary *dic =[[NSDictionary alloc]initWithObjects:ValueArr forKeys:KeyArr];
    //    //(@"先提交订单  成功之后 在  去支付");
    [manager POST:LoginStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        //(@"%@",responseObject);
            dingStr = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"orderids"]];
        
        prices = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"prices"]];
        [self zhiFuFangShi];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"%@",error);
        //(@"operation = %@",operation.responseString);
    }];
//

}
#pragma mark UItableview 代理
// 返回每一组的行数
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView  == _tv) {
   
    NSArray *ssaRR =[[NSArray alloc]initWithArray:[GroupArr[section] objectForKey:@"goods"]];
    return ssaRR.count;
    }
    else{
        return ZhiFDataArr.count;
    }
}
// 分组个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView   == _tv) {
         return GroupArr.count;
    }
    else{
        return 1;
    }
   

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tv) {
         return 70;
    }
    else{
        return 45;
    }
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView ==_tv) {
        return 30;
    }
    else{
    return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView ==_tv) {
        return 50;
    }
    else{
        return 1;
    }
}
// 头View
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tv) {
    
    UIView * headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 30)];
    UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ConentViewWidth -10, 30)];
    label.text =[NSString stringWithFormat:@"%@",[GroupArr[section] objectForKey:@"store_name"]] ;
    [headView addSubview:label];
    return headView;
    }
    else{
        return nil;
    }
    
}
//脚View
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == _tv) {
    UIView *FootView=[[UIView alloc]initWithFrame:CGRectMake(0, 5, ConentViewWidth, 40)];
    Sedic =[[NSDictionary alloc]initWithDictionary:GroupArr[section]];
    UILabel * PeiSongLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 20)];
      PeiSongLabel.text = @"运费:";
    PeiSongLabel.font =[UIFont systemFontOfSize:13];
 
     UILabel *yunFei =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth -110, 5, 60, 20)];
    yunFei.font =[UIFont systemFontOfSize:13];
    //运费没有返回
        NSArray * yunfeArr =[YunFeiStr componentsSeparatedByString:@","];
        if (section < yunfeArr.count) {
          
            yunFei.text =[NSString stringWithFormat:@"￥%@",yunfeArr[section]];//@"￥123.12";
            if ([yunFei.text isEqualToString:@"￥0.00"]) {
                yunFei.text=@"免邮";
            }
        }
        else{
        yunFei.text =@"免邮";
        }
        
    UILabel * shangPinJianshu =[[UILabel alloc]initWithFrame:CGRectMake(10, 25, 80, 20)];
    shangPinJianshu.text =[NSString stringWithFormat:@"共%@件商品",[Sedic objectForKey:@"quantity"]];
    shangPinJianshu.font =[UIFont systemFontOfSize:13];
    UILabel * zongji=[[UILabel   alloc]initWithFrame:CGRectMake(ConentViewWidth-110, 25, 30, 20)];
    zongji.text =@"总计:";
    zongji.font =[UIFont systemFontOfSize:13];
    UILabel *zongjiPrice =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth-80, 25, 70, 20)];
    zongjiPrice.font =[UIFont systemFontOfSize:13];
    zongjiPrice.textColor =[UIColor redColor];
    zongjiPrice.textAlignment =NSTextAlignmentLeft;
    zongjiPrice.text =[NSString stringWithFormat:@"￥ %@",[Sedic objectForKey:@"amount"]];
    
    
    [FootView addSubview:PeiSongLabel ];
  
    [FootView addSubview:shangPinJianshu ];
    [FootView addSubview:zongji ];
    [FootView addSubview:PeiSongLabel ];
    [FootView addSubview:zongjiPrice];
    
    FootView.backgroundColor =[UIColor whiteColor];
    [FootView addSubview:yunFei];
    
    return FootView;
    }
    else{
        return nil;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( tableView ==_tv) {
    TJDDDTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell== nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"TJDDDTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    NSArray * GoodArr =[GroupArr[indexPath.section] objectForKey:@"goods"];
    [cell cellMakeWithDicss:GoodArr[indexPath.row]];
    return cell;
    }
    else{
        FangShiTableViewCell * lcell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (lcell == nil) {
            lcell =[[[NSBundle mainBundle]loadNibNamed:@"FangShiTableViewCell" owner:self options:nil]lastObject];
        }
        NSMutableDictionary * ddic =ZhiFDataArr[indexPath.row];
        [lcell cellMakeWithDicss:ddic];
        
        return lcell;
    
    
    }
//    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    return cell;

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==ZhiTv) {
        a = indexPath.row;
        mmmm = YES;
        for ( NSMutableDictionary * diic  in ZhiFDataArr) {
            [diic setValue:@"NO" forKey:@"xuan"];
        }
        NSMutableDictionary * Sdic =ZhiFDataArr[indexPath.row];
        [Sdic setValue:@"YES" forKey:@"xuan"];
        
        // 把其他的置为 NO 选中的职位YES; 获取 使用什么支付的
        //(@"%@",ZhiFDataArr);
        
        [ZhiTv reloadData];
    }
}
// 显示默认地址
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
                    AddressDic = addDic;
                    [TopAddView ViewmakedataWithdi:AddressDic];
                    break;
                }
                n++;
            }
            if (dataArr.count == n) {
                [TopAddView ViewmakedataWithdi:nil];
            }
            //[self morendizhiDIc:AddressDic];
            /*
             "addr_id": "194",
             "user_id": "0",
             "consignee": "邢行",
             "region_id": "56685",
             "region_name": "山西 临汾 吉县",
             "address": "积极多",
             "zipcode": "586523",
             "phone_tel": "5652865245",
             "phone_mob": "13460208979",
             "user_address_ll": "36.158677317484,110.7281619704",
             "state": "0"
             */
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
        //(@"%@",AddressDic);
        [TopAddView ViewmakedataWithdi:dic];
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSArray * dingArr =[NSArray arrayWithArray:[dingStr componentsSeparatedByString:@","]];
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
    order.amount = [Sedic objectForKey:@"amount"]; //商品价格
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
        NSDictionary *dic =@{@"token":@"test",@"order_id":orderno,@"order_amount":[DataDic objectForKey:@"amount"],@"order_desc":@"productDescription"};
       NSLog(@"%@",dic);
        [manager POST:ZHIFU_REQUEST parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            //   获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
            //    id<DataSigner> signer = CreateRSADataSigner(privateKey);
            //NSString *signedString = [signer signString:orderSpec]; //商品信息拼接成的字符串orderSpec
            
            NSString *signedString=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"sign"]];
            NSString *ordStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"payInfo"]];
            
            //(@"%@",signedString);
            //        signedString =[signedString stringByReplacingOccurrencesOfString:@" " withString:@""];
            //        [signedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
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
                        NSString * resquestUrl =[NSString stringWithFormat:ZHIFUHD,dingArr[0],@"1"];
                        [[RequestManger share]requestDataByGetWithPath:resquestUrl complete:^(NSDictionary *data) {
                            (@"%@",[data objectForKey:@"result"]);
                            (@"%@",[data objectForKey:@"msg"]);
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


-(void)requestRst{

}



-(void)makeweixinzhifu{
    
    
    NSString * ShouY =[NSString stringWithFormat:@"http://182.92.66.70:8080/index.php?app=order_api&act=wxpay_data&order_id=%@",dingStr];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //(@"res ==%@",[responseObject objectForKey:@"retval"]);
   
    NSDictionary * dict =[[NSDictionary alloc]initWithDictionary:[responseObject objectForKey:@"retval"]];
    if(dict != nil){
        NSMutableString *retcode = [dict objectForKey:@"retcode"];
        if (retcode.intValue == 0){
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
            BOOL rep = [WXApi sendReq:req];
            if (rep) {//支付成功
                NSLog(@"支付成功");
            }else{
                //支付失败
                NSLog(@"支付失败");
            }
            //日志输出
            //(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        }else{
            [self alert:@"提示信息" msg:[dict objectForKey:@"retmsg"]];
        }
    }else{
        [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
    }
    
    
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        //(@"cook load failed ,%@",error);
}];


    
    
  ////(@"订单号 %@ 金额  %@ ",store_id)
    
    //商户服务器生成支付订单，先调用【统一下单API】生成预付单，获取到prepay_id后将参数再次签名传输给APP发起支付。以下是调起微信支付的关键代码：
    /*
      1   后台  把订单签名认证返回签名后的数据， app调用微信支付。
     
           1 客户端获取数据      支付数据地址   和  签名字符串（UTF8 或者GBK）（考虑编码格式）  对返回的数据进行验证查格式看是否正确
     
           2  客户端进行解析  调用微信支付
           3  对结果进行验证（后台传数据）
           4   客户端 提示 （支付成功或者失败）
     
          签名认证 商户的API密钥问题没有解决
     
     
     */
    
    // 订单 id   dingStr；
    // 价格    NSString * priceStr =[NSString stringWithFormat:@"%@",[DataDic objectForKey:@"amount"]];

    
    /*
     // 账号帐户资料
     //更改商户把相关参数后可测试
     
     #define APP_ID          @""               //APPID
     #define APP_SECRET      @"" //appsecret
     //商户号，填写商户对应参数
     #define MCH_ID          @""
     //商户API密钥，填写相应参数
     #define PARTNER_ID      @""
     //支付结果回调页面
     #define NOTIFY_URL      @"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php"
     //获取服务器端支付数据地址（商户自定义）
     #define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"
//     */
//    //获取服务器端支付数据地址（商户自定义）
//    NSString* SP_URLSTR =[NSString stringWithFormat:@"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"];
//    
//    //从服务器获取支付参数，服务端自定义处理逻辑和格式
//    
//    //订单标题
//      NSString *ORDER_NAME    = @"订单名字";
//
//     //订单金额，单位（元）
//      NSString * priceStr =[NSString stringWithFormat:@"%@",[DataDic objectForKey:@"amount"]];
//    NSString *ORDER_PRICE   = [NSString stringWithFormat:@"%f",[priceStr floatValue]];
//    
//    //根据服务器端编码确定是否转码
//    NSStringEncoding enc;
//    //if UTF8编码
//    //enc = NSUTF8StringEncoding;
//    //if GBK编码
//    enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *urlString = [NSString stringWithFormat:@"%@?plat=ios&order_no=%@&product_name=%@&order_price=%@",
//                           SP_URLSTR,
//                           [[NSString stringWithFormat:@"%ld",time(0)] stringByAddingPercentEscapesUsingEncoding:enc],
//                           [ORDER_NAME stringByAddingPercentEscapesUsingEncoding:enc],
//                           ORDER_PRICE];
//    
//    /* 2  处理服务器返回的json数据*/
//  
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if ( response != nil) {
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        //(@"url:%@",urlString);
//        // 判断签名数据的格式 对不对 进行验证
//        if(dict != nil){
//            NSMutableString *retcode = [dict objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                
//                //调起微信支付
//                PayReq* req             = [[PayReq alloc] init];
//                req.openID              = [dict objectForKey:@"appid"];
//                req.partnerId           = [dict objectForKey:@"partnerid"];
//                req.prepayId            = [dict objectForKey:@"prepayid"];
//                req.nonceStr            = [dict objectForKey:@"noncestr"];
//                req.timeStamp           = stamp.intValue;
//                req.package             = [dict objectForKey:@"package"];
//                req.sign                = [dict objectForKey:@"sign"];
//                [WXApi sendReq:req];
//                //日志输出
//                //(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//            }else{
//                [self alert:@"提示信息" msg:[dict objectForKey:@"retmsg"]];
//            }
//        }else{
//            [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
//        }
//    }else{//response = nil
//        [self alert:@"提示信息" msg:@"服务器返回错误"];
//    }
//
//    
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
                    NSLog(@"%@",[data objectForKey:@"result"]);
                    NSLog(@"%@",[data objectForKey:@"msg"]);
                    
                }];
            }
                //(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
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










/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
