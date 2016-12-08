//
//  FirstViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-4.
//  Copyright (c) 2015年 张燕. All rights reserved.
//
extern NSString *strIndex;
#import "FirstViewController.h"
#import "ZYView.h"
#import "FindStoreView.h"
#import "StoreDetailsViewController.h"
#import "ProductDetailViewController2.h"
#import "ProductDetailViewController.h"
#import "MyLaysViewController.h"
#import "RecommendViewController.h"
#import "LooKInComeViewController.h"
#import "DaiJinQuanViewController.h"
#import "InViteViewController.h"
#import "NearlySTableViewCell.h"
#import "AFNetworking.h"
#import "TureViewController.h"
#import "UIImageView+WebCache.h"
#import "SearchReaultViewController.h"
#import "ThirdViewController.h"
#import "CYRZViewController.h"
#import "Toast+UIView.h"
#import "ZaJinDanViewController.h"
#import "LogViewController.h"
#import "MyLoneViewController.h"
#import "saomiajieguoViewController.h"
#import "CitychooSSViewController.h"
#import "ZhaoPinViewController.h"
#import "QiuZhiViewController.h"
#import "NewGuangGaoViewController.h"
#import "DaxiangViewController.h"
#import "CustomViewController.h"
#import "czzyTableViewController.h"
#import "esmmTableViewController.h"
#import "sjkyTableViewController.h"
#import "sqqViewController.h"
#import "ShenqingquyudaiViewController.h"



NSString *str;


//#import "SUNSlideSwitchDemoViewController.h"

@interface FirstViewController ()<CustomViewControllerDelegate>{
    NSArray * _btnArr ;
}
@property (nonatomic ,strong)AlexModel * mainModel;
@end

@implementation FirstViewController


- (void)poushViewConWith:(NSNotification *)notificationn{
    
    UIViewController *pvc = notificationn.object;
    [self.navigationController pushViewController:pvc animated:YES];
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
 
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(poushViewConWith:) name:@"pushViewCon" object:nil];
    
    _btnArr =@[@"1社区圈",@"2开业庆典",@"3二手买卖",@"4出租转让",@"5招聘求职",@"6砸金蛋",@"7我来代言",@"8诚邀入驻"];
    iscomefromcity = NO;
    self.view.backgroundColor =BackColor;
    [self.view makeToastActivity];
    [self DingWeiJSuo]; // 定位检索
    // 添加UIScrollView
    [self makeBackScrollView];
    //添加头部视图
    [self makeTopView];
    //请求网址
    [self makeweizhi];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 的点击事件
-(void)btnClick:(UIButton *)btn{
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = (int)UserIDs.length;
    if (denglu ==  0) {
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{

    switch (btn.tag) {
        case 996:
        {
            NSLog(@"砸金蛋");
            sqqViewController *hvc =[[sqqViewController alloc]init];
            hvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
        case 997:
        {
            NSLog(@"求职招聘");
            sjkyTableViewController *hvc =[[sjkyTableViewController alloc]init];
            hvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
        case 998:
        {
            NSLog(@"二手买卖");
            esmmTableViewController *hvc =[[esmmTableViewController alloc]init];
            hvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
        case 999:
        {
            NSLog(@"出租转让");
            czzyTableViewController *hvc =[[czzyTableViewController alloc]init];
            hvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
        case 1006:
        {
            NSLog(@"我的关联商家");
            MyLoneViewController *hvc =[[MyLoneViewController alloc]init];
            hvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:hvc animated:YES];
        }
            break;
            
            default:
            break;
    }
    }
}

#pragma mark - 请求网络数据

-(void)creatData{
    
    [self.view makeToastActivity];
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString *ShouY = [NSString stringWithFormat:mainUrl];
    NSLog(@" shouYie =%@ ",ShouY);
    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",@"",@"adfloor",AddllStr,@"ll",[UserDefault objectForKey:@"Useid"],@"member_id",nil];
    NSLog(@"dict is =%@",dict);
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:dict complete:^(NSDictionary * data) {
        NSLog(@"this is data = %@",data);
        if ([data objectForKey:@"error"]) {
            [self.view hideToastActivity];
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            NSLog(@"%@",[data objectForKey:@"msg"]);
             self.mainModel= [AlexModel makeMainModelWithDict:data];
            [self makeUIwith:self.mainModel];
            [self.view hideToastActivity];
        }
    }];

    
//        CityAreaDataArr  =[ResultDic objectForKey:@"area"];
    
//        morenArr =[ResultDic objectForKey:@"area"];

}

-(void)makeUIwith:(AlexModel *)model{
    self.view.backgroundColor = [UIColor grayColor];
    IOS_Frame
    //topView
    if (TopView) {
        NSLog(@"topView is ture!");
    }
    else{
        TopView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 200)];
        TopView.contentSize =CGSizeMake(ConentViewWidth * model.flashArr.count, 80);
        TopView.pagingEnabled = YES;
        TopView.delegate =self;
        TopView.bounces = NO;
        TopView.showsVerticalScrollIndicator = NO;
        TopView.showsHorizontalScrollIndicator = NO;
        [BackScrollView addSubview:TopView];
    }
    
    NSArray * topArr =[TopView subviews];
    for (id imm in topArr) {
        if ([imm isKindOfClass:[UIImageView class]]) {
            [imm removeFromSuperview];
        }
    }

    for (int i = 0; i< model.flashArr.count; i++) {
        UIImageView *ima =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth * i, 0, ConentViewWidth, 200)];
        ima.userInteractionEnabled  = YES;
        ima.tag = 50+i;
        UITapGestureRecognizer *ImagtapA =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImagtapAct:)];
        [ima addGestureRecognizer:ImagtapA];
        AlexModel * flashModel =model.flashArr[i];
        //写在model里
        NSString *uelstr =[NSString stringWithFormat:IMaUrl,flashModel.flashLogo];
        NSURL *StrUrl =[NSURL URLWithString:uelstr];
        [ima sd_setImageWithURL:StrUrl placeholderImage:[UIImage imageNamed:@"default"]];
//        UITapGestureRecognizer * ImageTop =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapActio:)];
//        [ima addGestureRecognizer:ImageTop];
        [TopView addSubview:ima];
    }

    if (_pageControl) {
        [MTimer setFireDate:[NSDate distantPast]];
    }else{
        _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(10, TopView.frame.size.height-30, ConentViewWidth -20, 30)];
        _pageControl.backgroundColor =[UIColor clearColor];
        _pageControl.numberOfPages = model.flashArr.count;
        [BackScrollView addSubview:_pageControl];
        
        MTimer =[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(TimerAction:) userInfo:nil repeats:YES];
        
        [MTimer setFireDate:[NSDate distantPast]];
        // middleView
        
    }
    
    //middleView 需要修改的界面
    if (middleView) {
        
    }else{
        
        middleView =[[UIView alloc]initWithFrame:CGRectMake(0, TopView.frame.size.height, ConentViewWidth, 95)];
        middleView.backgroundColor =[UIColor whiteColor];

        
        UIScrollView * sv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 5, ConentViewWidth, 85)];
        sv.backgroundColor =[UIColor whiteColor];
        sv.showsHorizontalScrollIndicator =NO;
        sv.showsVerticalScrollIndicator =NO;
        sv.alwaysBounceVertical =NO;
        sv.alwaysBounceHorizontal =YES;
        sv.contentSize =CGSizeMake(_btnArr.count*80, 85);
        [middleView addSubview:sv];
        
        
        for (NSInteger i =0; i<_btnArr.count; i++) {
            UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag =996+i;
            [btn setImage:[UIImage imageNamed:_btnArr[i]] forState:UIControlStateNormal];
            btn.frame =CGRectMake(5+i*80, 5, 75, 75);
            [sv addSubview:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }

        [BackScrollView addSubview:middleView];
        
    }
    
    
    //MyView 新功能列表
#pragma 广告求职
    
    if (MyView) {
        
    }
    else{

        MyView =[[UIView alloc]initWithFrame:CGRectMake(0, middleView.frame.origin.y + middleView.frame.size.height , ConentViewWidth, 190)];
        MyView.backgroundColor =[UIColor whiteColor];
    }
    
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0, ConentViewWidth/2, 90);
    [btn setImage:[UIImage imageNamed:@"app_kgg"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag =1004;
    [MyView addSubview:btn];
    
    UIButton * btn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame =CGRectMake(ConentViewWidth/2, 0, ConentViewWidth/2, 90);
    [btn2 setImage:[UIImage imageNamed:@"app_fgg"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag =1005;

    [MyView addSubview:btn2];
    
    UIButton * btn3 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame =CGRectMake(0, btn.frame.origin.y+btn.frame.size.height+5, ConentViewWidth/3, 90);
    [btn3 setImage:[UIImage imageNamed:@"app_qzzp"] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag =1006;
    [MyView addSubview:btn3];
    
    UIButton * btn4 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame =CGRectMake(ConentViewWidth/3, btn.frame.origin.y+btn.frame.size.height+5, ConentViewWidth/3, 90);
    [btn4 setImage:[UIImage imageNamed:@"app_zdmf"] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn4.tag =1007;
    [MyView addSubview:btn4];
    
    UIButton * btn5 =[UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame =CGRectMake(ConentViewWidth/3*2, btn.frame.origin.y+btn.frame.size.height+5, ConentViewWidth/3, 90);
    [btn5 setImage:[UIImage imageNamed:@"代金券"] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn5.tag =1008;

    [MyView addSubview:btn5];


    [BackScrollView addSubview:MyView];



    if (JxView) {
        [Fvc makeDataWithArr:model.bouArr];
    }
    else{
        
        JxView =[[UIView alloc]initWithFrame:CGRectMake(0, MyView.frame.origin.y+MyView.frame.size.height+10, ConentViewWidth , 270)];
        UILabel *JXlabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
        [JXlabel setCenter:CGPointMake(ScreenWidth/2+5, 10)];
        JXlabel.text =@"银元兑商品";
        JXlabel.font =[UIFont systemFontOfSize:13];
        [JxView addSubview:JXlabel];
        JxView.backgroundColor =[UIColor whiteColor];
        Fvc =[[[NSBundle mainBundle ]loadNibNamed:@"FindStoreView" owner:self options:nil]lastObject];
        Fvc.frame= CGRectMake(0,30 , ConentViewWidth, 240);
        [Fvc makeDataWithArr:model.bouArr];
        
        [Fvc pushBockTo:^(NSString *StoreStr) {
//            http://daiyancheng.cn/appgoods/goods_info.do?token=test&id=%@&page=%d&member_id=%@
            NSString *ShouY = [NSString stringWithFormat:@"http://daiyancheng.cn/appgoods/goods_info.do?token=test&id=%@&page=%d&member_id=%@",StoreStr,1,@"member_id"];
            
            ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
            
            [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DataDic = [[NSDictionary alloc]initWithDictionary:responseObject];
                if ([[NSString stringWithFormat:@"%@",[DataDic objectForKey:@"is_change"] ]isEqualToString:@"0"]) {
                    ProductDetailViewController *Svc =[[ProductDetailViewController alloc]initWithStr:StoreStr];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewCon" object:Svc];
                }else{
                    
                    NSString *goodID = [DataDic objectForKey:@"goods_id"];
                    ProductDetailViewController2 *pro=[[ProductDetailViewController2 alloc]initWithStr:goodID];
                    pro.strName=[DataDic objectForKey:@"goods_name"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushViewCon" object:pro];
                }


                NSLog(@"%@",responseObject);
                NSLog(@"%@",DataDic);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self.view hideToastActivity];
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [failAlView show];
            }];
            
            NSLog(@"进入 产品详情");
        }];
        
        [JxView addSubview:Fvc];
        [BackScrollView addSubview:JxView];
        
    }
    
    if (FXLS) {
        
        nearlyTv.frame =CGRectMake(0,25  ,ConentViewWidth, 75*model.nearArr.count );
        FXLS.frame =CGRectMake(0, JxView.frame.origin.y+JxView.frame.size.height +10, ConentViewWidth, model.nearArr.count*75);
        BackScrollView.contentSize =CGSizeMake(ConentViewWidth, FXLS.frame.size.height+FXLS.frame.origin.y +23);
        [nearlyTv reloadData];
    }
    else{
        
        
        FXLS =[[UIView alloc]initWithFrame:CGRectMake(0, JxView.frame.origin.y+JxView.frame.size.height +10, ConentViewWidth, 685)];
        FXLS.backgroundColor =[UIColor whiteColor];
        UILabel *FXLSlabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
        FXLSlabel.text =@"赚银元";
        [FXLSlabel setCenter:CGPointMake(ScreenWidth/2+5, 10)];
        FXLSlabel.font =[UIFont systemFontOfSize:13];
        [FXLS addSubview:FXLSlabel];
        nearlyTv =[[UITableView alloc]initWithFrame:CGRectMake(0,25,ConentViewWidth, 75*model.nearArr.count )];
        nearlyTv.scrollEnabled = NO;
        nearlyTv.delegate =self;
        nearlyTv.dataSource =self;
        [FXLS addSubview:nearlyTv];
        FXLS.frame =CGRectMake(0, JxView.frame.origin.y+JxView.frame.size.height +10, ConentViewWidth, model.nearArr.count*75);
        BackScrollView.contentSize =CGSizeMake(ConentViewWidth, FXLS.frame.size.height+FXLS.frame.origin.y +23);
        [BackScrollView addSubview:FXLS];
    }
    if (CityTopView) {
        
    }
    else{
        CityTopView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 200)];
        CityTopView.backgroundColor = BackColor;
        CityTopView.hidden =YES;
    }
    [self.view addSubview:CityTopView];
    
}
-(NSDictionary *)makeData:(NSString *)sender{
//    [self.view makeToastActivity];
//    NSDictionary *dic1;
    DataDic=[NSDictionary dictionary];
    NSString *ShouY = [NSString stringWithFormat:ProductXiangqing,sender,1];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DataDic = [[NSDictionary alloc]initWithDictionary:responseObject];
        NSLog(@"%@",responseObject);
        NSLog(@"%@",DataDic);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    return DataDic;
}

-(void)makeTopView{
    
    
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:264/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    
    LeftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [LeftBtn setImage:[UIImage imageNamed:@"icon_city_select"] forState:UIControlStateNormal];
    
    [LeftBtn setTitle:@"区域" forState:UIControlStateNormal];
    LeftBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    
   //[LeftBtn setBackgroundColor:[UIColor blackColor]];
      LeftBtn.frame =CGRectMake(0, 0, 50, 30);
     [LeftBtn setImageEdgeInsets:UIEdgeInsetsMake(15,35, 10,0)];
    [LeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-50, 0,10)];
//    LeftBtn.backgroundColor = [UIColor redColor];
    [LeftBtn addTarget:self action:@selector(LeftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:LeftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    UIView *titleViewl =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 30)];
    TopTextField =[[UITextField alloc]initWithFrame:CGRectMake(50, 5, ConentViewWidth-154, 20)];
    TopTextField.delegate =self;
//   TopTextField.backgroundColor =[UIColor whiteColor];
    TopTextField.font =[UIFont systemFontOfSize:13];
    TopTextField.textColor =[UIColor whiteColor];
    TopTextField.placeholder =@"此处输入搜索内容";
    [TopTextField setValue:[UIColor colorWithRed:243/255.0 green:182/255.0 blue:187/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    UIImageView *baima=[[UIImageView alloc]initWithFrame:CGRectMake(0, 6,ConentViewWidth-140, 20)];
    baima.image =[UIImage imageNamed:@"sousuoxian"];
//    titleViewl.backgroundColor = [UIColor cyanColor];/////
    [titleViewl addSubview:TopTextField];

    [titleViewl addSubview:baima];
    
   // titleViewl.backgroundColor =[UIColor whiteColor];
    
    FenleiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    FenleiBtn.frame =CGRectMake(10, 0, 40, 30);
    FenleiBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [FenleiBtn setTitle:@"商品" forState:UIControlStateNormal];
    [FenleiBtn setImage:[UIImage imageNamed:@"sanjiao"] forState:UIControlStateNormal];
    [FenleiBtn addTarget:self action:@selector(FenleiBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [FenleiBtn  setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, -5)];
    [FenleiBtn setImageEdgeInsets:UIEdgeInsetsMake(16, 33, 8, 1)];
    [titleViewl addSubview:FenleiBtn];
   
    
    self.navigationItem.titleView =titleViewl;
   
    UIButton *searchBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame =CGRectMake(0, 0, 20,20);
  //  searchBtn.backgroundColor = [UIColor redColor];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(SearchAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *SearchItem =[[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    
    UIButton *btn  =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0,20, 20);
   // [btn setTitle:@"二维码" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_erweima"] forState:UIControlStateNormal] ;
    [btn addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
    NSArray *RightItemArr =@[rightItem,SearchItem];
   self.navigationItem.rightBarButtonItems = RightItemArr;
}
-(void)FenleiBtnAction:(UIButton *)Btn{
    [fenleiView removeFromSuperview];
    fenleiView =[[UIView alloc]initWithFrame:CGRectMake(75, 0, 50, 60)];
    fenleiView.backgroundColor =[UIColor blackColor];

    [self.view addSubview:fenleiView];

    typeStr  = [NSString stringWithFormat:@"%d",2];

    NSArray *arr =@[@"商品",@"商家"];
    for (int i = 0; i< 2; i++) {
        UIButton *btn =(UIButton *)[fenleiView viewWithTag:47+i];
        [btn removeFromSuperview];
    }
  
    for (int i = 0 ; i<2; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(0, 30*i, 50, 30);
        btn.tag =47+i;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shaghuAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //[btn setBackgroundColor:[UIColor whiteColor]];
        [fenleiView addSubview:btn];
    }
        //fenleiView.hidden  = !fenleiView.hidden;

}
-(void)shaghuAction:(UIButton *)btn{
    
    if(btn.tag ==47){
       
        [FenleiBtn setTitle:@"商品" forState:UIControlStateNormal];
        typeStr  = [NSString stringWithFormat:@"%d",2];
    }
    else if(btn.tag == 48){
       
        [FenleiBtn setTitle:@"商家" forState:UIControlStateNormal];
        typeStr  = [NSString stringWithFormat:@"%d",1];
    }
      fenleiView.hidden = YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;

}

#pragma mark 搜索
-(void)SearchAction{
    
    NSString *Str =TopTextField.text;
    if (Str.length == 0) {
        UIAlertView * sear =[[UIAlertView alloc]initWithTitle:@"提示" message:@"搜索内容不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [sear show];
    }
    else{
   NSLog(@"搜索 %@   %@",Str ,typeStr);
  TopTextField.text = @"";
//    NSLog(@"str ==%@,  text  == %@",Str,TopTextField.text);
    if ( [typeStr isEqualToString:@"2"]) {
        SearchReaultViewController * svc =[[SearchReaultViewController alloc]initWithStr:Str];
         svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:svc animated:YES];
    }
    else{
        ThirdViewController  * Tvc =[[ThirdViewController alloc]initWithConcentStr:Str];
        Tvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: Tvc animated:YES];
        
    }
 }
}

-(void)LeftAction{
    CitychooSSViewController * cvc =[[CitychooSSViewController alloc]init];
    cvc.hidesBottomBarWhenPushed= YES;
    iscomefromcity = YES;
    [self.navigationController pushViewController:cvc animated:YES];

}

#pragma mark 区域id请求
-(void)makeditdiawithID:(NSString * )addsssID{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    [self.view makeToastActivity];
    
    NSString *ShouY = [NSString stringWithFormat:mainUrl];
    NSLog(@" shouYie =%@ ",ShouY);
    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",@"1",@"adfloor",addsssID,@"ll",[UserDefault objectForKey:@"Useid"],@"member_id",nil];
    NSLog(@"dict is =%@",dict);
    str=[dict objectForKey:@"ll"];
    NSLog(@"%@",[dict objectForKey:@"ll"]);
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:dict complete:^(NSDictionary * data) {
        NSLog(@"this is data = %@",data);
        if ([data objectForKey:@"error"]) {
            [self.view hideToastActivity];
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            NSLog(@"%@",[data objectForKey:@"msg"]);
            self.mainModel= [AlexModel makeMainModelWithDict:data];
            [self makeUIwith:self.mainModel];
            [self.view hideToastActivity];
        }
    }];
}
#pragma 添加UIScrollView
-(void)makeBackScrollView{
    BackScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)];
    BackScrollView.delegate =self;
    BackScrollView.contentSize =CGSizeMake(ConentViewWidth, ConentViewHeight +856);
    BackScrollView.bounces = NO;
    BackScrollView.backgroundColor =BackColor;
    BackScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:BackScrollView];
}


-(void)TimerAction:(AlexModel *)model{

    if (j == self.mainModel.flashArr.count) {
        j =0;
    }
    TopView.contentOffset = CGPointMake(ConentViewWidth * j, 0);
    _pageControl.currentPage = j;
    j++;
    NSLog(@"%f",TopView.contentOffset.x);

}


-(void)RightAction{
  
    
    CustomViewController * cv=[[CustomViewController alloc] initWithBlock:^(NSString *result, BOOL isSucceed) {
        
        if (isSucceed) {
            
            if([self isvalidateWangzhan:result]){
            
            saomiajieguoViewController * savc =[[saomiajieguoViewController alloc]initWithSte:result];
            savc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:savc animated:YES];
            }
          
            NSLog(@"~~~%@",result);
        }else{
            NSLog(@"失败了");
        }
    }];
    cv.delegate=self;
    [self presentViewController:cv animated:YES completion:nil];
}

-(void)customViewController:(CustomViewController *)controller didScanResult:(NSString *)result
{
    NSLog(@"获得的结果%@",result);
}
-(void)customViewControllerDidCancel:(CustomViewController *)controller
{
    NSLog(@"取消扫描");
}


#pragma mark -------- 轮播图点击跳转
-(void)ImagtapAct:(UITapGestureRecognizer *)tap{
    
    int i =  (int)tap.view.tag -50;
    
    AlexModel *flashModel =self.mainModel.flashArr[i];
    
    if ([flashModel.flashType isEqualToString:@"2"]) {//商品
        //判断跳转的是哪一个控制器
        
        //发送网络请求
        NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
        NSString *ShouY = [NSString stringWithFormat:ProductXiangqing,flashModel.flashId,1,[Userdefaults objectForKey:@"Useid"]];
        NSLog(@"%@",flashModel.flashId);
        //(@"%@",ShouY);
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //change_type： 商品兑换方式：0：全部  1：现场  2：邮寄
            NSLog(@"%@",responseObject);
            NSString * change = [NSString stringWithFormat:@"%@",responseObject[@"is_change"]];
            if ([change isEqualToString:@"1"]) {
                //兑换商品
                ProductDetailViewController2 *Stvc =[[ProductDetailViewController2 alloc]initWithStr:flashModel.flashId];
                Stvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:Stvc animated:YES];
            }else{
                //普通商品
                ProductDetailViewController *Stvc =[[ProductDetailViewController alloc]initWithStr:flashModel.flashId];
                Stvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:Stvc animated:YES];
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.view hideToastActivity];
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];
        
        
    }else if ([flashModel.flashType isEqualToString:@"1"]) {//商家
        
        StoreDetailsViewController *Stvc =[[StoreDetailsViewController alloc]initWithStr:flashModel.flashId];
        Stvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Stvc animated:YES];
    } else if ([flashModel.flashType isEqualToString:@"0"]) {
        //显示图片
//        ProductDetailViewController *Stvc =[[ProductDetailViewController alloc]initWithStr:flashModel.flashId];
//        Stvc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:Stvc animated:YES];
    }
  
    else if([flashModel.flashType isEqualToString:@"3"]){//大像网
        DaxiangViewController *davc = [[DaxiangViewController alloc]init];
        davc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:davc animated:YES];
    
    }
    NSLog(@"%d",i);

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AlexModel *model =[self.mainModel.nearArr objectAtIndex:indexPath.row];
    NSString *str =model.nearId;
    NSLog(@"%@",str);
    StoreDetailsViewController *stvc =[[StoreDetailsViewController alloc]initWithStr:str];
    stvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:stvc animated:YES];
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.mainModel.nearArr.count;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NearlySTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"NearlySTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    AlexModel *model =[self.mainModel.nearArr objectAtIndex:indexPath.row];
    
    [cell makeCellWithModel:model];

    return cell;
    
}

-(void)BtnAction:(UIButton *)Btn{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = (int)UserIDs.length;
    if (denglu ==  0) {
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
        
    if (Btn.tag == 30) {
        NSLog(@"%ld",(long)Btn.tag);
        MyLoneViewController *hvc =[[MyLoneViewController alloc]init];
        hvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hvc animated:YES];
    }
    else if(Btn.tag ==31){ //

        ZaJinDanViewController * zvc =[[ZaJinDanViewController alloc]init];
        zvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:zvc animated:YES];
        
    }
    
    else if(Btn.tag ==32){
      
        if(1){
        NSLog(@"%ld",(long)Btn.tag);
        MyLaysViewController *lvc =[[MyLaysViewController alloc]init];
        lvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:lvc animated:YES];
        }
        else{
   
        }
    }
    else if(Btn.tag ==33){
        NSLog(@"%ld",(long)Btn.tag);
        RecommendViewController *rvc =[[RecommendViewController alloc]init];
        rvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:rvc animated:YES];

    }
    else if(Btn.tag ==34){
        NSLog(@"%ld",(long)Btn.tag);
        LooKInComeViewController *lvc =[[LooKInComeViewController alloc]init];
        lvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:lvc animated:YES];

    }
    else if(Btn.tag ==35){
        TureViewController *TVC =[[TureViewController alloc]init];
        TVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:TVC  animated:YES];
        NSLog(@"%ld",(long)Btn.tag);
    }
    else if (Btn.tag ==36){
        DaiJinQuanViewController *Dvc =[[DaiJinQuanViewController alloc]init];
        Dvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Dvc animated:YES];
        
    }
    else if(Btn.tag ==37){
        
        CYRZViewController * Cvc =[[CYRZViewController alloc]init];
        Cvc.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:Cvc animated:YES];
        
        
    NSLog(@"%ld",(long)Btn.tag);
    }else if (Btn.tag ==39){
        QiuZhiViewController * qzvc =[[QiuZhiViewController alloc]init];
        qzvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:qzvc animated:YES];
        
    }else if (Btn.tag ==40){
        ZhaoPinViewController * zpvc =[[ZhaoPinViewController alloc]init];
        zpvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:zpvc animated:YES];
    }
    }
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint pt =scrollView.contentOffset;
    _pageControl.currentPage  = pt.x/ConentViewWidth;
    j= pt.x/ConentViewWidth;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;

    if ([strIndex isEqualToString:@"11"]) {
        self.tabBarController.selectedIndex=3;
        strIndex=@"00";
    }
    
    [MTimer setFireDate:[NSDate distantPast]];
    _locService.delegate =self;
    _geocodesearch.delegate =self;
    NSUserDefaults * nusdefaulr =[NSUserDefaults standardUserDefaults];
    NSString *ssss =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"QUYUID"]];
    
    
    if (ssss.length == 0) {
//    if (iscomefromcity == NO) {
        //ZUOBIAO
        NSUserDefaults * nusdefaulr =[NSUserDefaults standardUserDefaults];
        NSString *ssss =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"ZUOBIAO"]];
        NSString *ssss2 =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"CITYNAME"]];
        [LeftBtn setTitle:ssss2 forState:UIControlStateNormal];
        LeftBtn.titleLabel.font =[UIFont systemFontOfSize:12];
        
        [self makeditdiawithID:ssss];
    }
    else{
        iscomefromcity =NO;
      NSUserDefaults * nusdefaulr =[NSUserDefaults standardUserDefaults];
        //QUYUID
//      NSString *ssss =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"ZUOBIAO"]];
        NSString *ssss =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"QUYUID"]];
        NSString *ssss2 =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"CITYNAME"]];
        [LeftBtn setTitle:ssss2 forState:UIControlStateNormal];
        LeftBtn.titleLabel.font =[UIFont systemFontOfSize:12];

        [self makeditdiawithID:ssss];
//        iscomefromcity = NO;
    }

}
-(void)viewWillDisappear:(BOOL)animated{
    _geocodesearch.delegate = nil;
    _locService.delegate = nil;
    [MTimer setFireDate:[NSDate distantFuture]];
}

-(void)DingWeiJSuo{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];

    _geocodesearch =[[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate =self;

}
#pragma mark --LocationDelegate

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */

- (void)didFailToLocateUserWithError:(NSError *)error{
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{

    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
  
    AddllStr =[NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:AddllStr forKey:@"userlocatll"];
    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[Userdefaults objectForKey:@"userlocatll"]);

    
    NSLog(@"获取的 地理坐标然后请求数据 %@",AddllStr);
    
    //定位置后才能请求数据
    if (AddllStr.length> 0) {
        
        NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
        NSString * ADDSTR=[NSString stringWithFormat:@"%@",AddllStr];
        [userdefault setObject:ADDSTR forKey:@"ZUOBIAO"];
        [userdefault synchronize];
        [self creatData];
    }else{
        UIAlertView * all =[[UIAlertView alloc]initWithTitle:@"提示" message:@"获取地理位置失败" delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
        [all show];

        NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
        // 位置失败 默认郑州
        
        
        NSString * ADDSTR=[NSString stringWithFormat:@"34.763815678878,113.63489789543"];
        [userdefault setObject:ADDSTR forKey:@"ZUOBIAO"];
        [userdefault synchronize];
        [self creatData];
    }
//    BMKMapManager * mm =[[BMKMapManager alloc]init];
//    [mm start:AddllStr generalDelegate:self];
    // 定完位置 开始反检索

    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    
    pt = (CLLocationCoordinate2D){ userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];

    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }

    [_locService stopUserLocationService];
    
    [self.view hideToastActivity];
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{

    NSUserDefaults *UserDetault =[NSUserDefaults standardUserDefaults];
    [UserDetault setObject:result.address forKey:@"WeiZhi"];
    NSLog(@"xxxx%@",result.address);

    [UserDetault synchronize];
    NSArray * arr =[result.address componentsSeparatedByString:@"省"];
    NSLog(@"%@",arr);
    NSString *CityStr;
    NSString *PrivcrStr;
    NSString *  cityname =[NSString stringWithFormat:@"%@",result.addressDetail.city];
    [UserDetault setObject:cityname forKey:@"CITYNAME"];
    [UserDetault synchronize];
    if (arr.count ==1) {  //直辖市  取前两个字
     CityStr =[arr[0] substringToIndex:2];
       [LeftBtn setTitle:CityStr forState:UIControlStateNormal];
    }
    
    else{
       PrivcrStr =[NSString stringWithFormat:@"%@省",arr[0]];
       NSArray * Cityarr =[arr[1] componentsSeparatedByString:@"市"];
      [LeftBtn setTitle:Cityarr[0] forState:UIControlStateNormal];
    }
    NSLog(@"%@     %@",PrivcrStr,CityStr);
   if (error == 0) {
        NSLog(@"%@",result.address);

    }
}

#pragma 判断网址
-(BOOL)isvalidateWangzhan:(NSString *)wangzhi{
    NSLog(@"wangzhi == %@",wangzhi);
    if([wangzhi rangeOfString:@"http"].location !=NSNotFound)//_roaldSearchText
    {
        return  YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma plist文件保存服务器的地址；
//// plist文件保存服务器的地址；
-(void)makeFuWuqidizhi:(NSString * )str{
    NSArray * paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path =[paths objectAtIndex:0];
    NSString *filename =[path stringByAppendingPathComponent:@"text.plist"];
    NSDictionary * readdic =[NSDictionary dictionaryWithContentsOfFile:filename];
    NSLog(@"dic  == %@",readdic);
    
    NSDictionary * Writdic =[NSDictionary dictionaryWithObjectsAndKeys:@"shuju",@"IP", nil];
    
    [Writdic writeToFile:filename atomically:YES];
}
#pragma 请求网络数据
-(void)makeweizhi{
    NSString *ShouY = [NSString stringWithFormat:@"%@",CityList];
    NSLog(@"1113213213131%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
        if ([str isEqualToString:@"1"]) {
             NSArray*  arr =[[NSArray alloc]initWithArray:[responseObject objectForKey:@"retval"]];
            NSUserDefaults * userdefaule =[NSUserDefaults standardUserDefaults];
            [userdefaule setObject:arr forKey:@"CITYLIEBIAO"];
            [userdefaule synchronize];
        }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"error");
    }];
}

@end
