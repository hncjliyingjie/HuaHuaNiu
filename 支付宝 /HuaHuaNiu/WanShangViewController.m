  //
//  WanShangViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-20.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "WanShangViewController.h"
#import "ProductDetailViewController.h"
#import "StoressssssTableViewCell.h"
#import "ThirdViewController.h"

#import "StoreDetailsViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "WSMoreViewController.h"
#import "DaiLIShangMapViewController.h"
#import "Toast+UIView.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "CitychooSSViewController.h"
#import "WanShangModel.h"

@interface WanShangViewController (){
    UIButton *leftBtn;
}
@property (nonatomic,strong)WanShangModel * model ;
@end

@implementation WanShangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:264/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    [self makeBarItem];
    self.view.backgroundColor =BackColor;
    
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    
    ll =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"ZUOBIAO"]];
    NSLog(@"%@",ll);
    isZuoB = YES;
    memberId = [NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    
//    [self makeDataWithIs_ll:ll andzuoBiao:isZuoB Useid:memberId];

    
    // Do any additional setup after loading the view.
}
-(void)makeBarItem{
 
//    leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 0, 50, 30);
    
   // NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
 //   NSString *Adress =[UserDefault objectForKey:@"WeiZhi"];
//    NSArray * arr =[Adress componentsSeparatedByString:@"省"];
//    NSString *CityStr;
//    NSString *PrivcrStr;
#pragma mark 所在地区
//    if (arr.count ==1) {  //直辖市  取前两个字
//        CityStr =[arr[0] substringToIndex:2];
//      //  [leftBtn setTitle:CityStr forState:UIControlStateNormal];
//    }
//    else{
//        PrivcrStr =[NSString stringWithFormat:@"%@省",arr[0]];
//       // NSArray * Cityarr =[arr[1] componentsSeparatedByString:@"市"];
//       // [leftBtn setTitle:Cityarr[0] forState:UIControlStateNormal];
//    }
    NSUserDefaults * nusdefaulr =[NSUserDefaults standardUserDefaults];
    NSString *ssss2 =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"CITYNAME"]];
    NSLog(@"%@",ssss2);
//    if (ssss2.length != 0) {
//        [leftBtn setTitle:ssss2 forState:UIControlStateNormal];
//
//    }else{
//    [leftBtn setTitle:@"区域" forState:UIControlStateNormal];
//    }
    [leftBtn setTitle:@"区域" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"icon_city_select"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(15,38, 10,0)];
//    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-55, 0,0)];
    leftBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    leftBtn.titleLabel.font =[UIFont systemFontOfSize:11];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftItem =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    UIImageView *leftIma =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    leftIma.image =[UIImage imageNamed:@"代言城-32px"];
    
//    UIBarButtonItem *imaItem =[[UIBarButtonItem alloc]initWithCustomView:leftIma];
//    self.navigationItem.leftBarButtonItem =imaItem;
//    NSArray *LeftArr=[[NSArray alloc]initWithObjects:imaItem,LeftItem, nil];
  //  LeftArr =@[imaItem,LeftItem];
//    self.navigationItem.leftBarButtonItems = LeftArr;
    self.navigationItem.leftBarButtonItem = LeftItem;
// 右侧的

//    self.navigationItem.title=@"万商";
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
//       
//       NSForegroundColorAttributeName:[UIColor whiteColor]}];
 // 搜索框
    CGFloat   beishu  = ConentViewWidth/320;
    
    TitleView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,146*beishu, 30)];
   TopTextField  =[[UITextField alloc]initWithFrame:CGRectMake(2, 3, 130,20)];
    TopTextField.delegate =self;
    TopTextField.textColor =[UIColor whiteColor];
    TopTextField.placeholder =@"请输入搜索内容";
    TopTextField.font =[UIFont systemFontOfSize:15];
    [TopTextField setValue:[UIColor colorWithRed:243/255.0 green:182/255.0 blue:187/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [TitleView addSubview:TopTextField];
    UIImageView *baima=[[UIImageView alloc]initWithFrame:CGRectMake(-3, 3,150*beishu-20, 20)];
    baima.image =[UIImage imageNamed:@"sousuoxian"];
    
    [TitleView addSubview:baima];

    
    self.navigationItem.titleView =TitleView;

    NSMutableArray *RigheItems =[[NSMutableArray alloc]init];
    for (int i = 0 ; i< 2; i++) {
        UIButton * RightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        RightBtn.frame =CGRectMake(0, 0, 20,20);
        RightBtn.tag =24+i;
        [RightBtn addTarget:self action:@selector(RightBtnActions:)forControlEvents:UIControlEventTouchUpInside];
        if (i ==0) {
            [RightBtn setImage:[UIImage imageNamed:@"app_top_ditu"] forState:UIControlStateNormal];
        }
        else{
            [RightBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
            
        }
        UIBarButtonItem *rightitem =[[UIBarButtonItem alloc]initWithCustomView:RightBtn];
        
        
        [RigheItems addObject:rightitem];
    }
    self.navigationItem.rightBarButtonItems = RigheItems;

    

}
-(void)leftBtnAction{
    CitychooSSViewController * cvc =[[CitychooSSViewController alloc]init];
    
    cvc.hidesBottomBarWhenPushed= YES;
    iscomefromcity = YES;
    [self.navigationController pushViewController:cvc animated:YES];

    NSArray * curass =ScrollVi.subviews;
    for (id Bt  in curass) {
        if ([Bt isKindOfClass:[UIButton class] ]) {
            [Bt removeFromSuperview];
        }
    }
    for (int i= 0; i<CityAreaDataArr.count; i++) {
        UIButton *Btn =[UIButton buttonWithType:UIButtonTypeCustom];
        Btn.frame=CGRectMake( 10+((ConentViewWidth-10)/3)*(i%3), 40*(i/3), 80, 30);
        Btn.tag = 112+i;
        [Btn setBackgroundColor:[UIColor whiteColor]];
        [Btn setTitle:[CityAreaDataArr[i]objectForKey:@"region_name"] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(AreaAction:) forControlEvents:UIControlEventTouchUpInside];
        [ScrollVi addSubview:Btn];
    }
//      CityTopView.hidden = !CityTopView.hidden;
 
}

-(void)RightBtnActions:(UIButton *)Btn{
    if (Btn.tag == 24) {
        if(self.model.storesArr.count == 0){
            UIAlertView * alll =[[UIAlertView alloc]initWithTitle:@"提示·" message:@"暂无数据无法获取位置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alll show];
        
        }
        else{
              DaiLIShangMapViewController * daiVi =[[DaiLIShangMapViewController alloc]initWithArr:self.model.storesArr];
        daiVi.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:daiVi animated:YES];
        }
     
        
    }
    else if (Btn.tag ==25){// 搜索
        NSString *Str =TopTextField.text;
        if (Str.length == 0) {
            UIAlertView * sear =[[UIAlertView alloc]initWithTitle:@"提示" message:@"搜索内容不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [sear show];
        }
        else{
        NSString * seastr =TopTextField.text;
        TopTextField.text =@"";
        ThirdViewController *Tvc =[[ThirdViewController alloc]initWithConcentStr:seastr];
        Tvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Tvc animated:YES];
        }
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{


}
#pragma mark 选择区域
-(void)AreaAction:(UIButton *)Btn {
    CityTopView.hidden = YES;
    WanShangModel *areaModel =  self.model.areaArr[Btn.tag -112];
    //重新 请求数据
    ll = areaModel.areaId;
    isZuoB = NO;
    
    NSUserDefaults * nusdefaulr =[NSUserDefaults standardUserDefaults];
    memberId = [NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"Useid"]];
    
    [self makeDataWithIs_ll:ll andzuoBiao:isZuoB Useid:memberId];
}

// str  yes 是坐标          no是区域ID
-(void)makeDataWithIs_ll:(NSString *)Str andzuoBiao:(BOOL )zuo Useid:(NSString *)useid{
//    NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
//    NSLog(@"%@",[Userdefaults objectForKey:@"Useid"]);
//    NSString *memberid = [NSString stringWithFormat:@"123"];
    
    [self.view makeToastActivity];
    NSDictionary * parameters;
    NSNumber * num =[NSNumber numberWithInt:1];
    if(zuo){
        //,member_id,"member_id"   useid,"member_id",
        parameters =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",Str,@"ll",@"0",@"is_ll",num,@"page",useid,@"member_id",nil];

    }else{
        
        parameters =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",Str,@"ll",@"1",@"is_ll",num,@"page",useid,@"member_id",nil];
    }
    //(@"%@",parameters);
    
    ShouY = [NSString stringWithFormat:WanShang];

//    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:parameters complete:^(NSDictionary *data) {
        NSLog(@"%@",data);
        [self.view hideToastActivity];
        [_Tv footerEndRefreshing];
        [_Tv headerEndRefreshing];
        if ([data objectForKey:@"error"]) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",[data objectForKey:@"error"]);
        }else{
            self.model =[WanShangModel makeMainModelWithDict:data];
            [self makeUI];
        }

    }];
    

}
-(void)makeUI{
    
    
#pragma mark tbview的header
    
    IOS_Frame
    
    
    
    if (!headerView) {
        headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 240)];
    }
    
    
    
    if (!CityTopView) {
        CityTopView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 230)];
        CityTopView.backgroundColor = BackColor;
        CityTopView.hidden =YES;
    }
    if (TopScrllView) {
        TopScrllView.contentSize =CGSizeMake(ConentViewWidth* self.model.flashArr.count,130);
        _pageControl.numberOfPages = self.model.flashArr.count;
        
        // 删除 scrollView上的数据
        NSArray *ViewArr =TopScrllView.subviews;
        for (id ima in ViewArr) {
            if ([ima isKindOfClass:[UIImageView class]]) {
                [ima removeFromSuperview];
            }
        }
        
        for (int i = 0 ; i<self.model.flashArr.count; i++) {
            UIImageView *ima =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth*i, 0, ConentViewWidth, 130)];
            ima.tag = 77+i ;
            WanShangModel * flashModel =self.model.flashArr[i];
            
            [ima sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,flashModel.flashLogo]] placeholderImage:[UIImage imageNamed:@"default"]];
            ima.userInteractionEnabled = YES;
            
            UITapGestureRecognizer * ImageTop =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapActio:)];
            [ima addGestureRecognizer:ImageTop];
            [TopScrllView addSubview:ima];
            
        }
        
    }
    else{
        
        TopScrllView  =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth,130)];
        TopScrllView.delegate=self;
        TopScrllView.bounces = NO;
        TopScrllView.pagingEnabled = YES;
        TopScrllView.showsVerticalScrollIndicator = NO;
        TopScrllView.showsHorizontalScrollIndicator = NO;
        
        TopScrllView.contentSize =CGSizeMake(ConentViewWidth*self.model.flashArr.count,130);
        _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(10, TopScrllView.frame.size.height-30, ConentViewWidth -20, 30)];
        _pageControl.backgroundColor =[UIColor clearColor];
        _pageControl.numberOfPages = self.model.flashArr.count;
        
        
        for (int i = 0 ; i<self.model.flashArr.count; i++) {
            UIImageView *ima =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth*i, 0, ConentViewWidth, 150)];
            WanShangModel * flashModel=self.model.flashArr[i];
            ima.tag = 77+i ;
            [ima sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,flashModel.flashLogo]] placeholderImage:[UIImage imageNamed:@"default"]];
            //  ima.image=[UIImage imageNamed:@"default"];
            ima.userInteractionEnabled = YES;
            
            UITapGestureRecognizer * ImageTop =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapActio:)];
            [ima addGestureRecognizer:ImageTop];
            [TopScrllView addSubview:ima];
            
        }
        
        [headerView addSubview:TopScrllView];
        [headerView addSubview:_pageControl];
        
    }
    
    if (middleView) {
        
        NSArray *CCArr =middleView.subviews;
        for (id btn in CCArr) {
            if ([btn isKindOfClass:[UIButton class]]) {
                [btn removeFromSuperview];
            }
        }
        //        NSArray *NamenLaberAee=@[@"食品美食",@"美业日用",@"生活休闲",@"更多"];
        //        NSArray *ImageArrr =@[@"app_meishitiandi",@"app_meiyeriyong",@"app_shenghuoxiuxian",@"app_gengduo"];
        
        for (int i =  0; i< 4; i++) {
            UIButton *MiddleBtn =[UIButton buttonWithType:
                                  UIButtonTypeCustom];
            
            [MiddleBtn setTitleEdgeInsets:UIEdgeInsetsMake(75.0, 0, 0, 0)];
            UIImageView *ima =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth/4*i +ConentViewWidth/6 -37, 10, 45, 45)];
            if(i< 3){
                WanShangModel * advModel =self.model.advArr[i];
                [ima sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,advModel.advLogo]] placeholderImage:[UIImage imageNamed:@"default"]];
                [middleView addSubview:ima];
                [MiddleBtn setTitle:advModel.advOthername forState:UIControlStateNormal];
            }
            else{
                ima.image =[UIImage imageNamed:@"app_gengduo"];
                [middleView addSubview:ima];
                [MiddleBtn setTitle:@"更多" forState:UIControlStateNormal];
                
            }
            MiddleBtn.titleLabel.font =[UIFont systemFontOfSize:11];
            [MiddleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            MiddleBtn.frame = CGRectMake(ConentViewWidth/4*i +ConentViewWidth/6 -37, 10, 45, 45);
            [MiddleBtn addTarget:self action:@selector(BtnSSSTion:) forControlEvents:UIControlEventTouchUpInside];
            [middleView addSubview:MiddleBtn];
            MiddleBtn.tag = 20+i;
        }
        
        
    }
    else{
        middleView =[[UIView alloc]initWithFrame:CGRectMake(0, TopScrllView.frame.origin.y+TopScrllView.frame.size.height, ConentViewWidth, 110)];
        
        middleView.backgroundColor =[UIColor whiteColor];
        
        for (int i =  0; i< 4; i++) {
            UIButton *MiddleBtn =[UIButton buttonWithType:
                                  UIButtonTypeCustom];
            
            [MiddleBtn setTitleEdgeInsets:UIEdgeInsetsMake(75.0, 0, 0, 0)];
            UIImageView *ima =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth/4*i +ConentViewWidth/6 -37, 10, 45, 45)];
            if(i< 3){
                WanShangModel * advModel =self.model.advArr[i];
                [MiddleBtn setTitle:advModel.advOthername forState:UIControlStateNormal];
                [ima sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,advModel.advLogo]] placeholderImage:[UIImage imageNamed:@"default"]];
                [middleView addSubview:ima];
            }
            else{
                ima.image =[UIImage imageNamed:@"app_gengduo"];
                [middleView addSubview:ima];
                [MiddleBtn setTitle:@"更多" forState:UIControlStateNormal];
            }
            MiddleBtn.titleLabel.font =[UIFont systemFontOfSize:11];
            [MiddleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            MiddleBtn.frame = CGRectMake(ConentViewWidth/4*i +ConentViewWidth/6 -37, 10, 45, 45);
            [MiddleBtn addTarget:self action:@selector(BtnSSSTion:) forControlEvents:UIControlEventTouchUpInside];
            [middleView addSubview:MiddleBtn];
            UIView *view11=[[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-40, 80, ScreenWidth, 30)];
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
            lable.text=@"城堡－生活";
            [view11 addSubview:lable];
            [middleView addSubview:view11];
            MiddleBtn.tag = 20+i;
        }
        [headerView addSubview:middleView];
        
        NSLog(@"  heihg ===sds  %f",middleView.frame.size.height+middleView.frame.origin.y);
    }
    if (_Tv) {
        
        _Tv.frame =CGRectMake(0,0, ConentViewWidth,ConentViewHeight);
        
        if (self.model.storesArr.count == 0) {
            zanwushuju.hidden =NO;
        }
        else{
            zanwushuju.hidden  = YES;
        }
        
        
        if (self.model.storesArr.count  < (ConentViewHeight -middleView.frame.size.height-middleView.frame.origin.y - 49)/75) {
            _Tv.frame =CGRectMake(0, 0, ConentViewWidth,210+ 75 * self.model.storesArr.count );
            _Tv.scrollEnabled = NO;
            
        }
        else{
            
            _Tv.scrollEnabled = YES;
        }
        [_Tv reloadData];
        
        
    }
    else{
        
        // 他不view的高度
        CGFloat Tabviewheight = ConentViewHeight -middleView.frame.size.height-middleView.frame.origin.y ;
        // 可以放几个cell；
        int numberforCell =Tabviewheight/75 ;
        zanwushuju =[[UILabel alloc]initWithFrame:CGRectMake(0,240,ConentViewWidth, 30)];
        zanwushuju.font =[UIFont systemFontOfSize:14];
        zanwushuju.textAlignment = NSTextAlignmentCenter;
        zanwushuju.text =@"暂无数据";
        
        
        _Tv  =[[UITableView alloc]initWithFrame:CGRectMake(0,0, ConentViewWidth,ConentViewHeight  ) style:UITableViewStylePlain];
        _Tv.scrollEnabled = YES;
        _Tv.showsVerticalScrollIndicator = NO;
        _Tv.delegate =self;
        _Tv.dataSource =self;
        if(self.model.storesArr.count == 0){
            zanwushuju.hidden = NO;
        }
        else{
            zanwushuju.hidden = YES;
        }
        if (self.model.storesArr.count  < numberforCell) {
            
            _Tv.frame =CGRectMake(0, 0, ConentViewWidth, 210+ 75 * self.model.storesArr.count );
        }
        
        [self.view addSubview:_Tv];
    }
    
    _Tv.tableHeaderView = headerView;
    
    [self.view addSubview:CityTopView];
    
    [self.view addSubview:zanwushuju];

    // 定时器
    if (_Timer ) {
        //  请求完数据开始
        [_Timer setFireDate: [NSDate distantPast]];
        
    }
    else{
        _Timer  =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(TopGunDongAction) userInfo:nil repeats:YES];
        
        //  请求完数据开始
        [_Timer setFireDate: [NSDate distantPast]];
    }
}

-(void)imageTapActio:(UITapGestureRecognizer *)Tap{
    int  a =(int)Tap.view.tag - 77;
    WanShangModel * flashModel  =self.model.flashArr[a];
    StoreDetailsViewController *Stv  =[[StoreDetailsViewController alloc]initWithStr:flashModel.flashAdvalue ];

    [self.navigationController pushViewController:Stv animated:YES];

}

-(void)viewWillDisappear:(BOOL)animated{
    [_Timer setFireDate:[NSDate distantFuture]];
}

-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults * nusdefaulr =[NSUserDefaults standardUserDefaults];
    NSString *ssss2 =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"CITYNAME"]];
    if (ssss2.length != 0) {
        [leftBtn setTitle:ssss2 forState:UIControlStateNormal];
        NSString *ssss =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"QUYUID"]];
        isZuoB = NO;
        memberId = [NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"Useid"]];
        //请求数据
        [self makeDataWithIs_ll:ssss andzuoBiao:isZuoB Useid:memberId];
        
    }else{
        
        [leftBtn setTitle:@"区域" forState:UIControlStateNormal];
    }
//    if (iscomefromcity == NO) {
//
//        
//    }
//    else{
//        //(@"11111");
//        iscomefromcity =NO;
//        //请求数据
//        NSUserDefaults * nusdefaulr =[NSUserDefaults standardUserDefaults];
//        NSString *ssss2 =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"CITYNAME"]];
//        NSLog(@"%@",ssss2);
//        if (ssss2.length != 0) {
//            [leftBtn setTitle:ssss2 forState:UIControlStateNormal];
//            
//        }else{
//            [leftBtn setTitle:@"区域" forState:UIControlStateNormal];
//        }
//        NSString *ssss =[NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"QUYUID"]];
//        isZuoB = NO;
//        memberId = [NSString stringWithFormat:@"%@",[nusdefaulr objectForKey:@"Useid"]];
//        
//        [self makeDataWithIs_ll:ssss andzuoBiao:isZuoB Useid:memberId];
//    }
}
-(void)TopGunDongAction{
//  图片滚动  ScrollDataArr.count 市图片的个数
    static   CGFloat a = 0;
    if (a >=self.model.flashArr.count) {
        a=0;
    }
   // a=  pt.x/ConentViewWidth;
    TopScrllView.contentOffset  =CGPointMake(ConentViewWidth *a , 0);
    _pageControl.currentPage = a;
      a++;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint pt =scrollView.contentOffset;
    _pageControl.currentPage  = pt.x/ConentViewWidth;
    
}
-(void)BtnSSSTion:(UIButton *)Btn{
    int a =(int)Btn.tag -20;
    
    if ( a < 3) {
        WanShangModel * advModel =self.model.advArr[a];
        NSString * FenID=advModel.advAdvalue;
        
        ThirdViewController *Tvc = [[ThirdViewController alloc]initWithcateId:FenID];
        Tvc.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:Tvc animated:YES];
    }
    else{
        WSMoreViewController *wvc =[[WSMoreViewController alloc]init];
        [self.navigationController pushViewController:wvc animated:YES];
    }
 }


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WanShangModel * storeModel =[self.model.storesArr objectAtIndex:indexPath.row];
    /*
     "last_use_date：最后使用日期 ，
     free_code：使用唯一编号，
     logo：商品图片，
     freelog_id：抢单表主键，
     status：状态（0：未使用，1：已使用，2：已过期），
     received_time：抢单时间，
     introduce：商品描述，
     gf_id：免费商品主键，
     goods_name：化妆品，
     surplus：剩余可抢单数
     end_date：过期日期 
     used_time：兑换时间"
     */
    StoreDetailsViewController *pvc =[[StoreDetailsViewController alloc]initWithStr:storeModel.storeId];
    pvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pvc animated:YES];
    
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%@",self.model.storesArr);
    return  self.model.storesArr.count;
    
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoressssssTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell =[[[NSBundle mainBundle]loadNibNamed:@"StoressssssTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    NSLog(@"%@",self.model.storesArr[indexPath.row]);
//    [self makeCellWithModel:self.model.storesArr[indexPath.row]];
    [cell makeCellWithModel:self.model.storesArr[indexPath.row]];
    cell.DiZhiLabel.text=[NSString stringWithFormat:@"%@ km",[self makeCellWithModel:self.model.storesArr[indexPath.row]]];
    return cell;
}
-(NSString *)makeCellWithModel:(WanShangModel *)model{
    NSString * sss  =model.storeDistance;
    return sss;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
} 

@end
