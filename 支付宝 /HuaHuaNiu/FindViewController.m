//
//  FindViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "FindViewController.h"

#import "FWLView.h"

#import "ZXCell.h"

#import "Toast+UIView.h"

#import "CitychooSSViewController.h"
#import "BMKLocationService.h"
#import "BMKGeocodeSearch.h"

#import "Masonry.h"
#import "GGaoViewController.h"
#import "ZXViewController.h"
#import "ZXMoreViewController.h"

#import "ZXModel.h"
#import "sqqViewController.h"

#import "LogViewController.h"
#import "ZaJinDanViewController.h"
#import "ZhaoPinViewController.h"
#import "esmmTableViewController.h"
#import "czzyTableViewController.h"
#import "MyLaysViewController.h"
#import "WanShangViewController.h"
#import "MyLoneViewController.h"

@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>
{
   
    NSArray * _btnArr ;
    UIPageControl *_pageControl;
    NSTimer *MTimer;
    CGFloat j ;
    NSString * AddllStr;
    UIButton *LeftBtn;
    // 判断是不是 城市选择进入的
    BOOL iscomefromcity;
    BMKLocationService  * _locService ;
    BMKGeoCodeSearch* _geocodesearch;
    

}
@property (nonatomic ,strong)AlexModel * mainModel;

@property (nonatomic ,strong) NSMutableArray *zxArray;//资讯列表

@property (weak, nonatomic) IBOutlet UIButton *fwBtn;//服务按钮
@property (weak, nonatomic) IBOutlet UIButton *dyBtn;//代言人按钮
@property (weak, nonatomic) IBOutlet UIButton *spBtn;//视频按钮


@property (strong, nonatomic)  sqqViewController *tempView1;

@property (strong, nonatomic)  UIView *tempView2;

@property(strong,nonatomic) FWLView *fwlView;//服务页面

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeZixunData];
    self.title=@"发 现";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    //设置服务，代言人，视频按钮Tag
    [self setBtnTag];
    
    _btnArr =@[@"1社区圈",@"2开业庆典",@"3二手买卖",@"4出租转让",@"5招聘求职",];
    
    //加载代言人，合作等横向滑动的view
    [self withSlideView];
    
    self.fwlView.customTableView.delegate=self;
    self.fwlView.customTableView.dataSource=self;
    self.fwlView.customTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //设置导航栏左边
    [self makeTopView];
    //请求网址
    [self makeweizhi];

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
                ZaJinDanViewController * zvc =[[ZaJinDanViewController alloc]init];
                zvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:zvc animated:YES];
            }
                break;
            case 997:
            {
                NSLog(@"求职招聘");
                ZhaoPinViewController * zpvc =[[ZhaoPinViewController alloc]init];
                zpvc.hidesBottomBarWhenPushed =YES;
                [self.navigationController pushViewController:zpvc animated:YES];
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
            case 1000:
            {
                NSLog(@"我的代言");
                MyLaysViewController *lvc =[[MyLaysViewController alloc]init];
                lvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:lvc animated:YES];
            }
                break;
                
            default:
            break;
        }
    }
}


-(void)viewWillAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed=NO;
    [self.view addSubview:self.fwlView];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.tabBarController.tabBar.translucent=NO;
    self.tabBarController.tabBar.tintColor=[UIColor whiteColor];    

}


//代言家，活动招人等横向滚动的按钮
-(void)withSlideView{
    UIScrollView * sv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 5, ConentViewWidth, 85)];
    sv.backgroundColor =[UIColor whiteColor];
    sv.showsHorizontalScrollIndicator =NO;
    sv.showsVerticalScrollIndicator =NO;
    sv.alwaysBounceVertical =NO;
    sv.alwaysBounceHorizontal =YES;
    sv.contentSize =CGSizeMake(_btnArr.count*100, 85);
    [self.fwlView.slideView addSubview:sv];
    
    
    for (NSInteger i =0; i<_btnArr.count; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag =996+i;
        [btn setImage:[UIImage imageNamed:_btnArr[i]] forState:UIControlStateNormal];
//        btn.frame =CGRectMake(5+i*80, 5, 75, 75);
        CGFloat dis=ConentViewWidth/3.5;
        btn.frame =CGRectMake(15+i*dis, 5, 55, 55);
        [sv addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)makeUIwith:(AlexModel *)model{

    for (int i = 0; i< model.flashArr.count; i++) {
        UIImageView *ima =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth * i, 0, ConentViewWidth, 200)];
        ima.userInteractionEnabled  = YES;
        ima.tag = 50+i;
        UITapGestureRecognizer *ImagtapA =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImagtapAct:)];
        [ima addGestureRecognizer:ImagtapA];
        AlexModel * flashModel =model.flashArr[i];
//        写在model里
        NSString *uelstr =[NSString stringWithFormat:IMaUrl,flashModel.flashLogo];
        NSURL *StrUrl =[NSURL URLWithString:uelstr];
        [ima sd_setImageWithURL:StrUrl placeholderImage:[UIImage imageNamed:@"default"]];
            [self.fwlView.topScrollView addSubview:ima];
    }
    
    if (_pageControl) {
        [MTimer setFireDate:[NSDate distantPast]];
    }else{
        _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(10,self.fwlView.topScrollView.frame.size.height-30, ConentViewWidth -20, 30)];
        _pageControl.backgroundColor =[UIColor clearColor];
        _pageControl.numberOfPages = 5;
        [self.view addSubview:_pageControl];
        
        MTimer =[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(TimerAction:) userInfo:nil repeats:YES];
        
        [MTimer setFireDate:[NSDate distantPast]];
        
    }

}
-(void)TimerAction:(AlexModel *)model{
    
    if (j == 5) {
        j =0;
    }
    self.fwlView.topScrollView.contentOffset = CGPointMake(ConentViewWidth * j, 0);
    _pageControl.currentPage = j;
    j++;
    NSLog(@"%f",self.fwlView.topScrollView.contentOffset.x);
    
}

-(void)makeTopView{
    LeftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [LeftBtn setImage:[UIImage imageNamed:@"icon_city_select"] forState:UIControlStateNormal];
    //    LeftBtn.backgroundColor=[UIColor redColor];
    
    [LeftBtn setTitle:@"区域" forState:UIControlStateNormal];
    LeftBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [LeftBtn setTitleColor:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1] forState:UIControlStateNormal];
    
    //[LeftBtn setBackgroundColor:[UIColor blackColor]];
    LeftBtn.frame =CGRectMake(0, 0, 50, 30);
    [LeftBtn setImageEdgeInsets:UIEdgeInsetsMake(15,35, 10,0)];
    [LeftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-50, 0,10)];
    //    LeftBtn.backgroundColor = [UIColor redColor];
    [LeftBtn addTarget:self action:@selector(LeftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:LeftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
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
//                //兑换商品
//                ProductDetailViewController2 *Stvc =[[ProductDetailViewController2 alloc]initWithStr:flashModel.flashId];
//                Stvc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:Stvc animated:YES];
//            }else{
//                //普通商品
//                ProductDetailViewController *Stvc =[[ProductDetailViewController alloc]initWithStr:flashModel.flashId];
//                Stvc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:Stvc animated:YES];
//                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.view hideToastActivity];
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
            //(@"cook load failed ,%@",error);
        }];
        
        
    }else if ([flashModel.flashType isEqualToString:@"1"]) {//商家
//        
//        StoreDetailsViewController *Stvc =[[StoreDetailsViewController alloc]initWithStr:flashModel.flashId];
//        Stvc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:Stvc animated:YES];
    } else if ([flashModel.flashType isEqualToString:@"0"]) {
        //显示图片
        //        ProductDetailViewController *Stvc =[[ProductDetailViewController alloc]initWithStr:flashModel.flashId];
        //        Stvc.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:Stvc animated:YES];
    }
    
    else if([flashModel.flashType isEqualToString:@"3"]){//大像网
//        DaxiangViewController *davc = [[DaxiangViewController alloc]init];
//        davc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:davc animated:YES];
        
    }
    NSLog(@"%d",i);
    
}
#pragma 区域请求网络数据
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
    
}

#pragma mark 资讯列表接口
-(void)makeZixunData{
    [self.view makeToastActivity];
    NSString * ShouY = [NSString stringWithFormat:FindZXURL];
    NSString *urlStringUTF8 = [ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStringUTF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.view hideToastActivity];
        
        NSLog(@"资讯列表返回数据%@",responseObject);
        NSMutableArray *array=[responseObject objectForKey:@"news"];
        for (int i=0; i<array.count; i++) {
            NSMutableDictionary *dic=[array objectAtIndex:i];
            //题目
            NSString *name=[dic objectForKey:@"title"];
            //内参/展会/培训/活动心得类型
            NSString *type=[dic objectForKey:@"type"];
            NSString *type_name;
            if (type.intValue==0) {
                type_name=[NSString stringWithFormat:@"内参"];
                
            }
            if (type.intValue==1) {
                type_name=[NSString stringWithFormat:@"展会"];
                
            }
            if (type.intValue==2) {
                type_name=[NSString stringWithFormat:@"培训"];
                
            }
            if (type.intValue==3) {
                type_name=[NSString stringWithFormat:@"活动心得"];
                
            }
            //浏览数
            NSString *liuStr=[dic objectForKey:@"scan_num"];
            //图片
            NSString *img=[dic objectForKey:@"image"];
            NSMutableString *url=[NSMutableString stringWithFormat:DYListUrl,DYSTRRING, img];
            UIImage *imgs=[self getImageFromURL:url];
            
            //点击的行号
            NSString *idStr=[dic objectForKey:@"id"];

            
            ZXModel *model=[[ZXModel alloc]init];
            model.titleName=name;
            model.types=type_name;
            model.liulanshu=liuStr.intValue;
            model.img=imgs;
            model.idStr=idStr;
            
            [self.zxArray addObject:model];
            [self.fwlView.customTableView reloadData];
            
            
        }
        
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.zxArray.count;
}

#pragma mark  UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZXCELL"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ZXCell" owner:self options:nil]firstObject];
    }
    self.fwlView.customTableView.separatorColor=UITableViewCellSeparatorStyleNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    ZXModel *model=[self.zxArray objectAtIndex:indexPath.row];
    cell.titleName.text=[NSString stringWithFormat:@"[%@]%@",model.types,model.titleName];
    cell.liulanLbl.text=[NSString stringWithFormat:@"%d",model.liulanshu];
    cell.headImg.image=model.img;
    //两行显示，自动换行
    cell.titleName.lineBreakMode = NSLineBreakByCharWrapping;
    cell.titleName.numberOfLines = 2;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXMoreViewController *vc=[[ZXMoreViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark 点击事件
//点击同城
-(void)tongchengDone:(id)sender{
    
    WanShangViewController *tvc =[[WanShangViewController alloc]init];
    tvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tvc animated:YES];

}
//点击财富榜
-(void)caifuDone:(id)sender{
    
    MyLoneViewController *hvc =[[MyLoneViewController alloc]init];
    hvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hvc animated:YES];
    
    
}
-(void)setBtnTag{
    self.fwBtn.tag=1;
    self.dyBtn.tag=2;
    self.spBtn.tag=3;
    [self.fwBtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.dyBtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.spBtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];

}
//点击服务，代言人圈，视频
-(void)selected:(id)sender{
    UIButton *btn=sender;
    if (btn.tag==1) {
        [self.tempView1.view removeFromSuperview];
        [self.tempView2 removeFromSuperview];
        [self.view addSubview:self.fwlView];
        self.fwlView.frame=CGRectMake(0,40.5, ConentViewWidth, ConentViewHeight-64-40);
    }
    if (btn.tag==2) {
        [self.fwlView removeFromSuperview];
        [self.tempView2 removeFromSuperview];
        [self.view addSubview:self.tempView1.view];
    
    }
    if (btn.tag==3) {
        [self.fwlView removeFromSuperview];
        [self.tempView1.view removeFromSuperview];
        [self.view addSubview:self.tempView2];
    }

}

//发布广告需求
-(void)guanggaoxuqiuDone:(id)sender{
    GGaoViewController *vc=[[GGaoViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//发布资讯
-(void)zxDone:(id)sender{
    ZXViewController *VC=[[ZXViewController alloc]init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}
//点击区域
-(void)LeftAction{
    CitychooSSViewController * cvc =[[CitychooSSViewController alloc]init];
    cvc.hidesBottomBarWhenPushed= YES;
    iscomefromcity = YES;
    [self.navigationController pushViewController:cvc animated:YES];
    
}

#pragma mark 懒加载
-(sqqViewController *)tempView1{
    if (_tempView1==nil) {
        _tempView1 =[[sqqViewController alloc]init];
        _tempView1.view.frame=CGRectMake(0,40.5, ConentViewWidth, ConentViewHeight-40);

    }
    return _tempView1;
}
-(UIView *)tempView2{
    if (_tempView2==nil) {
        _tempView2=[[UIView alloc]initWithFrame:CGRectMake(0, 40.5, ConentViewWidth, ConentViewHeight-40)];
        _tempView2.backgroundColor=[UIColor greenColor];
    }
    return _tempView2;
}

-(FWLView *)fwlView{
    if (_fwlView==nil) {
        _fwlView=[FWLView creatFWView];
        //发布广告需求
        [_fwlView.fbgaoBtn addTarget:self action:@selector(guanggaoxuqiuDone:) forControlEvents:UIControlEventTouchUpInside];
        //发布资讯
        [_fwlView.fbzxBtn addTarget:self action:@selector(zxDone:) forControlEvents:UIControlEventTouchUpInside];
        //同城
        [_fwlView.tongcheng_btn addTarget:self action:@selector(tongchengDone:) forControlEvents:UIControlEventTouchUpInside];
        //财富榜
        [_fwlView.caifu_btn addTarget:self action:@selector(caifuDone:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _fwlView;
}
-(NSMutableArray *)zxArray{
    if (_zxArray==nil) {
        _zxArray=[NSMutableArray array];
        
    }
    return _zxArray;

}

@end
