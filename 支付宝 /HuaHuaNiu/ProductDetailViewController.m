


//
//  ProductDetailViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//
//ProductXiangqing
#import "ProductDetailViewController.h"
#import "UMSocial.h"
#import "GouWView.h"
#import "GouWuCheViewController.h"
#import "ShangJiaShangDianViewController.h"
#import "StoreDetailsViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "LogViewController.h"
#import "UIImageView+WebCache.h"
#import "MorePLViewController.h"
#import "LogViewController.h"
#import "Toast+UIView.h"
#import "WXApi.h"
#import "GBWXPayManager.h"
#import "CoreUMeng.h"
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "YHWebViewImage.h"



@interface ProductDetailViewController ()<UIWebViewDelegate,YHWebViewImageDelegate>{
    UIWebView *_imgWeb;
    NSTimer *timer;
    UIView *lastView;
    
}
@property(nonatomic,strong)YHWebViewImage *webview;

@end

@implementation ProductDetailViewController
-(id)initWithStr:(NSString *)str{
    self =[super init];
    if (self) {
        ProductId = str;
        [GBWXPayManager sharedManager].orderId = str;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    _webview=[[UIWebView alloc]init];
    //    _webview.delegate=self;
    
    NSUserDefaults   *UserDefault  =[NSUserDefaults  standardUserDefaults];
    UserID =[UserDefault objectForKey:@"Useid"];
    
    [self makeData];
    [self makeUI];
    
    // 送鲜花
    
    // Do any additional setup after loading the view.
}
#pragma mark 获取银元
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

-(void)coinAnimationFinished
{
    [_coinview removeFromSuperview];
    _coinview = nil;
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
        NSString *ShouY = [NSString stringWithFormat:SHOUCANG,UserID,@"goods",ProductId];
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
-(void)makeData{
    [self.view makeToastActivity];
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    NSString *ShouY = [NSString stringWithFormat:ProductXiangqing,ProductId,1,[Userdefaults objectForKey:@"Useid"]];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        DicDate =[[NSDictionary alloc]initWithDictionary:responseObject];
        NSLog(@"%@",DicDate);
        
        [self.view hideToastActivity];
        [self makeScroller];
        [self makeBottomView];
        [self makeFlow];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    
}



-(void)makeUI{
    IOS_Frame
    
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
    
    backView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight )];
#pragma mark - backView.contentSize
    
    //    backView.contentSize =CGSizeMake(ConentViewWidth, 568 +100);
    backView.contentSize = CGSizeMake(ConentViewWidth, CGRectGetMaxY(lastView.frame));
    
    backView.bounces = NO;
    backView.showsVerticalScrollIndicator = NO;
    backView.backgroundColor =BackColor;
    [self.view addSubview:backView ];
    
    
    self.navigationItem.title=@"产品详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
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

-(void)makeBottomView{
    UIView *bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, ConentViewHeight-35, ConentViewWidth, 34)];
    //(@"%f",ConentViewHeight);
    bottomView.backgroundColor =[UIColor grayColor];
    // bottomView.alpha = 0.8;
    //立即购买 BTn  和 加入购物车
    UIButton *BuyBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BuyBtn.frame=CGRectMake(10, 3, (ConentViewWidth-30)/2, 30);
    [BuyBtn setImage:[UIImage imageNamed:@"立刻购买"] forState:UIControlStateNormal];
    BuyBtn.tag =301;
    [BuyBtn addTarget:self action:@selector(BottomAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:BuyBtn];
    
    UIButton *AddShopCar =[UIButton buttonWithType:UIButtonTypeCustom];
    [AddShopCar setImage:[UIImage imageNamed:@"加入购物车"] forState:UIControlStateNormal];
    [AddShopCar addTarget:self action:@selector(BottomAction:) forControlEvents:UIControlEventTouchUpInside];
    
    AddShopCar.frame =CGRectMake(BuyBtn.frame.size.width+20, 3, (ConentViewWidth-30)/2, 30);
    [bottomView addSubview:AddShopCar];
    [self.view addSubview:bottomView];
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        
    }
    else{
        
        gouView =[[[NSBundle mainBundle ]loadNibNamed:@"GouWView" owner:self options:nil]lastObject];
        gouView.frame =CGRectMake(ConentViewWidth -60, ConentViewHeight-70, 40,40);
        
        [gouView LabelNUmber:@""];
        [gouView MakeUIPush:^{
            GouWuCheViewController *Gvc =[[GouWuCheViewController alloc]init];
            [self.navigationController pushViewController:Gvc animated:YES];
        }];
        
        [self.view addSubview:gouView];
        
    }
    
}
-(void)BottomAction:(UIButton*)Btn{
    
    
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        
        [self.navigationController pushViewController:logview animated:YES];
        
        
    }
    else{
        
        if (Btn.tag == 301) {
#pragma  mark 立即购买
            //  先加入购物车 在跳转 购物车界面
            int  a = 1;
            NSString  * number =[NSString stringWithFormat:@"%d",a];
            NSString * ShouY = [NSString stringWithFormat:GOUWUCHE,ProductId,UserID,number];
            //(@"%@",ShouY);
            ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
            [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSString *str =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
                if ([str isEqual:@"1"]) {
                    
                    
                    GouWuCheViewController *Gvc =[[GouWuCheViewController alloc]init];
                    [self.navigationController pushViewController:Gvc animated:YES];
                    
                }else{
                    UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"已经添加到购物车了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [failAlView show];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [failAlView show];
                //(@"cook load failed ,%@",error);
            }];
        }
        else{
#pragma mark 加入购物车
            int  a = 1;
            NSString  * number =[NSString stringWithFormat:@"%d",a];
            NSString * ShouY = [NSString stringWithFormat:GOUWUCHE,ProductId,UserID,number];
            //(@"%@",ShouY);
            ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
            [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSString *str =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
                if ([str isEqual:@"1"]) {
                    
                    NSString *number =[NSString stringWithFormat:@"%@",[[[responseObject  objectForKey:@"retval"] objectForKey:@"cart"] objectForKey:@"quantity"]];
                    [gouView LabelNUmber:number];
                    NSUserDefaults * userDefaults =[NSUserDefaults standardUserDefaults];
                    [userDefaults setValue:number forKey:@"quantity"];
                    [userDefaults synchronize];
                }else{
                    UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"已经添加到购物车了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [failAlView show];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [failAlView show];
                //(@"cook load failed ,%@",error);
            }];
            
        }
        
        
    }
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *str = [DicDate objectForKey:@"description"];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    str = [str stringByReplacingOccurrencesOfString:@"src=\\\"" withString:@"src=\"http://daiyancheng.cn/"];
    str = [str stringByReplacingOccurrencesOfString:@"jpg\\" withString:@"jpg"];
    NSLog(@"%@",str);
    NSString*str11=[NSString stringWithFormat:@"document.getElementById('content').innerHTML='%@'",str];
    [_webview stringByEvaluatingJavaScriptFromString:str11];
}
// topscrollerView的图片
-(void)makeScroller{
#pragma  mark 顶部ScrollerView
    
    UIImageView  *TopImaa =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight/2)];
    [TopImaa sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[DicDate objectForKey:@"default_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    shareView = TopImaa;
    [backView addSubview:TopImaa];
    
#pragma mark 产品名label
    
    ProductNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, TopImaa.frame.size.height+TopImaa.frame.origin.y+1, ConentViewWidth , 40)];
    ProductNameLabel.numberOfLines = 2;
    ProductNameLabel.font =[UIFont systemFontOfSize:14];
    ProductNameLabel.backgroundColor =[UIColor whiteColor];
    [backView addSubview:ProductNameLabel];
    ProductNameLabel.text =[DicDate objectForKey:@"goods_name"];
#pragma mark 价格
    if (PriceView) {
        [PriceView removeFromSuperview];
    }
    PriceView =[[UIView alloc]initWithFrame:CGRectMake(0, ProductNameLabel.frame.origin.y+ProductNameLabel.frame.size.height, ConentViewWidth, 40)];
    
    for (int i =0; i< 3;i++) {
        UILabel *sslabel =[[UILabel alloc]init];
        sslabel.font =[UIFont systemFontOfSize:13];
        if (i == 0){
            sslabel.frame =CGRectMake(5, 10, 100, 20);
            sslabel.text =[NSString  stringWithFormat:@"现价 ：￥%@", [NSString stringWithFormat:@"%@",[DicDate objectForKey:@"price"]]];
            sslabel.textColor =[UIColor redColor];
        }
        else if(i==1){
            sslabel.frame =CGRectMake((ConentViewWidth-100)/2,10 , 100, 20);
            sslabel.textAlignment =NSTextAlignmentCenter;
            sslabel.text =[NSString  stringWithFormat:@"市场价 ￥%@", [NSString stringWithFormat:@"%@",[DicDate objectForKey:@"market_price"]]];
            UILabel * linlabel  =[[UILabel alloc]initWithFrame:CGRectMake((ConentViewWidth-100)/2 , 20, 100, 1)];
            linlabel.backgroundColor =[UIColor blackColor];
            [PriceView addSubview:linlabel];
        }
        else if(i==2){
            
            sslabel.frame =CGRectMake(ConentViewWidth -130,10, 100, 20);
            sslabel.textAlignment= NSTextAlignmentRight;
            
            //            sslabel.text =[NSString  stringWithFormat:@"已售%@件",[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"selled_num"]]];
        }
        PriceView.backgroundColor =[UIColor whiteColor];
        [PriceView addSubview:sslabel];
    }
    [backView addSubview:PriceView];
//    
//#pragma mark 运费 产地
//    if (AddressView) {
//        [AddressView removeFromSuperview];
//        
//    }
//    
//    AddressView =[[UIView alloc]initWithFrame:CGRectMake(10, PriceView.frame.size.height+PriceView.frame.origin.y+1,ConentViewWidth-20, 40)];
//    for (int i = 0; i<2; i++) {
//        UILabel *yunFeiLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 20)];
//        yunFeiLabel.font =[UIFont systemFontOfSize:13];
//        if (i == 0) {
//            yunFeiLabel.frame =CGRectMake(5, 10, 100, 20);
//            NSString * fee =[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"fee"]];
//            if ([fee isEqualToString:@"0"]) {
//                yunFeiLabel.text=@"商家包邮";
//            }
//            else{
//                yunFeiLabel.text=[NSString  stringWithFormat:@"运费：%@元", fee];
//                
//            }
//            
//            //        [AddressView addSubview:yunFeiLabel];
//            
//        }else{
//            UILabel * yunFeiLabel =[[UILabel alloc]init];
//            yunFeiLabel.font =[UIFont systemFontOfSize:13];
//            yunFeiLabel.frame =CGRectMake(ConentViewWidth-180, 10, 155, 20);
//            NSString * str =[DicDate objectForKey:@"origin"];
//            //   //(@"str ==%@",str);
//            yunFeiLabel.text =[NSString stringWithFormat:@"原产地:%@",str];
//            yunFeiLabel.textAlignment = NSTextAlignmentRight;
//            
//            if (str.length ==0) {
//                
//            }else{
//                //              [AddressView addSubview:yunFeiLabel];
//            }
//            
//        }
//        
//    }
//    AddressView.backgroundColor =[UIColor whiteColor];
//    //    [backView addSubview:AddressView];
    
#pragma mark 打电话
    PhoneView = [[UIView alloc]initWithFrame:CGRectMake(0, PriceView.frame.size.height+PriceView.frame.origin.y+10, ConentViewWidth , 45)];
    PhoneView.backgroundColor =[UIColor whiteColor];
    UITapGestureRecognizer *PhoneTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PhoneAction)];
    [PhoneView addGestureRecognizer:PhoneTap];
    //公司name
    UILabel *companyName =[[UILabel alloc]initWithFrame:CGRectMake(5, 6, ConentViewWidth-100, 15)];
    companyName.text =[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"company"]];
    companyName.font =[UIFont systemFontOfSize:15];
    [PhoneView addSubview:companyName];
    // 地址label
    UILabel *dizhLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 25, ConentViewWidth-100, 15)];
    dizhLabel.text=[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"company_address"]];
    dizhLabel.font =[UIFont systemFontOfSize:13];
    [PhoneView addSubview:dizhLabel];
    
    UIImageView *PhoneImage =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth-55, 13, 20, 20)];
    PhoneImage.image =[UIImage imageNamed:@"电话图标"];
    [PhoneView addSubview:PhoneImage];
    [backView addSubview: PhoneView];
    
    
    
    
    
    
    
#pragma mark 配送标准
    
    
    
    UIView *PeiSongBiaoView =[[UIView alloc]initWithFrame:CGRectMake(10, PhoneView.frame.origin.y+PhoneView.frame.size.height +10, ConentViewWidth-20 , 40)];
    UIImageView  *PESIConn=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"产品详情"]];
    [PeiSongBiaoView addSubview:PESIConn];
    PESIConn.frame =CGRectMake(5, 5, 15, 15);
    UILabel * LineLabe =[[UILabel alloc]initWithFrame:CGRectMake(0, 23, ConentViewWidth-20, 1)];
    LineLabe.backgroundColor =BackColor;
    
    
    
    UILabel *PeisongLabelTit =[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 100, 15)];
    PeisongLabelTit.font =[UIFont systemFontOfSize:15];
    PeisongLabelTit.text =@"配送标准";
    UILabel * PeiSongConrent =[[UILabel alloc]initWithFrame:CGRectMake(10, 24, ConentViewWidth -20, 15)];
    PeiSongConrent.font =[UIFont systemFontOfSize:13];
    PeiSongConrent.numberOfLines = 0;
    PeiSongConrent.text =[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"distribution"]];
    if (PeiSongConrent.text.length ==  0) {
        PeiSongConrent.text =@"该商家暂无配送服务";
    }
    
    if (PeiSongConrent.text.length/27 <1) {
        PeiSongConrent.frame =CGRectMake(10, 25, ConentViewWidth-40, 30);
    }
    
    else{
        PeiSongConrent.frame =CGRectMake(10, 25, ConentViewWidth-40, 35 +(PeiSongConrent.text.length/27)*15);
        
    }
    PeiSongBiaoView.frame =CGRectMake(10, PhoneView.frame.origin.y+PhoneView.frame.size.height +10, ConentViewWidth -20, 20+PeiSongConrent.frame.size.height);
    
    [PeiSongBiaoView addSubview:PeiSongConrent];
    [PeiSongBiaoView addSubview:PeisongLabelTit];
    [PeiSongBiaoView addSubview:LineLabe];
    PeiSongBiaoView.backgroundColor =[UIColor whiteColor];
    //    [backView addSubview:PeiSongBiaoView];
    
    
    
    
    
#pragma mark 优惠活动
    
    FavorableVIew =[[UIView alloc]initWithFrame:CGRectMake(10, PeiSongBiaoView.frame.origin.y+PeiSongBiaoView.frame.size.height +10, ConentViewWidth-20 , 30)];
    FavorableVIew.backgroundColor =[UIColor whiteColor];
    UIImageView  *imaIConn=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_hui"]];
    [FavorableVIew addSubview:imaIConn];
    imaIConn.frame =CGRectMake(5, 5, 15, 15);
    UILabel *titlLabel =[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 100, 15)];
    titlLabel.font =[UIFont systemFontOfSize:15];
    titlLabel.text =@"优惠活动";
    [FavorableVIew addSubview:titlLabel];
    //  优惠内容
    UILabel *YHConcentLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 20, ConentViewWidth-20, 15)];
    YHConcentLabel.font=[UIFont systemFontOfSize:13];
    YHConcentLabel.text =[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"benefit_activity"]];
    if(YHConcentLabel.text.length == 0){
        YHConcentLabel.text =@"本商家暂无优惠活动";
        
    }
    YHConcentLabel.numberOfLines = 0;
    if (YHConcentLabel.text.length/27<1) {
        YHConcentLabel.frame =CGRectMake(10, 25, ConentViewWidth-40, 25);
    }
    
    else {
        YHConcentLabel.frame =CGRectMake(10, 25, ConentViewWidth-40, 25 +(YHConcentLabel.text.length/27)*15);
        
    }
    FavorableVIew.frame =CGRectMake(10, PeiSongBiaoView.frame.origin.y+PeiSongBiaoView.frame.size.height +10, ConentViewWidth-20 , 30 +YHConcentLabel.frame.size.height);
    UILabel *linLabela =[[UILabel alloc]initWithFrame:CGRectMake(0, 23, ConentViewWidth -20, 1)];
    linLabela.backgroundColor =BackColor;
    [FavorableVIew addSubview:YHConcentLabel];
    [FavorableVIew addSubview:linLabela];
    //      [backView addSubview:FavorableVIew];
    
    
    
    
#pragma mark - 添加 webView
    NSString *str = [DicDate objectForKey:@"description"];
    //截取字符串
    str = [str stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
    
    NSLog(@"%@",str);
    
    //创建webview
    self.webview = [[YHWebViewImage alloc] initWithFrame:CGRectMake(0,PhoneView.frame.origin.y+PhoneView.frame.size.height +10, ConentViewWidth,500) urlStr:str];
    self.webview.frameDelegate = self;
    [backView addSubview:self.webview];
    
    lastView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.webview.frame) +10, ConentViewWidth-20,0)];
    lastView.backgroundColor = [UIColor whiteColor];
    
#pragma mark 产品介绍
    
    
    
    IntroduceView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, ConentViewWidth, 30)];
    IntroduceView.backgroundColor =[UIColor whiteColor];
    UILabel *introductLabel =[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 100, 15)];
    UIImageView  *imaIConnn=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_jianjie"]];
    imaIConnn.frame=CGRectMake(5, 5, 15, 15);
    [IntroduceView addSubview:imaIConnn];
    imaIConn.frame =CGRectMake(5, 5, 15, 15);
    titlLabel.font =[UIFont systemFontOfSize:15];
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
#pragma mark 分享
    
//    UIButton *ShareBt =[UIButton buttonWithType:UIButtonTypeCustom];
//    ShareBt.frame =CGRectMake(10, CGRectGetMaxY(IntroduceView.frame), ConentViewWidth-20, 30);
    
//    [backView addSubview:ShareBt];
    
    
    // 进入商家商店
    //ShareBt.frame.origin.y+ShareBt.frame.size.height
    ComeInStore =[[UIButton alloc]initWithFrame:CGRectMake(ConentViewWidth/2+5, CGRectGetMaxY(IntroduceView.frame) +10, (ConentViewWidth-20)/2-5, 30)];
    [ComeInStore setImage:[UIImage imageNamed:@"进入商家商店"] forState:UIControlStateNormal];
    [ComeInStore addTarget:self action:@selector(ComeStoreAction) forControlEvents:UIControlEventTouchUpInside];
    //    [backView addSubview:ComeInStore];
    [lastView addSubview:ComeInStore];
    
#pragma mark 进入商家 详情
    StoreXiangqing =[[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(IntroduceView.frame) +10, (ConentViewWidth-20)/2-5, 30)];
    
    [StoreXiangqing setImage:[UIImage imageNamed:@"查看商家详情"] forState:UIControlStateNormal];
    [StoreXiangqing addTarget:self action:@selector(XiangQAc) forControlEvents:UIControlEventTouchUpInside];
    
    [lastView addSubview:StoreXiangqing];
    
    
    
    NSLog(@"%f%f%f",CGRectGetMaxY(self.webview.frame),CGRectGetMaxY(StoreXiangqing.frame),(CGRectGetMaxY(StoreXiangqing.frame) - CGRectGetMaxY(self.webview.frame)));
    
    //添加 lastView 到 backView 并修改 frame
    [lastView setFrame:CGRectMake(0, CGRectGetMaxY(self.webview.frame), ConentViewWidth,CGRectGetMaxY(StoreXiangqing.frame) + 40)];
    
    [backView addSubview:lastView];
    
    backView.contentSize = CGSizeMake(ConentViewWidth, CGRectGetMaxY(lastView.frame));
    [backView layoutIfNeeded];
}

//使用代理方法跟新 frame

- (void)upDateFrame:(CGRect)frame{
    CGRect f = lastView.frame;
    f.origin.y = CGRectGetMaxY(frame);
    lastView.frame = f;
    
    backView.contentSize = CGSizeMake(ConentViewWidth, CGRectGetMaxY(lastView.frame));
    [backView layoutSubviews];
}

-(void)ShareActComeIn{
    NSUserDefaults * UserDefault = [NSUserDefaults standardUserDefaults];
    NSString * ShareStr =[NSString stringWithFormat:FenXiangshLJ,ProductId,1,[UserDefault objectForKey:@"Useid"]];
    
    NSString * concentStr =[NSString stringWithFormat:@"%@",DicDate[@"company"]];
    [UMSocialData defaultData].extConfig.qqData.url = ShareStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url =ShareStr;
    
    
    //shareView.image
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5507c758fd98c5cdd1000244"
                                      shareText:concentStr
                                     shareImage:[UIImage imageNamed:@"60"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
                                       delegate:nil];
    NSString *ProductName = ProductNameLabel.text;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = ProductName;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = ProductName;
    [UMSocialData defaultData].extConfig.qqData.title = ProductName;
    [UMSocialData defaultData].extConfig.qzoneData.title = ProductName;
}


// 更多评论
-(void)MoreBtnAction{
    NSString *steID=[NSString stringWithFormat:@"%@",[DicDate objectForKey:@"store_id"]];
    
    MorePLViewController * MOreVC =[[MorePLViewController alloc]initWithStr:steID];
    [self.navigationController pushViewController:MOreVC animated:YES];
    
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

