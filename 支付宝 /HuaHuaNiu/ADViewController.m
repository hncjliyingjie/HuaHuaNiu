//
//  ADViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ADViewController.h"
#import "XiangGuanTableViewCell.h"
#import "ProductDetailViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Toast+UIView.h"
#import "ShangJiaShangDianViewController.h"
#import "UMSocial.h"
#import "WXApi.h"
#import "CoreUMeng.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ADViewController ()<UIWebViewDelegate>
{
    UIWebView *_imgWeb;
    NSTimer *timer;
}

@end

@implementation ADViewController

-(id)initWithADStr:(NSString *)Str andType:(NSString *)type{
    self =[super init];
    if (self) {
        XianqingID = Str;
        typeStr =type;
    }

    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackColor;
    self.navigationItem.title=@"看看有奖";

    [self creatADData];
    
    //返回按钮
    UIImage *lbbImage = [UIImage imageNamed:@"back_new"];
    lbbImage = [lbbImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * lbbItem = [[UIBarButtonItem alloc] initWithImage:lbbImage style:UIBarButtonItemStylePlain target:self action:@selector(BackAction)];
    self.navigationItem.leftBarButtonItem = lbbItem;
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ShareActComeIn{
    
    NSString * ShareStr =[NSString stringWithFormat:FenXiangLJ,typeStr,XianqingID];
    
    NSString * concentStr =[NSString stringWithFormat:@"#代言城#来自代言城客户端"];
    [CoreUmengShare show:self text:concentStr image:topImage.image];
    //                                           delegate:nil];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url =ShareStr;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"来自代言城的分享内容";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"来自代言城的分享内容";
    
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        [self   MakeShouyi];
        isShare = YES;
    }
}

// 获取去收益
-(void)MakeShouyi{
    NSUserDefaults * UserDefault = [NSUserDefaults standardUserDefaults];
    NSString * userID =[UserDefault objectForKey:@"Useid"];
    NSString * adName = [DataDic objectForKey:@"ad_name"];
    //id 广告id   user_id 用户id
    NSString *ShouY = [NSString stringWithFormat:JRSHOUYI,userID,adName,XianqingID];

    ShouY =[[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    //(@"%@",ShouY);
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString * ture =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
       
        if ([ture isEqualToString:@"1"]) {
           
            
            UILabel * TSlabel =[[UILabel alloc ]initWithFrame:CGRectMake(20, ConentViewHeight  - 70, ConentViewWidth - 40, 30)];
            TSlabel.text =@"+1积分";
            if (isShare) {
            TSlabel.text =@"+1积分";
            }
            TSlabel.textColor =[UIColor whiteColor];
            TSlabel.textAlignment =NSTextAlignmentCenter;
            TSlabel.backgroundColor =[UIColor blackColor];
            [self.view addSubview:TSlabel];
            _imgWeb=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            _imgWeb.backgroundColor = [UIColor clearColor]; _imgWeb.opaque = NO;
            for (UIView *subView in [_imgWeb subviews]) {
                if ([subView isKindOfClass:[UIScrollView class]]) {
                    ((UIScrollView *)subView).bounces = NO;
                    ((UIScrollView *)subView).scrollEnabled = NO;
                    for (UIView *shadowView in [subView subviews]) {
                        if ([shadowView isKindOfClass:[UIImageView class]]) {
                            shadowView.hidden = YES;
                        }
                    }
                }
            }
            
            _imgWeb.delegate=self;
            _imgWeb.scalesPageToFit = YES;
            //    [webView lo];
            NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"未标题-1(1)" ofType:@"gif"]];
            [_imgWeb loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"bgm_coin_01" ofType:@"mp3"];
            SystemSoundID soundID;
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
            AudioServicesPlaySystemSound (soundID);
            timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopWebView) userInfo:nil repeats:NO];
            _imgWeb.hidden=NO;
            [self.view addSubview:_imgWeb];
           
            
           
            [UIView animateWithDuration:2 animations:^{
                //TSlabel.hidden = YES;
                TSlabel.alpha = 0;
            } completion:^(BOOL finished) {
                [TSlabel removeFromSuperview];
            }];

        }
        else{
             //(@"没有获取收益");
            UILabel * TSlabel =[[UILabel alloc ]initWithFrame:CGRectMake(20, ConentViewHeight  - 70, ConentViewWidth - 40, 30)];
            TSlabel.text =[responseObject objectForKey:@"msg"];
            TSlabel.textColor =[UIColor whiteColor];
            TSlabel.textAlignment =NSTextAlignmentCenter;
            TSlabel.backgroundColor =[UIColor blackColor];
            [self.view addSubview:TSlabel];
            

            [UIView animateWithDuration:2 animations:^{
                //TSlabel.hidden = YES;
                TSlabel.alpha = 0;
            } completion:^(BOOL finished) {
                [TSlabel removeFromSuperview];
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
}

-(void)stopWebView{
    NSLog(@"1111");
    _imgWeb.hidden=YES;
}

-(void)creatADData{
    [self.view makeToastActivity];
  // adtype类型   2店铺  3商品 advalue 店铺或商品的id
    NSString *ShouY = [NSString stringWithFormat:LOOKXIANGQING,XianqingID];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DataDic=[[NSDictionary alloc]init];
        DataDic =responseObject;

        [self makeUI];

        [self.view hideToastActivity];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
}
-(void)makeUI{
    BackView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight )];
    BackView.bounces = NO;
    BackView.showsVerticalScrollIndicator = NO;
    BackView.backgroundColor =BackColor;
    BackView.contentSize=CGSizeMake(ConentViewWidth, 750);
    [self.view addSubview:BackView ];
    
    
// 我看了 按钮
    UIButton *look = [UIButton buttonWithType:UIButtonTypeCustom];
    look.frame = CGRectMake(10, ConentViewHeight - 30, ConentViewWidth/2 - 20, 30);
    [look setBackgroundColor:[UIColor colorWithRed:246/255.0 green:125/255.0 blue:137/255.0 alpha:1.0]];
    look.alpha= 1;
    look.titleLabel.font =[UIFont systemFontOfSize:15];
    [look addTarget:self action:@selector(MakeShouyi) forControlEvents:UIControlEventTouchUpInside];
    [look setTitle:@"我看了" forState:UIControlStateNormal];
    [self.view addSubview:look];
    
    
    
    
// 分享 按钮
    UIButton *ShareBt =[UIButton buttonWithType:UIButtonTypeCustom];
    ShareBt.frame =CGRectMake(ConentViewWidth/2+10, ConentViewHeight-30,ConentViewWidth/2-20, 30);
    [ShareBt setBackgroundColor:[UIColor colorWithRed:246/255.0 green:125/255.0 blue:137/255.0 alpha:1.0]];
    ShareBt.alpha= 1;
    ShareBt.titleLabel.font =[UIFont systemFontOfSize:15];
    [ShareBt addTarget:self action:@selector(ShareActComeIn) forControlEvents:UIControlEventTouchUpInside];
    
    [ShareBt setTitle:@"分享获得收益" forState:UIControlStateNormal];
//    
    [self.view addSubview:ShareBt];
    
    topImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 150)];
    [topImage  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[DataDic objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"Default.png"]];

    [BackView addSubview:topImage];
//  商品图片View
#pragma  mark 产品组图暂时不要
    UIView *iamViwe =[[UIView alloc]initWithFrame:CGRectMake(5, topImage.frame.origin.y+topImage.frame.size.height , ConentViewWidth-10, 0)];
    [BackView addSubview:iamViwe];
// 相关产品
      NSArray * ARRR = [[NSArray alloc]initWithArray:[DataDic objectForKey:@"goods"]];
      TVdataArr =[[NSMutableArray  alloc]initWithArray:ARRR];
    UIView *XiangGuanView  =[[UIView alloc]initWithFrame:CGRectMake(5, iamViwe.frame.origin.y+iamViwe.frame.size.height+10, ConentViewWidth-10, 300)];
    if (ARRR.count >3) {
        [TVdataArr addObject:ARRR[0]];
        [TVdataArr addObject:ARRR[1]];
        [TVdataArr addObject:ARRR[2]];
    }
    else if(TVdataArr.count == 0){
         XiangGuanView.frame =CGRectMake(5, iamViwe.frame.origin.y+iamViwe.frame.size.height+10, ConentViewWidth-10, 50);
        UIImageView *ImaImagel =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
        ImaImagel.image =[UIImage imageNamed:@"app_xiangguanchanpin"];
        [XiangGuanView addSubview:ImaImagel];

        UILabel *XiangguanLabel =[[UILabel alloc]initWithFrame:CGRectMake(30, 5, 100, 20)];
        XiangguanLabel.font =[UIFont systemFontOfSize:14];
        XiangguanLabel.text=@"相关产品";
        [XiangGuanView addSubview:XiangguanLabel];
        UILabel *linLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 30, ConentViewWidth-10, 1)];
        linLabel.backgroundColor =BackColor;
        [XiangGuanView addSubview:linLabel];
        XiangGuanView.backgroundColor =[UIColor whiteColor];
        UILabel * nonlabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth-20, 20)];
        nonlabel.text =@"暂无相关产品";
        nonlabel.font =[UIFont systemFontOfSize:13];
        nonlabel.textAlignment =NSTextAlignmentCenter;
        [XiangGuanView addSubview:nonlabel];
        
    }
  else{
        TVdataArr  =[[NSMutableArray  alloc]initWithArray:ARRR];
        XiangGuanView.frame =CGRectMake(5, iamViwe.frame.origin.y+iamViwe.frame.size.height+10, ConentViewWidth-10, 80*TVdataArr.count);
    }

    if(TVdataArr.count == 0){
    //XiangGuanView.frame =CGRectMake(5, iamViwe.frame.origin.y+iamViwe.frame.size.height+10, ConentViewWidth-10, MoreLook.frame.origin.y+0);
    }
    else{
        UIImageView *ImaImagel =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
        ImaImagel.image =[UIImage imageNamed:@"app_xiangguanchanpin"];
        [XiangGuanView addSubview:ImaImagel];
        
        
        UILabel *XiangguanLabel =[[UILabel alloc]initWithFrame:CGRectMake(30, 5, 100, 20)];
        XiangguanLabel.font =[UIFont systemFontOfSize:14];
        XiangguanLabel.text=@"相关产品";
        [XiangGuanView addSubview:XiangguanLabel];
        UILabel *linLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 30, ConentViewWidth-10, 1)];
        linLabel.backgroundColor =BackColor;
        [XiangGuanView addSubview:linLabel];
        XiangGuanView.backgroundColor =[UIColor whiteColor];
        

        _TV =[[UITableView alloc]initWithFrame:CGRectMake(0, 32, ConentViewWidth-20, 80*TVdataArr.count) style:UITableViewStylePlain];
        _TV.delegate=self;
        _TV.dataSource =self;
        _TV.scrollEnabled = NO;
        [XiangGuanView addSubview:_TV];
   
    UIButton * MoreLook =[UIButton buttonWithType:UIButtonTypeCustom];
    MoreLook.frame=CGRectMake(0,_TV.frame.origin.y+_TV.frame.size.height, ConentViewWidth - 10, 30);
    [MoreLook addTarget:self action:@selector(MorelookAction) forControlEvents:UIControlEventTouchUpInside];
    [MoreLook setTitle:@"查看更多" forState:UIControlStateNormal];
    MoreLook.titleLabel.font =[UIFont systemFontOfSize:13];
    [MoreLook setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [XiangGuanView addSubview:MoreLook];
        
   XiangGuanView.frame =CGRectMake(5, iamViwe.frame.origin.y+iamViwe.frame.size.height+10, ConentViewWidth-10, MoreLook.frame.origin.y+MoreLook.frame.size.height);
    }

  [BackView addSubview:XiangGuanView];
// 产品介绍
    UIView *ChanPinJieShaoView =[[UIView alloc]initWithFrame:CGRectMake(5, XiangGuanView.frame.origin.y+XiangGuanView.frame.size.height+1, ConentViewWidth-10, 130)];
    ChanPinJieShaoView.backgroundColor=[UIColor whiteColor];

    UIImageView *ChanPinImaImagel =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    ChanPinImaImagel.image =[UIImage imageNamed:@"app_shangpin_images"];
    [ChanPinJieShaoView addSubview:ChanPinImaImagel];

    UILabel *ChanPinJieShaoLabel =[[UILabel alloc]initWithFrame:CGRectMake(30, 5, 100, 20)];
    ChanPinJieShaoLabel.font =[UIFont systemFontOfSize:14];
    ChanPinJieShaoLabel.text=@"相关介绍";
    [ChanPinJieShaoView addSubview:ChanPinJieShaoLabel];

    UILabel *linLabell =[[UILabel alloc]initWithFrame:CGRectMake(5, 30, ConentViewWidth-10, 1)];
    linLabell.backgroundColor =BackColor;
    [ChanPinJieShaoView addSubview:linLabell];
    UILabel *jieShaoLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 35, ConentViewWidth-10, 60)];
    jieShaoLabel.numberOfLines =0;
    jieShaoLabel.font=[UIFont systemFontOfSize:11];
    jieShaoLabel.text =[NSString stringWithFormat:@"%@",[DataDic objectForKey:@"summary"]];

    CGFloat HangNumber =jieShaoLabel.text.length/28 +1;
    jieShaoLabel.frame =CGRectMake(5, 35, ConentViewWidth-15, 15*HangNumber);
    ChanPinJieShaoView.frame=CGRectMake(5, XiangGuanView.frame.origin.y+XiangGuanView.frame.size.height+1, ConentViewWidth-10, 40+jieShaoLabel.frame.size.height);
    [ChanPinJieShaoView addSubview:jieShaoLabel];
  
    BackView.contentSize=CGSizeMake(ConentViewWidth, ChanPinJieShaoView.frame.size.height+ChanPinJieShaoView.frame.origin.y+35);
    
    [BackView addSubview:ChanPinJieShaoView];
    
}
-(void)MorelookAction{
    
    // 进入商家商店
    ShangJiaShangDianViewController * Svc =[[ShangJiaShangDianViewController alloc]initWithStoreID:XianqingID];
    [self.navigationController pushViewController:Svc animated:YES];

    //(@"12321  进入 商户的产品展示 界面");
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str =[TVdataArr[indexPath.row] objectForKey:@"goods_id"];
    ProductDetailViewController *Pvc =[[ProductDetailViewController alloc]initWithStr:str];
    [self.navigationController pushViewController:Pvc animated:YES];
    //(@"xuanze 进入产品详情");
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return TVdataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XiangGuanTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"XiangGuanTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    [cell XiangguancellmakeWIthDic:TVdataArr[indexPath.row]];
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
