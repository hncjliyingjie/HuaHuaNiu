//
//  ProductDetailViewController2.m
//  HuaHuaNiu
//
//  Created by 洪慧康 on 16/3/28.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ProductDetailViewController2.h"
#import "Toast+UIView.h"
#import "AFNetworking.h"
#import "dingDanTiJiaoViewController.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "YHWebViewImage.h"
#import "StoreDetailsViewController.h"
#import "ShangJiaShangDianViewController.h"
#import "LogViewController.h"
#import "UMSocial.h"
#import "CoreUMeng.h"


@interface ProductDetailViewController2 ()<UIWebViewDelegate,YHWebViewImageDelegate>
{
    UIWebView *_imgWeb;
    NSTimer *timer;
    UIView *lastView;
    UIView *IntroduceView;
    UIView *ComeInStore;
    UIView *StoreXiangqing;
}
@property (nonatomic,strong)UIView *phoneView;

@property (nonatomic,strong) YHWebViewImage *webview;
@property (weak, nonatomic) IBOutlet UIImageView *xianImage;
@property (weak, nonatomic) IBOutlet UILabel *xianTitle;
@property (weak, nonatomic) IBOutlet UIImageView *youImage;
@property (weak, nonatomic) IBOutlet UILabel *youTitle;
@property (weak, nonatomic) IBOutlet UILabel *youPrice;


@end

@implementation ProductDetailViewController2
-(id)initWithStr:(NSString *)str{
    self =[super init];
    if (self) {
        self.title = @"产品详情";
        ProductId = str;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //返回按钮
    UIImage *lbbImage = [UIImage imageNamed:@"back_new"];
    lbbImage = [lbbImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * lbbItem = [[UIBarButtonItem alloc] initWithImage:lbbImage style:UIBarButtonItemStylePlain target:self action:@selector(BackAction)];
    self.navigationItem.leftBarButtonItem = lbbItem;
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.lijiDuiHuan.layer.masksToBounds = YES;
    self.lijiDuiHuan.layer.cornerRadius = 10;
    self.lijiDuiHuan.backgroundColor = BarColor;
    [self makeData];
#pragma mark 收藏
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(0, 0, 15, 15)];
    [cancelBtn addTarget:self action:@selector(RightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"app_top_shoucang"] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *startBtn = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
#pragma mark 分享
    UIButton *cancelBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn1 setFrame:CGRectMake(0, 0, 15, 15)];
    [cancelBtn1 addTarget:self action:@selector(ShareActComeIn) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn1 setBackgroundImage:[UIImage imageNamed:@"app_top_fenxiang"] forState:UIControlStateNormal];
    [cancelBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn1.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *pauseBtn = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn1];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: pauseBtn,startBtn,nil]];
    // Do any additional setup after loading the view from its nib.
}

-(void)RightBtnAction:(UIButton *)Btn{
    //  收藏
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
        NSString *ShouY = [NSString stringWithFormat:SHOUCANG,UserIDs,@"goods",ProductId];
        //(@"%@",ShouY);
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // 1成功 0 失败
            //(@"%@",[responseObject objectForKey:@"result"]);
            UIAlertView  * SCAl =[[UIAlertView alloc]initWithTitle:@"提示" message:@"商品收藏成功，可在我的收藏中查看" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [SCAl show];
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];
    }
    
}
-(void)ShareActComeIn{
    NSUserDefaults * UserDefault = [NSUserDefaults standardUserDefaults];
    NSString * ShareStr =[NSString stringWithFormat:FenXiangshLJ,ProductId,1,[UserDefault objectForKey:@"Useid"]];
    
    NSString * concentStr =[NSString stringWithFormat:@"%@",DicDate[@"company"]];
    //_imgTitle.image
    [CoreUmengShare show:self text:concentStr image:[UIImage imageNamed:@"60"]];
    //                                           delegate:nil];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url =ShareStr;
    
    [UMSocialData defaultData].extConfig.qqData.url = ShareStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = ShareStr;
    
    NSString *ProductName = _labelTitle.text;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = ProductName;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = ProductName;
    [UMSocialData defaultData].extConfig.qqData.title = ProductName;
    [UMSocialData defaultData].extConfig.qzoneData.title = ProductName;
}

- (void)makeUI{
    
    
    [self setUpPhoneView];
    
    [self addWebView];
    
    [self addLastView];
}




-(void)makeData{
    [self.view makeToastActivity];
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    NSString *ShouY = [NSString stringWithFormat:ProductXiangqing,ProductId,1,[Userdefaults objectForKey:@"Useid"]];
    NSLog(@"%@",ProductId);
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //change_type： 商品兑换方式：0：全部  1：现场  2：邮寄
        DicDate =[[NSDictionary alloc]initWithDictionary:responseObject];
        NSLog(@"%@",DicDate);
        if ([[NSString stringWithFormat:@"%@",DicDate[@"change_type"]] isEqualToString:@"0"]) {
            self.youImage.hidden = NO;
            self.youTitle.hidden = NO;
            self.youFeiTitle.hidden = NO;
            
            self.xianImage.hidden = NO;
            self.xianTitle.hidden = NO;
        }else if ([[NSString stringWithFormat:@"%@",DicDate[@"change_type"]] isEqualToString:@"1"]){
            self.xianImage.hidden = NO;
            self.xianTitle.hidden = NO;
            
            self.youImage.hidden = YES;
            self.youTitle.hidden = YES;
            self.youFeiTitle.hidden = YES;
            
        }else if ([[NSString stringWithFormat:@"%@",DicDate[@"change_type"]] isEqualToString:@"2"]){
            self.youImage.hidden = NO;
            self.youTitle.hidden = NO;
            self.youFeiTitle.hidden = NO;
            
            self.xianImage.hidden = YES;
            self.xianTitle.hidden = YES;
        }
        [_imgTitle sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[DicDate objectForKey:@"default_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
        [_labelTitle setText:[DicDate objectForKey:@"goods_name"]];
        [_yinYuanlTitle setText:[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"sale_integral"]]];
        [_dingJiaTitle setText:[NSString stringWithFormat:@"¥%@",[DicDate objectForKey:@"original_price"]]];
        [_yiLiuLanlTitle setText:[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"has_lookers"]]];
        [_xuLiuLanTitle setText:[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"sale_lookers"]]];
        [_youFeiTitle setText:[NSString stringWithFormat:@"(所需邮费:¥ %@)",[DicDate objectForKey:@"fee"]]];
        [_totalNumTitle setText:[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"total_num"]]];
        [self.view hideToastActivity];
        //        [self makeScroller];
        //        [self makeBottomView];
        [self makeUI];
        [self makeFlow];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    
}
-(void)makeFlow{
    
    NSUserDefaults * UserDefault = [NSUserDefaults standardUserDefaults];
    NSString * userID =[UserDefault objectForKey:@"Useid"];
    
    //id 广告id   user_id 用户id
    NSString *ShouY = [NSString stringWithFormat:FLOWER,userID,nil,ProductId,nil];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * sreee =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
        UILabel * TSlabel =[[UILabel alloc ]initWithFrame:CGRectMake(20, ConentViewHeight  - 70, ConentViewWidth - 40, 30)];
        TSlabel.text =@"当天已获取银元";
        
        TSlabel.textColor =[UIColor whiteColor];
        TSlabel.textAlignment =NSTextAlignmentCenter;
        TSlabel.backgroundColor =[UIColor blackColor];
        [self.view addSubview:TSlabel];
        
        if ([sreee isEqualToString:@"1"]) {
            TSlabel.text =@"+2银元";
            TSlabel.textColor = [UIColor redColor];
            _imgWeb=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            _imgWeb.backgroundColor = [UIColor clearColor]; _imgWeb.opaque = NO;
            _imgWeb.scrollView.scrollEnabled = NO;
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
            
            //            _coinview = [[coinView alloc]initWithFrame:[self.view bounds] withNum:3];
            //            _coinview.coindelegate = self;
            [self.view addSubview:_imgWeb];
            
        }
        [UIView animateWithDuration:2 animations:^{
            //TSlabel.hidden = YES;
            TSlabel.alpha = 0;
        } completion:^(BOOL finished) {
            [TSlabel removeFromSuperview];
        }];
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



#pragma mark 打电话
-(void)setUpPhoneView{
    self.phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, self.fenGeXianView.frame.size.height+self.fenGeXianView.frame.origin.y+10, ConentViewWidth , 45)];
    self.phoneView.backgroundColor =[UIColor whiteColor];
    UITapGestureRecognizer *PhoneTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CallAction)];
    [self.phoneView addGestureRecognizer:PhoneTap];
    //公司name
    UILabel *companyName =[[UILabel alloc]initWithFrame:CGRectMake(5, 6, ConentViewWidth-100, 15)];
    companyName.text =[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"company"]];
    companyName.font =[UIFont systemFontOfSize:15];
    [self.phoneView addSubview:companyName];
    // 地址label
    UILabel *dizhLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 25, ConentViewWidth-100, 15)];
    dizhLabel.text=[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"company_address"]];
    dizhLabel.font =[UIFont systemFontOfSize:13];
    [self.phoneView addSubview:dizhLabel];
    
    UIImageView *PhoneImage =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth-55, 13, 20, 20)];
    PhoneImage.image =[UIImage imageNamed:@"app_button_tel"];
    [self.phoneView addSubview:PhoneImage];
    [self.backScrollView addSubview: self.phoneView];
}
#pragma mark - 添加 webView

- (void)addWebView{
    NSString *str = [DicDate objectForKey:@"description"];
    //截取字符串
    str = [str stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
    NSLog(@"%@",str);
    
    //创建webview
    self.webview = [[YHWebViewImage alloc] initWithFrame:CGRectMake(0,_phoneView.frame.origin.y+_phoneView.frame.size.height +10, ConentViewWidth,500) urlStr:str];
    self.webview.frameDelegate = self;
    [self.backScrollView addSubview:self.webview];

}

//使用代理方法跟新 frame

- (void)upDateFrame:(CGRect)frame{
    CGRect f = lastView.frame;
    f.origin.y = CGRectGetMaxY(frame);
    lastView.frame = f;
    
    self.backScrollView.contentSize = CGSizeMake(ConentViewWidth, CGRectGetMaxY(lastView.frame));
    [self.backScrollView layoutSubviews];
}

- (void)addLastView{
    
    lastView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.webview.frame) +10, ConentViewWidth-20,0)];
    lastView.backgroundColor = [UIColor whiteColor];
    
#pragma mark 产品介绍
    
    
    
    IntroduceView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, ConentViewWidth, 30)];
    IntroduceView.backgroundColor =[UIColor whiteColor];
    UILabel *introductLabel =[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 100, 15)];
    UIImageView  *imaIConnn=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_jianjie"]];
    imaIConnn.frame=CGRectMake(5, 5, 15, 15);
    [IntroduceView addSubview:imaIConnn];
    imaIConnn.frame =CGRectMake(5, 5, 15, 15);
//    titlLabel.font =[UIFont systemFontOfSize:15];
    introductLabel.font =[UIFont systemFontOfSize:15];
    
    
    
    introductLabel.text =@"商品介绍";
    [IntroduceView addSubview: introductLabel];
    // 产品介绍内容
    UILabel *CPConcentLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 25, ConentViewWidth-40, 15)];
    CPConcentLabel.font=[UIFont systemFontOfSize:13];
    CPConcentLabel.text =[NSString stringWithFormat:@" %@",[DicDate objectForKey:@"introduce"]];
    //    if (CPConcentLabel.text.length == 0) {
    //        CPConcentLabel.text =@"";
    //    }
    
    CPConcentLabel.numberOfLines = 0;
    if (CPConcentLabel.text.length/27<1) {
        CPConcentLabel.frame =CGRectMake(10, 25, ConentViewWidth-40, 30);
    }
    
    else{
        CPConcentLabel.frame =CGRectMake(10, 25, ConentViewWidth-40, 35 +15*(CPConcentLabel.text.length/27));
        
    }
    IntroduceView.frame =CGRectMake(10,10, ConentViewWidth-20 , 30 +CPConcentLabel.frame.size.height);
    [IntroduceView addSubview:CPConcentLabel];
    
    UILabel *linLabelaa =[[UILabel alloc]initWithFrame:CGRectMake(0, 23, ConentViewWidth -20, 1)];
    linLabelaa.backgroundColor =BackColor;
    [IntroduceView addSubview:linLabelaa];
    //    [backView addSubview:IntroduceView];
    [lastView addSubview:IntroduceView];
    [self.backScrollView addSubview:lastView];
    
#pragma mark 分享
    
    UIButton *ShareBt =[UIButton buttonWithType:UIButtonTypeCustom];
    ShareBt.frame =CGRectMake(10, CGRectGetMaxY(IntroduceView.frame), ConentViewWidth-20, 30);
    [self.backScrollView addSubview:ShareBt];
    
    
    // 进入商家商店
    //ShareBt.frame.origin.y+ShareBt.frame.size.height
    ComeInStore =[[UIView alloc]initWithFrame:CGRectMake(ConentViewWidth/2+5, CGRectGetMaxY(IntroduceView.frame) +10, (ConentViewWidth-20)/2-5, 30)];
    ComeInStore.backgroundColor =[UIColor colorWithRed:244/225.0 green:124/225.0 blue:137/225.0 alpha:1];
    UIImageView *ComeInImage =[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    ComeInImage.image =[UIImage imageNamed:@"app_shangdian"];
    [ComeInStore addSubview:ComeInImage];
    UILabel *comeILabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, (ConentViewWidth-30)/2, 20)];
    comeILabel.text=@"进入商家商店";
    comeILabel.textColor =[UIColor whiteColor];
    comeILabel.font =[UIFont systemFontOfSize:14];
    comeILabel.textAlignment =NSTextAlignmentCenter;
    [ComeInStore addSubview:comeILabel];
    UITapGestureRecognizer *ComeTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ComeStoreAction)];
    [ComeInStore addGestureRecognizer:ComeTap];
    //    [backView addSubview:ComeInStore];
    [lastView addSubview:ComeInStore];
    
#pragma mark 进入商家 详情
    //ShareBt.frame.origin.y+ShareBt.frame.size.height
    StoreXiangqing =[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(IntroduceView.frame) +10, (ConentViewWidth-20)/2-5, 30)];
    
    UILabel *labeXQ =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, (ConentViewWidth-30)/2, 30)];
    labeXQ.font = [UIFont systemFontOfSize:14];
    labeXQ.textAlignment =NSTextAlignmentCenter;
    labeXQ.textColor =[UIColor whiteColor];
    labeXQ.text =@"查看商家详情";
    [StoreXiangqing addSubview:labeXQ];
    UITapGestureRecognizer *XiangQ =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(XiangQAc)];
    
    [StoreXiangqing addGestureRecognizer:XiangQ];
    
    
    
    //TopImaa,PriceView,PhoneView,IntroduceView,_webview,ComeInStore,StoreXiangqing
    StoreXiangqing.backgroundColor =[UIColor colorWithRed:245/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    //    [backView addSubview:StoreXiangqing];
    [lastView addSubview:StoreXiangqing];
    //TopImaa.height+PriceView.height+PhoneView.height+IntroduceView.height+_webview.height+ComeInStore.height+StoreXiangqing.height+120
    
    
    NSLog(@"%f%f%f",CGRectGetMaxY(self.webview.frame),CGRectGetMaxY(StoreXiangqing.frame),(CGRectGetMaxY(StoreXiangqing.frame) - CGRectGetMaxY(self.webview.frame)));
    //736.000000110.000000-626.000000
    //添加 lastView 到 backView 并修改 frame
    [lastView setFrame:CGRectMake(0, CGRectGetMaxY(self.webview.frame), ConentViewWidth,CGRectGetMaxY(StoreXiangqing.frame) + 10)];
    
    [self.backScrollView addSubview:lastView];
    
    self.backScrollView.contentSize = CGSizeMake(ConentViewWidth, CGRectGetMaxY(lastView.frame));
    [self.backScrollView layoutSubviews];

}



-(void)CallAction{
    NSString *phngStr  =[DicDate objectForKey:@"company_tel"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phngStr]]];
    
}


-(IBAction)dingDan:(id)sender{
    NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[userdefault objectForKey:@"Useid"];
    if ([[DicDate objectForKey:@"has_lookers"] intValue]>=[[DicDate objectForKey:@"sale_lookers"] intValue]) {
        //判断是否能够兑换
        NSString *ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/apporder/hasbuy.do?token=test&member_id=%@&goods_id=%@",userID,ProductId];
        NSLog(@"%@",ProductId);
        //(@"%@",ShouY);
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([[responseObject objectForKey:@"has_buy"] intValue]==0) {
                if ([[DicDate objectForKey:@"total_num"] intValue]>0) {
                    NSString *ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/appmember/mysilver.do?token=test&member_id=%@",userID];
                    //(@"%@",ShouY);
                    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
                    
                    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        if ([[responseObject objectForKey:@"my_silver"] intValue]>=[[DicDate objectForKey:@"sale_integral"] intValue]) {
                            dingDanTiJiaoViewController *dingDan=[[dingDanTiJiaoViewController alloc]init];
                            NSLog(@"%@",self.title);
                            dingDan.titleStr=[DicDate objectForKey:@"goods_name"];
                            dingDan.yinYuanStr=[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"sale_integral"]];
                            dingDan.yunFeiStr=[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"fee"]];
                            dingDan.storeIdStr=[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"store_id"]];
                            dingDan.goodsIdStr=[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"goods_id"]];
                            dingDan.change_type =[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"change_type"]];
                            [self.navigationController pushViewController:dingDan animated:YES];
                        }else{
                            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"银元不足" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                            [failAlView show];
                        }
                        NSLog(@"%@",responseObject);
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [failAlView show];
                        //(@"cook load failed ,%@",error);
                    }];
                    
                    
                    
                    
                }else{
                    UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"可兑换数不足" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [failAlView show];
                }
            }else{
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"今天已兑换过该商品" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [failAlView show];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];
    }else{
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"浏览人数不足" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
    }
    
}
-(void)XiangQAc{
    NSString *steID=[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"store_id"]];
    StoreDetailsViewController *Svc =[[StoreDetailsViewController alloc]initWithStr:steID];
    [self.navigationController pushViewController:Svc animated:YES];
    
}
-(void)ComeStoreAction{
    ShangJiaShangDianViewController * Svc =[[ShangJiaShangDianViewController alloc]initWithStoreID:[DicDate objectForKey:@"store_id"]];
    
    [self.navigationController pushViewController:Svc animated:YES];
    
    //(@"进入商家商店");
}
-(void)PhoneAction{
    NSString *phngStr  =[DicDate objectForKey:@"company_tel"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phngStr]]];
    
}

@end
