//
//  ComeHomeViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ComeHomeViewController.h"
#import "DJTableViewCell.h"
#import "AgencyUIView.h"
#import "ProductDetailViewController.h"
#import "StoreDetailsViewController.h"
#import "DaiLIShangMapViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Toast+UIView.h"
#import "WanShangModel.h"
@interface ComeHomeViewController ()

@end

@implementation ComeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    StoreDic =[[NSDictionary alloc]init];
    ProductDic =[[NSMutableArray alloc]init];
    ScrolldataArr =[[NSMutableArray alloc]init];
    [self makeItem];
    self.view.backgroundColor =BackColor;
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:264/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    
    [self makeData];
    
    [self AboutCity];
    // Do any additional setup after loading the view.
}

-(void)makeData{
    [self.view makeToastActivity];
    
    
        NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    
        DingWeistr =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"ZUOBIAO"]];
    
        NSString *ShouY = [NSString stringWithFormat:DAOJIAStr,DingWeistr];
    
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //(@"%@",ShouY);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
   
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {


        NSString * result =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
//        if ([result isEqualToString:@"1"]) {
        StoreDic =[responseObject objectForKey:@"store"];
        ScrolldataArr =[[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"advflash"]];
        for (NSDictionary  * dict in [responseObject objectForKey:@"goods"]) {
            if ([dict objectForKey:@"goods_id"]) {
                [ProductDic addObject:dict];
            };
        }

        
        [self.view hideToastActivity];
        [self makeUI];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];

}
-(void)makeItem{
     self.navigationItem.title=@"到家";
    [self.navigationController.navigationBar setTitleTextAttributes:
 @{NSFontAttributeName:[UIFont systemFontOfSize:17],
    
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton * RightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    RightBtn.frame =CGRectMake(0, 0, 20,20);
    [RightBtn addTarget:self action:@selector(RightBtnActions:)forControlEvents:UIControlEventTouchUpInside];
    [RightBtn setImage:[UIImage imageNamed:@"app_top_ditu"] forState:UIControlStateNormal];
    UIBarButtonItem *ringht =[[UIBarButtonItem alloc]initWithCustomView:RightBtn];
           self.navigationItem.rightBarButtonItem = ringht;




}
-(void)RightBtnActions:(UIButton *)Btn{
    //(@"%@",StoreDic);
    WanShangModel * model =[WanShangModel makeMainModelWithDict:StoreDic];
    NSMutableArray *Arr=[[NSMutableArray alloc]initWithObjects:model, nil];
        // ditu
    if (Arr.count == 0) {
        UIAlertView * alll =[[UIAlertView alloc]initWithTitle:@"提示·" message:@"暂无数据无法获取位置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alll show];
 
    }
    else{
         DaiLIShangMapViewController *Dvc =[[DaiLIShangMapViewController alloc]initWithArr:Arr];
        Dvc.hidesBottomBarWhenPushed = YES;
        Dvc.navigationController.hidesBottomBarWhenPushed= YES;
        [self.navigationController pushViewController:Dvc  animated:YES];

    }

    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{


}
-(void)AboutCity{
    
    UIImageView *leftIma =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    leftIma.image =[UIImage imageNamed:@"代言城-32px"];
  
    UIBarButtonItem *imaItem =[[UIBarButtonItem alloc]initWithCustomView:leftIma];
       self.navigationItem.leftBarButtonItem =imaItem;

}
-(void)TapActio{
    NSString * str =[NSString stringWithFormat:@"%@",[StoreDic objectForKey:@"store_id"]];
    StoreDetailsViewController *Svc =[[StoreDetailsViewController alloc]initWithStr:str];
    Svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: Svc animated:YES];
}
-(void)makeUI{
    IOS_Frame
    headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 235)];
    ScrollVi =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 100)];
        for (int i = 0 ; i< ScrolldataArr.count; i++) {
      
        UIImageView  * imall =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth * i, 0, ConentViewWidth, 100)];
        [imall sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[ScrolldataArr[i] objectForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];
        
        
        [ScrollVi addSubview:imall];
    }
    
    [headerView addSubview:ScrollVi];
    
    
    // 定时器
    MTimer =[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(TimerAction) userInfo:nil repeats:YES];
    // 数据下载完成在开启定时器 或者此时
    [MTimer setFireDate:[NSDate distantPast]];
 //定位我的位置
   ADdressLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 100, ConentViewWidth, 30)];
    ADdressLabel.font =[UIFont systemFontOfSize:15];
    
    NSUserDefaults *UserDetault =[NSUserDefaults standardUserDefaults];
    
  //  //(@"%@",[UserDetault objectForKey:@"WeiZhi"]);

   ADdressLabel.text=[NSString stringWithFormat:@"当前位置:%@",[UserDetault objectForKey:@"WeiZhi"]];
    [headerView addSubview:ADdressLabel];
    
    _tv  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth,ConentViewHeight -49) style:UITableViewStylePlain];
    _tv.delegate =self;
    _tv.dataSource =self;
    _tv.tableHeaderView = headerView;
    _tv.showsVerticalScrollIndicator = NO;
   // _tv.scrollEnabled=  NO;
    
    CGFloat  tabhigje =ConentViewHeight - 49 - 235;
     int numberforCell =tabhigje/70 ;
    if (ProductDic.count>numberforCell) {
         _tv.frame =CGRectMake(0, 0, ConentViewWidth, ConentViewHeight -49);
        }
        else{
        _tv.frame =CGRectMake(0, 0, ConentViewWidth,235+ProductDic.count*70);
        
        }
    AGView =[[[NSBundle mainBundle]loadNibNamed:@"AgencyUIView" owner:self options:nil]lastObject];
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapActio)];
    [AGView addGestureRecognizer:Tap];
    [AGView  makeDataWithDic:StoreDic];
    AGView.frame=CGRectMake(0, 130, ConentViewWidth, 100);
    if([StoreDic objectForKey:@"store_name"]){
        AGView.hidden =NO;
    }else{
        AGView.hidden =YES;
    }
    if (AGView.hidden ==YES) {
        headerView.frame =CGRectMake(0, 0, ConentViewWidth, 135);
    }
    [headerView addSubview:AGView];
    
    [self.view addSubview:_tv];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [MTimer setFireDate:[NSDate distantPast]];
}
-(void)viewWillDisappear:(BOOL)animated{
   
    [MTimer setFireDate:[NSDate distantFuture]];
}


-(void)TimerAction{
    
    if (j == ScrolldataArr.count) {
        j =0;
    }
    ScrollVi.contentOffset = CGPointMake(ConentViewWidth * j, 0);
   
    j++;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * GoodID =[NSString stringWithFormat:@"%@",[ProductDic[indexPath.row] objectForKey:@"goods_id"]];
    
    ProductDetailViewController *pvc =[[ProductDetailViewController alloc]initWithStr:GoodID];
    pvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pvc animated:YES];

}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  ProductDic.count;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"DJTableViewCell" owner:self options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
  [cell DJcellMakeWithDic:ProductDic[indexPath.row]];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
