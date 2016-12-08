//
//  ZYMViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZYMViewController.h"
#import "HHHeaderView.h"
#import "HHContactTableView.h"
#import "HHContentTableView.h"
#import "HHHorizontalPagingView.h"
#import "Masonry.h"
#import "KFView.h"
#import "ImagePlayerView.h"
#import "Toast+UIView.h"
#import "ZYModel.h"


@interface ZYMViewController ()<ImagePlayerViewDelegate,UIWebViewDelegate>
{
    NSMutableArray *_arrProductImg;//轮播图路径
    
    NSString *idStr;//点击的列表id
  
    HHHeaderView *headerView;
    HHContentTableView *tableView;
    HHContactTableView *csTableView ;
   
    
}

@property(strong,nonatomic) NSMutableArray *dataArray;//存model的数组

@property double labelHeight;//描述内的内容高度

//@property(strong,nonatomic)HHHorizontalPagingView *pagingView;
@end

@implementation ZYMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //加载数据
    [self makeData];

    
}
-(void)makeUI{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"资源详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    
    //自定义返回按钮
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_new"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    headerView = [HHHeaderView headerView];
    //收藏按钮添加手势
    UITapGestureRecognizer *collTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCollectImageView:)];
    [headerView.collectImageView addGestureRecognizer:collTap];
    //分享按钮添加手势
    UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShareImageView:)];
    [headerView.collectImageView addGestureRecognizer:shareTap];
    
    
    tableView           = [HHContentTableView contentTableView];

    //    HHContentView *speakView = [HHContentView contentView];
    csTableView         = [HHContactTableView contactTableView];
    
    
    NSMutableArray *buttonArray = [NSMutableArray array];
    for(int i = 0; i < 2; i++) {
        UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"line02"] forState:UIControlStateNormal];
        [segmentButton setBackgroundImage:[UIImage imageNamed:@"line01"] forState:UIControlStateSelected];
        if (i==0) {
            [segmentButton setTitle:@"图文详情" forState:UIControlStateNormal];
        }
        if (i==1) {
            [segmentButton setTitle:@"Ta的评价" forState:UIControlStateNormal];
        }
        [segmentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [segmentButton setTitleColor:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1] forState:UIControlStateSelected];
        [segmentButton setBackgroundColor:[UIColor whiteColor]];
        
        segmentButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [buttonArray addObject:segmentButton];
    }
   
      HHHorizontalPagingView *pageSecoundView  = [HHHorizontalPagingView pagingViewWithHeaderView:headerView headerHeight:688.f+_labelHeight+100 segmentButtons:buttonArray segmentHeight:35 contentViews:@[tableView, csTableView]frameHeight:ScreenHeight-64-50];
    
     [self.view addSubview:pageSecoundView];
    
    //轮播图
    _arrProductImg = [[NSMutableArray alloc]initWithObjects:@"1.png",@"2.png",@"3.png",nil];
    
    ImagePlayerView *imageplayer = [[ImagePlayerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150*ScreenWidth/320)];
    [headerView addSubview:imageplayer];
    [self setimagePlayer:imageplayer];
    
    KFView *kfView=[KFView creatKFView];
    [self.view addSubview:kfView];
    [kfView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width
                                         , 50));
        make.left.mas_equalTo(self.view).offset(0);
        make.bottom.mas_equalTo(self.view).with.offset(0);
    }];
    
    //    距离顶部导航栏为0
    [pageSecoundView mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(self.view.frame.size.width);
        make.left.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).with.offset(0);
        make.bottom.mas_equalTo(self.view).with.offset(0);
    }];


}
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
        
    }
    return _dataArray;
    
}
-(ZYMViewController *)initWithIdStr:(NSString *)idStrs{
    idStr=idStrs;
    return self;
}

- (void)tapCollectImageView:(UITapGestureRecognizer *)tap {
    KMyLog(@"收藏");
}
- (void)tapShareImageView:(UITapGestureRecognizer *)tap {
    KMyLog(@"分享");
}

-(void)viewWithData{
    
    ZYModel *model=[self.dataArray objectAtIndex:0];
    headerView.ditieName.text=model.name;
    headerView.miaoshuLbl.text=model.profiles;
    headerView.priceLbl.text=[NSString stringWithFormat:@"%@",model.price];
    headerView.loctionLbl.text=[NSString stringWithFormat:@"%@%@%@",model.province,model.city,model.address];
    headerView.coverNumberLbl.text= [NSString stringWithFormat:@"%@",model.cover_num];
    headerView.timeLbl.text=[NSString stringWithFormat:@"%@——————%@",model.start_time,model.end_time];
   
    headerView.typeLbl.text=[NSString stringWithFormat:@"户外"];
    headerView.guigeLbl.text=[NSString stringWithFormat:@"%@cm*%@cm",model.width,model.height];
    headerView.dyrLbl.text= [NSString stringWithFormat:@"恭喜%@成为代言人",model.nick_name];
    headerView.companyNameLbl.text=model.company_name;
    
    //简介自适应高度
    headerView.miaoshuLbl.numberOfLines = 0;
    
    headerView.miaoshuLbl.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [headerView.miaoshuLbl sizeThatFits:CGSizeMake(headerView.miaoshuLbl.frame.size.width, MAXFLOAT)];
    
     headerView.profielsHeight.constant=size.height;
    
    _labelHeight=size.height;
    
}

-(void)makeData{
    
    [self.view makeToastActivity];
    
    NSString * ShouY = [NSString stringWithFormat:@"%@%@%@",DYUrl,ZYLISTMOREURL,idStr];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.view hideToastActivity];
        NSMutableDictionary *array=[responseObject objectForKey:@"resource"];
          NSLog(@"资源详情返回数据%@",array);
          [self.view hideToastActivity];
            //地铁名字
            NSString *ditieNameStr=[array objectForKey:@"name"];
            //描述
            NSString *profilesStr=[array objectForKey:@"profiles"];
            //价格
            NSString *priceStr=[array objectForKey:@"out_price"];
            //媒介位置
            NSString *shengStr=[array objectForKey:@"province"];
            NSString *cityStr=[array objectForKey:@"city"];
            NSString *addressStr=[array objectForKey:@"address"];
        
            //受众人群
            NSString *cover_numStr=[array objectForKey:@"cover_num"];
            //开始时间
            NSString *startStr=[array objectForKey:@"start_time"];
            //结束时间
            NSString *endStr=[array objectForKey:@"end_time"];
            //类型
            NSString *typeStr=[array objectForKey:@"type"];
            //规格
            NSString *widthStr=[array objectForKey:@"width"];
            NSString *heightStr=[array objectForKey:@"height"];
            //代言人名字
            NSString *headNameStr=[array objectForKey:@"nick_name"];
            //代言人头像
            NSString *headImg=[array objectForKey:@"spokesman"];
            //公司名称
            NSString *companyStr=[array objectForKey:@"company_name"];
        
            NSString *idStrs=[array objectForKey:@"id"];
        
            //图文详情
            NSString *detialStr=[array objectForKey:@"detail"];
        
            //轮播图
            NSArray*imgArray=[array objectForKey:@"heads"];
        for (int i=0; i<imgArray.count; i++) {
            NSDictionary *imgDic=[imgArray objectAtIndex:i];
            NSString *imgStr=[imgDic objectForKey:@"image"];
            //头像给的是网址，需要转化
            NSMutableString *url=[NSMutableString stringWithFormat:DYListUrl,DYSTRRING, imgStr];
            UIImage *headimg=[self getImageFromURL:url];
            
        }
      
        ZYModel *model=[[ZYModel alloc]init];
        model.name=ditieNameStr;
        model.profiles=profilesStr;
        model.price=priceStr;
        model.province=shengStr;
        model.city=cityStr;
        model.address=addressStr;
        model.cover_num=cover_numStr;
        model.start_time=startStr;
        model.end_time=endStr;
        model.type=typeStr;
        model.width=widthStr;
        model.height=heightStr;
//        model.gerenImg=
        model.nick_name=headNameStr;
        model.company_name=companyStr;
        model.detail=detialStr;
//        model.lunboImg=
        model.idStr=idStrs;
        [self.dataArray addObject:model];
        
        
        [self makeUI];

        //显示数据
        [self viewWithData];
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
    }];
    
    
}

-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

#pragma mark ---轮播图
-(void)setimagePlayer:(ImagePlayerView *)player
{
    player.imagePlayerViewDelegate = self;
    // set auto scroll interval to x seconds
    player.scrollInterval = 5.0f;
    // adjust pageControl position
    player.pageControlPosition = ICPageControlPosition_BottomCenter;
    // hide pageControl or not
    player.hidePageControl = NO;

    // adjust edgeInset
    player.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    player.numberItems = 3;
    [player reloadData];
}

- (NSInteger)numberOfItems
{
    return [_arrProductImg count];
}

-(void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index{
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    
    NSString *str = [_arrProductImg  objectAtIndex:index];
    UIImage *imgDefault = [UIImage imageNamed:@"loadingBanner"];
    //    [imageView sd_setImageWithURL:[NSURL URLWithString:str]
    //                 placeholderImage:imgDefault];
    
    // });
    imageView.image=[UIImage imageNamed:str];
}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    CGPoint pt =scrollView.contentOffset;
//    _pageControl.currentPage  = pt.x/ConentViewWidth;
//    j= pt.x/ConentViewWidth;
//}
#pragma mark ---获取数据-首页轮播图
- (void)getHeaderData
{
    //    [[TTIHttpClient sharedClient] requestUserFindMessageListInfoWithConsumerId:@"1" signature:@"111" token:@"222" successBlock:^(TTIRequest *request, TTIResponse *response) {
    //
    //        [SVProgressHUD dismiss];
    //
    //        NSMutableArray *imaArr = [NSMutableArray array];
    //        if ([[response.result objectForKey:@"object"] isKindOfClass:[NSArray class]])
    //        {
    //            NSArray *array = [response.result objectForKey:@"object"];
    //            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //
    //            }];
    //        }
    //
    //        //self.arrProductImg = imaArr;
    //
    //        //图片播放器
    //        //[self setimagePlayer];
    //
    //
    //    } failedBlock:^(TTIRequest *request, TTIResponse *response) {
    //
    //        //[SVProgressHUD dismiss];
    //        //[self setimagePlayer];
    //        
    //    }];
}

@end
