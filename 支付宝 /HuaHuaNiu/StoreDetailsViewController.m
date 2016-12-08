//
//  StoreDetailsViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "StoreDetailsViewController.h"
#import "ChitView.h"
#import "UMSocial.h"
#import "DaijianquanXQViewController.h"
#import "XunZhaoViewController.h"
#import "ShangJiaShangDianViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "ZYView.h"
#import "ProductDetailViewController.h"
#import "DaiLIShangMapViewController.h"
#import "MorePLViewController.h"
#import "UIImageView+WebCache.h"
#import "Toast+UIView.h"
#import "LogViewController.h"
#import "ZaJinDanViewController.h"
#import "WXApi.h"
#import "LooKInComeViewController.h"
#import "CoreUMeng.h"
#import "ADViewController.h"

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "WanShangModel.h"
#import "ProductDetailViewController2.h"
#import "CommentViewController.h"
#import "HGFindFrameModel.h"
#import "MFXQViewController.h"

@interface StoreDetailsViewController ()<UIWebViewDelegate>
{
    UIWebView *_imgWeb;
    
    NSArray *imageArr ;
    NSDictionary *imageDic4;
    NSDictionary *imageDic3;
    NSTimer *timer;
    NSMutableArray *DuiHuanImageArray;
}
@end

@implementation StoreDetailsViewController
-(id)initWithStr:(NSString *)str{
    self  =[super init];
    if (self) {
        StoreId = str;
        //(@"-----%@",str);
    }
    return self;
}
- (void)viewDidLoad {
    self.view.backgroundColor =BackColor;
    [super viewDidLoad];
    imageArr=[NSArray array];
    DuiHuanImageArray = [NSMutableArray array];
    IOS_Frame
    self.navigationItem.title=@"商家详情";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 创建数据
    [self makeData];
    
    //返回按钮
    UIImage *lbbImage = [UIImage imageNamed:@"back_new"];
    lbbImage = [lbbImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * lbbItem = [[UIBarButtonItem alloc] initWithImage:lbbImage style:UIBarButtonItemStylePlain target:self action:@selector(BackAction)];
    self.navigationItem.leftBarButtonItem = lbbItem;
    
}
#pragma mark - 动画结束
-(void)coinAnimationFinished
{
    [_coinview removeFromSuperview];
    _coinview = nil;
}
#pragma mark -
-(void)makeFlow{
    
    NSUserDefaults * UserDefault = [NSUserDefaults standardUserDefaults];
    NSString * userID =[UserDefault objectForKey:@"Useid"];
    
    //id 广告id   user_id 用户id
    NSString *ShouY = [NSString stringWithFormat:FLOWER,userID,StoreId,@"",@""];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
#pragma mark - 发送网络请求 添加动画,文字
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

-(void)makeData{
    [self.view makeToastActivity];
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    NSString * Store =[NSString stringWithFormat:StoreXQ,StoreId,[Userdefaults objectForKey:@"Useid"]];
    //(@"%@",Store);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:Store parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        DicData =[[NSDictionary alloc]initWithDictionary:responseObject];
        [self.view hideToastActivity];
        [self makeUI];
        [self makeFlow];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
    }];
    
    
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//   收藏
-(void)RightBtnAction:(UIButton *)Btn{
    //   //(@"收藏");
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = (int)UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
        NSUserDefaults * UserDefault  =[NSUserDefaults  standardUserDefaults];
        NSString * UserID =[UserDefault objectForKey:@"Useid"];
        NSString *ShouY = [NSString stringWithFormat:SHOUCANG,UserID,@"store",StoreId];
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //(@"%@",ShouY);
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //(@"%@",[responseObject objectForKey:@"msg"]);
            UIAlertView  * SCAl =[[UIAlertView alloc]initWithTitle:@"提示" message:@"商家收藏成功，可在我的收藏中查看" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [SCAl show];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];
    }
}
/*
 "2015-12
 1.voucherList商家代金券列
 2.videoList增加视频列表（img_path:视频配图或视频第一帧图片，title：视频标题，video_id：视频id）
 3.freeList增加真的免费列表（goods_id：商品id，goods_name：商品名称，default_image_path：商品图片）
 4.prizeList增加看看有奖列表（advalue：广告id，title：广告标题，logo：广告图片，adtype：广告展示类型）
 5.join增加 招聘信息 ""join"" : ""公司急招 .net 网站维护人员"",
 
 APP商家信息中只展示列表中第一条信息，打开后进入到该信息的详情页面.
 
 2016-3
 增加该商家的兑换商品列表ddlist
 goods_id :商品id
 goods_name :商品名字
 default_image: 商品图片
 "
 
 */

- (UIView *)addImageVIewWith:(NSDictionary *)dict with:(CGRect)frame count:(NSInteger)count{
    UIView *backVIew = [[UIView alloc] initWithFrame:frame];
    NSLog(@"%ld",(long)count);
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ConentViewWidth, 20)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, ConentViewWidth, frame.size.height - 20)];
    if ([dict objectForKey:@"logo"]){
        //创建 添加 image
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",[dict objectForKey:@"logo"]]]];
        lable.text = [dict objectForKey:@"title"];
        [backVIew addSubview:lable];
        [backVIew addSubview:imageView];
//        imageView.tag = count;
        //添加点击事件
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPage3:)];
        [backVIew addGestureRecognizer:tapGesturRecognizer];
        
    }
    if ([dict objectForKey:@"default_image"]){
        //创建 添加 image
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",[dict objectForKey:@"default_image"]]]];
        lable.text = @"兑换商品";//[dict objectForKey:@"goods_name"];
        [backVIew addSubview:lable];
        [backVIew addSubview:imageView];
//        imageView.tag = count;
        //添加点击事件
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPage2:)];
        [backVIew addGestureRecognizer:tapGesturRecognizer];
    }
    //freeList
    if ([dict objectForKey:@"default_image_path"]){
        //创建 添加 image
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",[dict objectForKey:@"default_image_path"]]]];
        lable.text = @"免费商品";//[dict objectForKey:@"goods_name"];
        [backVIew addSubview:lable];
        [backVIew addSubview:imageView];
//        imageView.tag = count;
        //添加点击事件
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPage4:)];
        [backVIew addGestureRecognizer:tapGesturRecognizer];
    }
    //videoList
    if ([dict objectForKey:@"img_path"]){
        //创建 添加 image
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",[dict objectForKey:@"img_path"]]]];
        lable.text = [dict objectForKey:@"title"];
        [backVIew addSubview:lable];
        [backVIew addSubview:imageView];
        //        imageView.tag = count;
        //添加点击事件
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPage5:)];
        [backVIew addGestureRecognizer:tapGesturRecognizer];
    }
    //判断当前的 key 值加载 imageVIew
    backVIew.tag = count;
    return backVIew;
    
}
-(void)tapPage2:(UIGestureRecognizer *)sender{
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
        
        //   //(@"选中了 %ld",(long)indexPath.row);
        NSString * str =[NSString stringWithFormat:@"%@",[DuiHuanImageArray[sender.view.tag] objectForKey:@"goods_id"]];
        NSLog(@"%@",str);
        ProductDetailViewController2 *Avc =[[ProductDetailViewController2 alloc]initWithStr:str];
        self.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Avc animated:YES];
        
    }
}
-(void)tapPage4:(UIGestureRecognizer *)sender{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
        //   //(@"选中了 %ld",(long)indexPath.row);
        NSString * str =[NSString stringWithFormat:@"%@",[DuiHuanImageArray[sender.view.tag] objectForKey:@"goods_id"]];
        
        MFXQViewController *mvc =[[MFXQViewController alloc]initWithStr:str andqiang:YES];
//        mvc.gf_id =tureModel.gf_id;
        [self.navigationController pushViewController:mvc animated:YES];;
        
    }
}

-(void)tapPage5:(UIGestureRecognizer *)sender{
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
        
        //   //(@"选中了 %ld",(long)indexPath.row);
        NSString * str =[NSString stringWithFormat:@"%@",[DuiHuanImageArray[sender.view.tag] objectForKey:@"video_id"]];
        NSLog(@"%@",str);
        CommentViewController *vc = [[CommentViewController alloc]init];
        NSUserDefaults * UserDefault = [NSUserDefaults standardUserDefaults];
        NSString * userID =[UserDefault objectForKey:@"Useid"];

        vc.video_id = str;
        
        vc.member = userID;
        self.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)makeUI{
#pragma mark - 分享
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(0, 0, 15, 15)];
    [cancelBtn addTarget:self action:@selector(RightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"app_top_shoucang"] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *startBtn = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    UIButton *cancelBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn1 setFrame:CGRectMake(0, 0, 15, 15)];
    [cancelBtn1 addTarget:self action:@selector(ShareActComeIn) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn1 setBackgroundImage:[UIImage imageNamed:@"app_top_fenxiang"] forState:UIControlStateNormal];
    [cancelBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn1.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *pauseBtn = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn1];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: pauseBtn,startBtn,nil]];
    
    
    backView =[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, ConentViewWidth, ConentViewHeight )];
    //backView.delegate =self;
    backView.contentSize =CGSizeMake(ConentViewWidth, ConentViewHeight*3);
    backView.bounces = NO;
    backView.showsVerticalScrollIndicator = NO;
    
    topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 200)];
    
    //    topImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10,0, ConentViewWidth-20 , 100)];
    
    [topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[DicData objectForKey:@"store_logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    
    topImageView.userInteractionEnabled = YES;
    [backView addSubview:topImageView];
    
    UILabel *NameLbelee =[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(topImageView.frame), ConentViewWidth -20 , 25)];
    NameLbelee.text =[NSString stringWithFormat:@"商家名称：%@",[DicData objectForKey:@"store_name"]] ;
    NameLbelee.font =[UIFont systemFontOfSize:15];
    [backView addSubview:NameLbelee];
    
    
    //电话View
    UIView *phoneView =[[UIView alloc]initWithFrame:CGRectMake(10, NameLbelee.frame.origin.y+25, ConentViewWidth -20, 39)];
    phoneView.backgroundColor =[UIColor whiteColor];
    phoneLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 10, ConentViewWidth - 60, 25)];
    phoneLabel.font =[UIFont systemFontOfSize:13];
    phoneLabel.text  =[NSString stringWithFormat:@"电话:%@",[DicData objectForKey:@"tel"]];
    UIImageView *PhoneImag =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth -50, 10, 20, 20)];
    PhoneImag.image =[UIImage imageNamed:@"电话图标"];
    UITapGestureRecognizer *PTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PhoneActionwww)];
    [phoneView addGestureRecognizer:PTap];
    [phoneView addSubview:PhoneImag];
    [phoneView addSubview:phoneLabel];
    [backView addSubview:phoneView];
    //地址
    UIView *AddressView =[[UIView alloc]initWithFrame:CGRectMake(10, phoneView.frame.size.height +phoneView.frame.origin.y , ConentViewWidth-20, 39)];
    AddressView.backgroundColor =[UIColor whiteColor];
    AddressLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 0, ConentViewWidth -80, 35)];
    AddressLabel.numberOfLines = 2;
    AddressLabel.text =[NSString stringWithFormat:@"地址:%@",[DicData objectForKey:@"address"]];
    AddressLabel.font =[UIFont systemFontOfSize:13];

    UITapGestureRecognizer *ATap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddressActionwww)];
    [AddressView addGestureRecognizer:ATap];
    //       [AddressView addSubview:MapIma];
    [AddressView addSubview:AddressLabel];
    [backView addSubview:AddressView];
    
    // 寻求代言人
    laysBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    laysBtn.frame =CGRectMake(10, AddressView.frame.origin.y+AddressView.frame.size.height, ConentViewWidth-20, 30);
    [laysBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [laysBtn setBackgroundColor:[UIColor whiteColor]];
    laysBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    NSString *Srrrrt =[NSString stringWithFormat:@"%@",[DicData objectForKey:@"bind_status"]];
    //(@"%@",Srrrrt);
    //绑定状态    0 未绑定     1 寻找代言人      2 已绑定
    if([Srrrrt isEqualToString:@"0"]){
        laysBtn.tag = 2;
        [laysBtn setTitle:@"暂无代言人,抓紧砸金蛋哟！" forState:UIControlStateNormal];
        UIImageView *BanRightImage =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth-50, 5, 20, 20)];
        BanRightImage.image  =[UIImage imageNamed:@"direction_right"];
        [laysBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -110, 0, 0)];
        [laysBtn addSubview:BanRightImage];
    }
    else if([Srrrrt isEqualToString:@"1"]){
        laysBtn.tag = 3;
        [laysBtn setTitle:@"寻找代言人" forState:UIControlStateNormal];
        UIImageView *BanRightImage =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth-50, 5, 20, 20)];
        BanRightImage.image  =[UIImage imageNamed:@"direction_right"];
        [laysBtn addSubview:BanRightImage];    }
    
    else{
        laysBtn.tag = 1;
        NSString * str = [NSString stringWithFormat:@"%@",[DicData objectForKey:@"bind_user_tel"]];
        NSRange range ={str.length-4,4};
        
        str =[str stringByReplacingCharactersInRange:range withString:@"****"];
        [laysBtn setTitle:[NSString stringWithFormat:@"恭喜 %@ 成为该商家代言人",str] forState:UIControlStateNormal];
        
    }
    
    
    //  根据 返回的标示来判定
    
    [laysBtn addTarget:self action:@selector(laysBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:laysBtn];
    
    // 图片信息
    UIView *image1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(laysBtn.frame)+10, ConentViewWidth, 300)];
//    [backView addSubview:image1];
    //voucherList
    imageArr = [NSArray arrayWithArray:[DicData objectForKey:@"prizeList"]];
    NSArray *imageArr2 = [NSArray arrayWithArray:[DicData objectForKey:@"videoList"]];
    NSArray *imageArr3 = [NSArray arrayWithArray:[DicData objectForKey:@"freeList"]];
    NSArray *imageArr4 = [NSArray arrayWithArray:[DicData objectForKey:@"ddlist"]];
    
    NSDictionary *imageDic=[[NSDictionary alloc]init];
    NSDictionary *imageDic2=[[NSDictionary alloc]init];
    imageDic3=[[NSDictionary alloc]init];
    imageDic4 =[[NSDictionary alloc]init];
    //    //(@"111111111%@",imageArr);
    
    if ([imageArr count] == 0) {// 没有代金券
        image1.frame =CGRectMake(10, laysBtn.frame.origin.y +laysBtn.frame.size.height, ConentViewWidth-20, 0);
    }
    else{
        imageDic = imageArr[0];
        [DuiHuanImageArray addObject:imageDic];
    }
    if (imageArr2.count > 0)
    {
            [DuiHuanImageArray addObject:imageArr2[0]];
    }
    if (imageArr3.count > 0)
    {
            [DuiHuanImageArray addObject:imageArr3[0]];
        
    }
    if (imageArr4.count > 0)
    {
            [DuiHuanImageArray addObject:imageArr4[0]];
    }
//    if (imageArr5.count > 0)
//    {
//        [DuiHuanImageArray addObject:imageArr5[0]];
//    }
    
    //便利数组创建 View
//    UIImageView *first;
    
    
    for (int i = 0; i < DuiHuanImageArray.count; i++) {
        
        UIView *view = [self addImageVIewWith:DuiHuanImageArray[i] with:CGRectMake(0, i * 200, ConentViewWidth, 200) count:i];
        [image1 addSubview:view];
        
        image1.frame = CGRectMake(0, CGRectGetMaxY(laysBtn.frame)+10, ConentViewWidth, CGRectGetMaxY(view.frame));
    }
    [backView addSubview:image1];
    
    // 代金券   1张   代金券
    NSLog(@"%f",image1.frame.origin.y);
    NSLog(@"%f",image1.frame.size.height+10);
    UIView * DaijinView =[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(image1.frame)+10, ConentViewWidth-20, 100)];
    
    NSArray * DaiArr = [NSArray arrayWithArray:[DicData objectForKey:@"voucherList"]];
    NSDictionary *DaDic=[[NSDictionary alloc]init];
    
    if ([DaiArr count] ==0) {// 没有代金券
        DaijinView.frame =CGRectMake(10, image1.frame.origin.y +image1.frame.size.height, ConentViewWidth-20, 0);
    }
    else{
        DaDic =DaiArr[0];
        
        UILabel *linLaneddd =[[UILabel alloc]initWithFrame:CGRectMake(0, 24, ConentViewWidth-20, 1)];
        linLaneddd.backgroundColor  = BackColor;
        [DaijinView addSubview:linLaneddd];
        DaijinView.backgroundColor =[UIColor colorWithRed:239/255.0 green:177/255.0 blue:91/255.0 alpha:1];
        UIImageView *ImaVIC =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_daijinjuan"]];
        ImaVIC.frame =CGRectMake(5, 2, 40, 40);
        [DaijinView addSubview:ImaVIC];
        UILabel *  DaiQuaneLabel =[[UILabel alloc]initWithFrame:CGRectMake(30, 3, 80, 20)];
        DaiQuaneLabel.text =@"代金券";
        DaiQuaneLabel.font =[UIFont systemFontOfSize:15];
        //                [DaijinView addSubview:DaiQuaneLabel];
        
        
        ChitView *Cvc =[[[NSBundle mainBundle]loadNibNamed:@"ChitView" owner:self options:nil]lastObject];
        Cvc.frame =CGRectMake(0, 45, ConentViewWidth-20, 75);
        Cvc.backgroundColor = [UIColor colorWithRed:239/255.0 green:177/255.0 blue:91/255.0 alpha:1];
        
        Cvc.NameLabel.text =[NSString stringWithFormat:@"%@",[DaDic objectForKey:@"voucher_name"]];
        Cvc.ValueLaebl.text=[NSString stringWithFormat:@"%@",[DaDic objectForKey:@"price"]];
        //                Cvc.ChiYouLaebl.text=[NSString stringWithFormat:@"已持有人数:%@",[DaDic objectForKey:@"surplus"]];
        Cvc.concentLabel.text=[NSString stringWithFormat:@"%@",[DaDic objectForKey:@"summary"]];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DaiJinAction:)];
        [Cvc addGestureRecognizer:tap];
        [DaijinView addSubview:Cvc];
    }
    [backView addSubview:DaijinView];
    
    // 商家 主打
    // 主打商品个数
    NSArray *Arr = [DicData objectForKey:@"goods"];
    UIView *StoreZD =[[UIView alloc]initWithFrame:CGRectMake(10, DaijinView.frame.origin.y +DaijinView.frame.size.height +10,ConentViewWidth-20, 140)];
    UIImageView * icoImassa =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"商家详情"]];
    icoImassa.frame= CGRectMake(5, 5, 15,15);
    [StoreZD addSubview:icoImassa];
    
    if (Arr.count == 0) {
        StoreZD.frame=CGRectMake(10, DaijinView.frame.origin.y +DaijinView.frame.size.height ,ConentViewWidth-20, 0);
    }
    else{
        UILabel * ZHUdaLabel =[[UILabel alloc]initWithFrame:CGRectMake(30, 0, ConentViewWidth -20, 25)];
        ZHUdaLabel.text=@"商家主打";
        ZHUdaLabel.font =[UIFont systemFontOfSize:15];
        [StoreZD addSubview:ZHUdaLabel];
        
        if (Arr.count>3) {
            for (int i  = 0 ; i<3; i++) {
                
                
                ZYView *Zvc =[[[NSBundle mainBundle]loadNibNamed:@"ZYView" owner:self options:nil]lastObject];
                
                [Zvc makeDataWithStoreDic:Arr[i]];
                CGFloat smallidth = 5.0* 320/ConentViewWidth;
                Zvc.frame =CGRectMake(smallidth+(ConentViewWidth -20-smallidth)/3 * i, 30, (ConentViewWidth-20-smallidth)/3-smallidth , 105);
                [Zvc ViewPushBlocks:^(NSString *Str) {
                    // 商家ID没有传过来
                    ProductDetailViewController *Pvc =[[ProductDetailViewController alloc]initWithStr:Str];
                    Pvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:Pvc animated:YES];
                }];
                [StoreZD addSubview:Zvc];
                
                
            }
            
        }else{
            
            for (int i  = 0 ; i< Arr.count; i++) {
                
                
                ZYView *Zvc =[[[NSBundle mainBundle]loadNibNamed:@"ZYView" owner:self options:nil]lastObject];
                
                [Zvc makeDataWithStoreDic:Arr[i]];
                CGFloat smallidth = 5.0* 320/ConentViewWidth;
                Zvc.frame =CGRectMake(smallidth+(ConentViewWidth -20-smallidth)/3 * i, 30, (ConentViewWidth-20-smallidth)/3-smallidth , 105);
                [Zvc ViewPushBlocks:^(NSString *Str) {
                    // 商家ID没有传过来
                    ProductDetailViewController *Pvc =[[ProductDetailViewController alloc]initWithStr:Str];
                    Pvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:Pvc animated:YES];
                }];
                [StoreZD addSubview:Zvc];
                
                
            }
            
            
        }
        
        
        StoreZD.backgroundColor = [UIColor whiteColor];
        UILabel *linLabewwq=[[UILabel alloc]initWithFrame:CGRectMake(0,23, ConentViewWidth -20, 1)];
        linLabewwq.backgroundColor =BackColor;
        [StoreZD addSubview:linLabewwq];
        
        [backView addSubview:StoreZD];
    }

    UIButton *ShareBt =[UIButton buttonWithType:UIButtonTypeCustom];
    ShareBt.frame =CGRectMake(10, CGRectGetMaxY(DaijinView.frame), ConentViewWidth-20, 0);

    [backView addSubview:ShareBt];
    
    
    //  进入商家商店
    UIButton *ComeStoreView =[[UIButton alloc]initWithFrame:CGRectMake((ConentViewWidth - 160) / 2, CGRectGetMaxY(ShareBt.frame)+20, 160, 40)];
    //       ComeStoreView.backgroundColor =[UIColor colorWithRed:246/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    [ComeStoreView setBackgroundImage:[UIImage imageNamed:@"进入商家商店"] forState:UIControlStateNormal];
    [ComeStoreView setBackgroundImage:[UIImage imageNamed:@"进入商家商店按钮"] forState:UIControlStateHighlighted];
    [ComeStoreView addTarget:self action:@selector(ComeTapAccc) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:ComeStoreView];
    
    // 商家简介
    
    CGFloat  hight ;  // 根据子的内容显示 大小
    NSString * briefStr =[NSString stringWithFormat:@"   %@",[DicData objectForKey:@"description"]];
    hight = briefStr.length/27;
    //
    UIView *briefView =[[UIView alloc]initWithFrame:CGRectMake(10, ComeStoreView.frame.origin.y+ComeStoreView.frame.size.height+10, ConentViewWidth-20, 35+(hight+1) *16)];
    briefView.backgroundColor =[UIColor whiteColor];
    UILabel *  StoreLabel =[[UILabel alloc]initWithFrame:CGRectMake(25, 3, 80, 20)];
    StoreLabel.text =@"商家简介";
    UIImageView * icoImaaa =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_jianjie"]];
    icoImaaa.frame= CGRectMake(5, 5, 15,15);
    [briefView addSubview:icoImaaa];
    StoreLabel.font =[UIFont systemFontOfSize:15];
    [briefView addSubview:StoreLabel];
    UILabel *conCentLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 30, ConentViewWidth-35,16*(hight+1))];
    if(briefStr.length ==3){
        briefStr =@"该商家暂无添加简介";
    }
    conCentLabel.text = briefStr;
    conCentLabel.numberOfLines =8;
    conCentLabel.font =[UIFont systemFontOfSize:11];
    [self labelToFit:conCentLabel];
    
    
    UILabel *linLabe =[[UILabel alloc]initWithFrame:CGRectMake(0,23, ConentViewWidth -10, 1)];
    linLabe.backgroundColor =BackColor;
    [briefView addSubview:linLabe];
    
    [briefView addSubview:conCentLabel];
    
    backView.contentSize = CGSizeMake(ConentViewWidth, CGRectGetMaxY(briefView.frame)+20);
    
    
    [backView addSubview:briefView];
    
    
    
    
    
    //商家口号
    CGFloat  Sloganhight ;  // 根据子的内容显示 大小
    NSString * SloganStr =[NSString stringWithFormat:@"   %@",[DicData objectForKey:@"slogan"]];
    
    SloganStr =[SloganStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    Sloganhight = SloganStr.length/27;
    
    UIView *SloganView =[[UIView alloc]initWithFrame:CGRectMake(10, briefView.frame.size.height+briefView.frame.origin.y+10, ConentViewWidth-20, 90+(Sloganhight+1) *15)];
    if (SloganStr.length ==0) {
        
        SloganView.frame =CGRectMake(10, briefView.frame.size.height+briefView.frame.origin.y+10, ConentViewWidth-20, 0);
    }else{
        SloganView.backgroundColor =[UIColor whiteColor];
        UILabel *  SloganLabel =[[UILabel alloc]initWithFrame:CGRectMake(25, 3, 80, 20)];
        SloganLabel.text =@"商家口号";
        UIImageView * icoImaaaq =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_shangjiakouhao"]];
        icoImaaaq.frame= CGRectMake(5, 5,15,15);
        //    [SloganView addSubview:icoImaaaq];
        
        SloganLabel.font =[UIFont systemFontOfSize:15];
        [self labelToFit:SloganLabel];
        //    [SloganView addSubview:SloganLabel];
        UILabel *SloganConcentLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 35, ConentViewWidth-20,15*(Sloganhight+1))];
        SloganConcentLabel.text = SloganStr;
        SloganConcentLabel.numberOfLines =4;
        SloganConcentLabel.font =[UIFont systemFontOfSize:11];
        /*   if (Sloganhight < 1) {  // 一行
         //
         //    }
         //    else if(Sloganhight < 2){// 两行
         //
         //    }else if(Sloganhight < 3){ // 三行
         //
         }*/
        //    [SloganView addSubview:SloganConcentLabel];
        
        UILabel *linLabeww =[[UILabel alloc]initWithFrame:CGRectMake(0,23, ConentViewWidth -10, 1)];
        linLabeww.backgroundColor =BackColor;
        //    [SloganView addSubview:linLabeww];
    }
    // 评论的数组
    replyArr =[[NSArray alloc]initWithArray:[DicData objectForKey:@"comments"]];
    
    // 用于显示高度
    CGFloat PingLunHight = 0.0;
    // 需要评论数
    int nsmber = (int)replyArr.count;
    UIView *PingLunView =[[UIView alloc]initWithFrame:CGRectMake(10, SloganView.frame.origin.y+SloganView.frame.size.height+10, ConentViewWidth - 20, 100)];
    
    if (replyArr.count == 0) {
        PingLunView.frame  =CGRectMake(10, SloganView.frame.origin.y+SloganView.frame.size.height+10, ConentViewWidth - 20, 0);
        
    }else{
        
        UILabel *pingjiaLabel =[[UILabel alloc]initWithFrame:CGRectMake(25, 0, 40, 20)];
        pingjiaLabel.text =@"评论";
        
        UIImageView * icoImaaaa =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_pinglun"]];
        icoImaaaa.frame= CGRectMake(5, 5, 15, 15);
        [PingLunView addSubview:icoImaaaa];
        
        pingjiaLabel.font =[UIFont systemFontOfSize:15];
        PingLunView.backgroundColor =[UIColor whiteColor];
        [PingLunView addSubview:pingjiaLabel];
        
    }
    //  评论部分
    for (int i = 0 ; i<nsmber; i++) {
        UILabel *linLabel =[[UILabel alloc]init]; // 线条
        UIView *concentPingLunView =[[UIView alloc]init];//评论
        //   第一个评价
        if ( i == 0) {
            linLabel.frame = CGRectMake(5, 27, ConentViewWidth-30,1);
            linLabel.backgroundColor =BackColor;
            concentPingLunView.frame =CGRectMake(10, 30, ConentViewWidth -20, 30);
            
            // name  time concent   storename storeconcent
            UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 7, 100, 15)];
            nameLabel.font =[UIFont systemFontOfSize:13];
            // 用户名字
            nameLabel.text =[NSString stringWithFormat:@"%@",[replyArr[i] objectForKey:@"buyer_name"]];
            
            UILabel *TimeLabel =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth -160, 7, 150, 15)];
            TimeLabel.font =[UIFont systemFontOfSize:13];
            TimeLabel.text =[NSString stringWithFormat:@"%@",[replyArr[i] objectForKey:@"evaluation_time"]];
            [concentPingLunView addSubview:TimeLabel];
            [concentPingLunView addSubview:nameLabel];
            // 评论显示  用户的评论
            UILabel *MyConcent =[[UILabel alloc]initWithFrame:CGRectMake(10, 20, ConentViewWidth-40, 30)];
            MyConcent.text =[NSString stringWithFormat:@"    %@",[replyArr[i] objectForKey:@"comment"]];
            // 回复 占用的行数
            CGFloat hangshu  =  MyConcent.text.length / 26 +1;
            MyConcent.numberOfLines =0;
            MyConcent.font =[UIFont systemFontOfSize:11];
            if ( hangshu ==1) {
                MyConcent.frame=CGRectMake(10, 20, ConentViewWidth-40, 15*hangshu + 15);
                PingLunHight += 15+15 *hangshu;
            }
            else{
                MyConcent.frame=CGRectMake(10, 20, ConentViewWidth-40, 15*hangshu + 15);
                PingLunHight +=15+ 15 *hangshu;
            }
            //是否有商家回复
            NSString * replystr =[NSString stringWithFormat:@"%@",[replyArr[i] objectForKey:@"reply"]];
            //(@"replystr == %lu",(unsigned long)replystr.length);
            if(replystr.length != 0){
                // 商家回复的Label
                UILabel *storeLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, MyConcent.frame.origin.y+MyConcent.frame.size.height, ConentViewWidth-40, 15)];
                storeLabel.numberOfLines = 0;
                storeLabel.font =[UIFont systemFontOfSize:11];
                storeLabel.text =[NSString stringWithFormat:@"    商家回复:%@",[replyArr[i] objectForKey:@"reply"]];
                // 判断商家回复的行数
                if (storeLabel.text.length/26 <1) { // 一行
                    storeLabel.frame =CGRectMake(5, MyConcent.frame.origin.y+MyConcent.frame.size.height, ConentViewWidth-40, 15);
                    PingLunHight +=15;
                }
                else{// 两行
                    storeLabel.frame =CGRectMake(5, MyConcent.frame.origin.y+MyConcent.frame.size.height, ConentViewWidth-40, 15+15*storeLabel.text.length/26);
                    PingLunHight+= 15+15*storeLabel.text.length/26;
                }
                
                [concentPingLunView addSubview:storeLabel];
            }
            [concentPingLunView addSubview:MyConcent];
            
            
            //根君内容判断 高度
            PingLunHight += 15 ;
        }
        if ( i == 1) {
            linLabel.frame = CGRectMake(5, 41 +PingLunHight, ConentViewWidth-30, 1);
            linLabel.backgroundColor =BackColor;
            concentPingLunView.frame =CGRectMake(10, 20 +PingLunHight, ConentViewWidth -20, 30);
            
            UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 23, 100, 15)];
            nameLabel.font =[UIFont systemFontOfSize:13];
            nameLabel.text =[NSString stringWithFormat:@"%@",[replyArr[i] objectForKey:@"buyer_name"]];
            
            
            UILabel *TimeLabel =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth -160, 23, 150, 15)];
            TimeLabel.font =[UIFont systemFontOfSize:13];
            TimeLabel.text =[NSString stringWithFormat:@"%@",[replyArr[i] objectForKey:@"evaluation_time"]];
            [concentPingLunView addSubview:TimeLabel];
            [concentPingLunView addSubview:nameLabel];
            // 评论显示  用户的评论
            UILabel *MyConcent =[[UILabel alloc]initWithFrame:CGRectMake(10, 40, ConentViewWidth-40, 30)];
            MyConcent.text =[NSString stringWithFormat:@"    %@",[replyArr[i] objectForKey:@"comment"]];
            // 回复 占用的行数
            CGFloat hangshu  =  MyConcent.text.length / 26 +1;
            MyConcent.numberOfLines =0;
            MyConcent.font =[UIFont systemFontOfSize:11];
            if ( hangshu ==1) {
                MyConcent.frame=CGRectMake(10, 40, ConentViewWidth-40, 15);
                PingLunHight += 15 + 15;
            }
            else{
                MyConcent.frame=CGRectMake(10, 40, ConentViewWidth-40, 15+ 15*hangshu);
                PingLunHight += 15+ 15*hangshu;
            }
            NSString * replystr =[NSString stringWithFormat:@"%@",[replyArr[i] objectForKey:@"reply"]];
            
            if(replystr.length != 0){
                // 商家回复的Label
                UILabel *storeLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, MyConcent.frame.origin.y+MyConcent.frame.size.height, ConentViewWidth-40, 15)];
                storeLabel.numberOfLines =0;
                storeLabel.font =[UIFont systemFontOfSize:11];
                storeLabel.text =storeLabel.text =[NSString stringWithFormat:@"    商家回复:%@",[replyArr[i] objectForKey:@"reply"]];
                
                // 判断商家回复的行数
                if (storeLabel.text.length/26 <1) { // 一行
                    storeLabel.frame =CGRectMake(5, MyConcent.frame.origin.y+MyConcent.frame.size.height, ConentViewWidth-40, 15);
                    PingLunHight +=15;
                }
                else{// 两行
                    storeLabel.frame =CGRectMake(5, MyConcent.frame.origin.y+MyConcent.frame.size.height, ConentViewWidth-40, 15+15*storeLabel.text.length/26);
                    PingLunHight+= 15+15*storeLabel.text.length/26;
                }
                [concentPingLunView addSubview:storeLabel];
            }
            [concentPingLunView addSubview:MyConcent];
            
            
            
            //根君内容判断 高度
            PingLunHight += 15;
        }
        if ( i == 2) {
            linLabel.frame = CGRectMake(5, 41 +PingLunHight, ConentViewWidth-30, 1);
            linLabel.backgroundColor =BackColor;
            concentPingLunView.frame =CGRectMake(10, 40 +PingLunHight, ConentViewWidth -20, 30);
            
            UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 3, 100, 15)];
            nameLabel.font =[UIFont systemFontOfSize:13];
            nameLabel.text =[NSString stringWithFormat:@"%@",[replyArr[i] objectForKey:@"buyer_name"]];
            
            UILabel *TimeLabel =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth -160, 3, 150, 15)];
            TimeLabel.font =[UIFont systemFontOfSize:13];
            TimeLabel.text =[NSString stringWithFormat:@"%@",[replyArr[i] objectForKey:@"evaluation_time"]];            [concentPingLunView addSubview:TimeLabel];
            [concentPingLunView addSubview:nameLabel];
            // 评论显示  用户的评论
            UILabel *MyConcent =[[UILabel alloc]initWithFrame:CGRectMake(10, 20, ConentViewWidth-40, 30)];
            MyConcent.text =[NSString stringWithFormat:@"    %@",[replyArr[i] objectForKey:@"comment"]];
            // 回复 占用的行数
            CGFloat hangshu  =  MyConcent.text.length / 26 +1;
            MyConcent.numberOfLines =0;
            MyConcent.font =[UIFont systemFontOfSize:11];
            if ( hangshu ==1) {
                MyConcent.frame=CGRectMake(10, 20, ConentViewWidth-40, 15 + 15*hangshu);
                PingLunHight += 15 + 15*hangshu;
            }
            else{
                MyConcent.frame=CGRectMake(10, 20, ConentViewWidth-40, 15 + 15*hangshu);
                PingLunHight += 15 + 15*hangshu;
            }
            //是否有商家回复
            NSString * replystr =[NSString stringWithFormat:@"%@",[replyArr[i] objectForKey:@"reply"]];
            
            if(replystr.length != 0){
                // 商家回复的Label
                UILabel *storeLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, MyConcent.frame.origin.y+MyConcent.frame.size.height, ConentViewWidth-40, 15)];
                storeLabel.numberOfLines =0;
                storeLabel.font =[UIFont systemFontOfSize:11];
                storeLabel.text =[NSString stringWithFormat:@"    商家回复:%@",[replyArr[i] objectForKey:@"reply"]];
                // 判断商家回复的行数
                if (storeLabel.text.length/26 <1) { // 一行
                    storeLabel.frame =CGRectMake(5, MyConcent.frame.origin.y+MyConcent.frame.size.height, ConentViewWidth-40, 15 +15*storeLabel.text.length/26);
                    PingLunHight +=15 +15*storeLabel.text.length/26;
                }
                else{  // 两行
                    storeLabel.frame =CGRectMake(5, MyConcent.frame.origin.y+MyConcent.frame.size.height, ConentViewWidth-40, 15 +15*storeLabel.text.length/26);
                    PingLunHight +=15 +15*storeLabel.text.length/26;
                    
                }
                [concentPingLunView addSubview:storeLabel];
            }
            [concentPingLunView addSubview:MyConcent];
            //根君内容判断 高度
            PingLunHight  +=  50;
        }
        PingLunView.frame =CGRectMake(10, SloganView.frame.origin.y+SloganView.frame.size.height+10, ConentViewWidth - 20, PingLunHight +30 );
        
        [PingLunView addSubview:concentPingLunView];
        [PingLunView addSubview:linLabel];
    }
    UILabel *linLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, PingLunHight, ConentViewWidth-30,1)];
    linLabel.backgroundColor =BackColor;
    // 查看更多评论  有数据的时候在
    if(replyArr.count>3){
        UIButton *MoreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [MoreBtn setTitle:@"查看更多评论" forState:UIControlStateNormal];
        [MoreBtn setTitleColor:[UIColor blackColor ] forState:UIControlStateNormal];
        MoreBtn.frame =CGRectMake(0, linLabel.frame.origin.y+3, ConentViewWidth-20, 30);
        [MoreBtn addTarget:self action:@selector(MoreBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [PingLunView addSubview:MoreBtn];
        [PingLunView addSubview:linLabel];
        //   backView.contentSize =CGSizeMake(ConentViewWidth, PingLunView.frame.origin.y+PingLunView.frame.size.height);
        
    }
    else{
        //      backView.contentSize =CGSizeMake(ConentViewWidth, PingLunView.frame.origin.y+PingLunView.frame.size.height +20);
        
    }
    //       backView.contentSize = CGSizeMake(, <#CGFloat height#>)
    //    [backView addSubview:PingLunView];
    [self.view addSubview:backView ];
}
-(void)tapPage3:(UITapGestureRecognizer *)sender{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
        
        //   //(@"选中了 %ld",(long)indexPath.row);
        NSString * str =[NSString stringWithFormat:@"%@",[DuiHuanImageArray[sender.view.tag] objectForKey:@"advalue"]];
        NSLog(@"%@",str);
        NSString *type =[NSString stringWithFormat:@"%@",[DuiHuanImageArray[sender.view.tag] objectForKey:@"adtype"]];
        NSLog(@"%@",type);
        ADViewController *Avc =[[ADViewController alloc]initWithADStr:str andType:type];
        Avc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Avc animated:YES];
        
    }
}
//

-(void)ShareActComeIn{
    
    NSString * ShareStr =[NSString stringWithFormat:FenXiangLJ,StoreId];
    NSLog(@"wo d %@",ShareStr);
    NSString * concentStr =[DicData objectForKey:@"store_name"];
    
    
    
    //    [CoreUmengShare show:self text:concentStr image:topImageView.image];
    [UMSocialData defaultData].extConfig.qqData.url = ShareStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = ShareStr;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url =ShareStr;
    
    NSString *ProductName = [DicData objectForKey:@"store_name"];
    [UMSocialData defaultData].extConfig.wechatSessionData.title = ProductName;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = ProductName;
    [UMSocialData defaultData].extConfig.qqData.title = ProductName;
    [UMSocialData defaultData].extConfig.qzoneData.title = ProductName;
    
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5507c758fd98c5cdd1000244"
                                      shareText:concentStr
                                     shareImage:[UIImage imageNamed:@"60"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
                                       delegate:nil];
    
}


-(void)MoreBtnAction{
    MorePLViewController * MOreVC =[[MorePLViewController alloc]initWithStr:StoreId];
    [self.navigationController pushViewController:MOreVC animated:YES];
    
}
-(void)DaiJinAction:(UIGestureRecognizer *)tap{
    
    // //(@"%@",[[DicData objectForKey:@"voucher"]objectForKey:@"vid"]);
    NSArray * tmpArr =[NSArray arrayWithArray:[DicData objectForKey:@"voucherList"]];
    DaijianquanXQViewController *Dvc =[[DaijianquanXQViewController alloc]initVidWIthStr:[tmpArr[0] objectForKey:@"voucher_id"] andLIingqu:YES];
    Dvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Dvc animated:YES];
    
    // //(@"代金券详情46");
    
}
-(void)laysBtnAction:(UIButton *)Btn{
    if (Btn.tag == 1) {
        AlView =[[UIAlertView alloc]initWithTitle:@"关于代言人" message:@"用户成为商家代言人，与商家绑定获取商家销售额提成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [AlView show];
        
        
    }
    else if(Btn.tag ==2){
        //(@"     暂无代言人");
        //  进入砸金蛋
        NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
        NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
        int denglu  = (int)UserIDs.length;
        if (denglu ==  0) {// 未登录 进入登陆
            LogViewController *logview =[[LogViewController alloc]init];
            
            [self.navigationController pushViewController:logview animated:YES];
            
        }
        else{
            ZaJinDanViewController * zvc =[[ZaJinDanViewController alloc]init];
            [self.navigationController pushViewController:zvc animated:YES];
        }
    }
    else if (Btn.tag ==3){
        NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
        NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
        int denglu  = UserIDs.length;
        if (denglu ==  0) {// 未登录 进入登陆
            LogViewController *logview =[[LogViewController alloc]init];
            
            [self.navigationController pushViewController:logview animated:YES];
            
        }
        else{
            
            XunZhaoViewController *Avc =[[XunZhaoViewController alloc]initWithStoreId:StoreId];
            [self.navigationController pushViewController:Avc animated:YES];
            //(@"  寻找代言人    ");
            
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
}
-(void)PhoneActionwww{
    // 电话
    NSString * PhoneStr=[NSString stringWithFormat:@"tel://%@",[DicData objectForKey:@"tel"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneStr]];
    
}
-(void)AddressActionwww{
    
    NSString * ZuoBiaoLL =[NSString stringWithFormat:@"%@",[DicData objectForKey:@"address_ll"]];
    //    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    WanShangModel *model = [[WanShangModel alloc] init];
    model.storeName = [DicData objectForKey:@"store_name"];
    model.storeAddress_ll = ZuoBiaoLL;
    //    [dic setObject:ZuoBiaoLL forKey:@"ll"];
    //    [dic setObject:[DicData objectForKey:@"store_name"] forKey:@"title"];
    
    NSMutableArray * arr =[[NSMutableArray alloc]initWithObjects:model, nil];
    DaiLIShangMapViewController * Dvc =[[DaiLIShangMapViewController alloc]initWithArr:arr];
    [self.navigationController pushViewController: Dvc  animated:YES];
    
    //(@"进入地图");
}
-(void)ComeTapAccc{
    
    ShangJiaShangDianViewController * Svc =[[ShangJiaShangDianViewController alloc]initWithStoreID:StoreId];
    [self.navigationController pushViewController:Svc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//  自适应大小
-(void)labelToFit:(UILabel *)conCentLabe{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:conCentLabe.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [conCentLabe.text length])];
    conCentLabe.attributedText = attributedString;
    
    [conCentLabe sizeToFit];
}

@end
