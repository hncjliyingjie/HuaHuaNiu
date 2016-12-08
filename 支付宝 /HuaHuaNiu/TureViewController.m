 //
//  TureViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-30.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "TureViewController.h"
#import "MianFeiTableViewCell.h"
#import "HoMFJLViewController.h"
#import "MFXQViewController.h"
#import "LogViewController.h"
#import "Toast+UIView.h"
#import "MJRefresh.h"
#import "TrueModel.h"
@interface TureViewController ()
@property (nonatomic,strong)TrueModel * model;

@end

@implementation TureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    self.view.backgroundColor =BackColor;
    self.navigationItem.title=@"真的免费";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]}];
    
    [self makeTureData];
   
    
    
    
    //返回按钮
    UIImage *lbbImage = [UIImage imageNamed:@"back_new"];
    lbbImage = [lbbImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * lbbItem = [[UIBarButtonItem alloc] initWithImage:lbbImage style:UIBarButtonItemStylePlain target:self action:@selector(BackAction)];
    self.navigationItem.leftBarButtonItem = lbbItem;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;

}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
    [_timer invalidate];
}

-(void)makeTureData{
    [self.view makeToastActivity];
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    DingWeistr =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"ZUOBIAO"]];
    NSString *ShouY = [NSString stringWithFormat:TureStr,page,DingWeistr,[userdefault objectForKey:@"Useid"]];
    //(@"%@",ShouY);
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[RequestManger share]requestDataByGetWithPath:ShouY complete:^(NSDictionary *data) {
        [self.view hideToastActivity];
        [_tv footerEndRefreshing];
        [_tv headerEndRefreshing];
        if ([data objectForKey:@"error"]) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            self.model =[TrueModel makeModelWithDict:data];
            

            if (page ==1) {
                dataArr =[[NSMutableArray alloc]initWithArray:self.model.goodsArr];
                [self makeUI];
                [self makeTopView];
            }
            else{
                [dataArr addObjectsFromArray:self.model.goodsArr];
                [_tv reloadData];
            }
            if(dataArr.count == 0){
                UILabel * tisishsl =[[UILabel alloc]initWithFrame:CGRectMake(30, ConentViewHeight/2 - 100 , ConentViewWidth - 60  , 30)];
                tisishsl.textAlignment = NSTextAlignmentCenter;
                tisishsl.text =@"暂无数据";
                tisishsl.font =[UIFont systemFontOfSize:13];
                [self.view addSubview:tisishsl];
                tisishsl.tag =100;
            }
            else{
                UILabel * tisi =(UILabel *)[self.view  viewWithTag:100];
                tisi.hidden = YES;
            }
//            [self maketimerForJs];
        }
    }];
}

-(void)makeTopView{
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 60)];
    
//    [self.view addSubview:topView];
   UILabel * CityLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 230, 30)];
    CityLabel.font =[UIFont systemFontOfSize:14];
    
    NSUserDefaults *UserDetault =[NSUserDefaults standardUserDefaults];
   // [UserDetault setObject:result.address forKey:@"WeiZhi"];
    NSString * AddStr;
    if ([UserDetault objectForKey:@"WeiZhi"]) {
        AddStr =[UserDetault objectForKey:@"WeiZhi"];
    }else{
        AddStr =@"暂未获取到相关位置信息";
    }
    
    UILabel * ChangeLabel =[[UILabel alloc]initWithFrame:CGRectMake(260, 0, 60, 30)];
    ChangeLabel.font =[UIFont systemFontOfSize:14];
    ChangeLabel.text =@"更换>";
    ChangeLabel.textColor=[UIColor redColor];
   // [topView addSubview:ChangeLabel];
    UITapGestureRecognizer *TapAc =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapChan)];
    UIView *timeView =[[UIView alloc]initWithFrame:CGRectMake(0, 30, ConentViewWidth, 30)];
    for (int i  = 0 ; i<2; i++) {
        UILabel *la =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth - 120 + 55*i, 3, 50, 24)];
        if (i== 0) {
           la.text =FirstTime;
        }
        else if (i==1){
            la.text =secondTIme;

        }
      
        la.textAlignment = NSTextAlignmentCenter;
        la.font =[UIFont systemFontOfSize:15];
        la.textColor =[UIColor whiteColor];
        la.backgroundColor =[UIColor colorWithRed:246/255.0 green:125/255.0 blue:137/255.0 alpha:1];
        la.layer.masksToBounds = YES;
        la.layer.cornerRadius = 3;
        [timeView addSubview:la];
    }
    
    [timeView addSubview:TimerLabel];
    timeView.backgroundColor =[UIColor whiteColor];
//  [topView addSubview:timeView ];
    [topView addGestureRecognizer:TapAc];
    

  
}
#pragma 抢购时间设置


// 定时器
-(void)makeTInwer{
    _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerActiom) userInfo:nil repeats:YES];

    [_timer fire];
}
-(void)TimerActiom{
    daojimiaoshu --;
    shi =daojimiaoshu/3600+1;
    fen =(daojimiaoshu%3600)/60;
    miao =(daojimiaoshu%3600)%60;
  //  //(@"shi = %d  fen= %d  miao= %d",shi,fen,miao);
    NSString * str =[NSString stringWithFormat:@"剩余时间   %.2d:%.2d:%.2d",shi,fen,miao];
    TimerLabel.text =str;
    if([str isEqualToString:@"00:00:00"]){
    
    TimerLabel.text=@"抢购已结束";
        [_timer invalidate];
    }
}
-(void)viewDidDisappear:(BOOL)animated{

//    [_timer invalidate];

}
-(void)TapChan{
    //(  @"更换城市");


}
-(void)HeaderAc{
    page =1;
    [self makeTureData];
}
-(void)FooterAc{
    [self makeTureData];
    page ++;
}
-(void)makeUI{
    IOS_Frame
    _tv  =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight - 53)];
    _tv.delegate =self;
    _tv.dataSource =self;
    [_tv addHeaderWithTarget:self action:@selector(HeaderAc)];
    [_tv addFooterWithTarget:self action:@selector(FooterAc)];
    if (dataArr.count < 5) {
//        _tv.frame=CGRectMake(0, 30, ConentViewWidth, 103*dataArr.count);
        _tv.scrollEnabled = NO;
        _tv.separatorStyle  =UITableViewCellSeparatorStyleNone;
    }
    
    [self.view addSubview:_tv];
    
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =CGRectMake(0, 0, 15, 15);
   // [rightBtn setBackgroundColor:[UIColor whiteColor]];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"app_qianggoujilu_free"] forState:UIControlStateNormal ];
    [rightBtn addTarget:self action:@selector(RighrAct) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *RightItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem =RightItem;
    
    
    
    
}
-(void)RighrAct{

    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }
    else{
    HoMFJLViewController * Hvc =[[HoMFJLViewController alloc]init];
    [self.navigationController pushViewController:Hvc  animated: YES];
    }
  //  //(@"进入抢购结果");
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  dataArr.count;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MianFeiTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"MianFeiTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    TrueModel  * tureModel =dataArr[indexPath.row];
    [cell makeCellWithModel:tureModel];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSInteger denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        [self.navigationController pushViewController:logview animated:YES];
    }else{
        TrueModel * tureModel =dataArr[indexPath.row];
        NSString * SrId =tureModel.goods_id;
        
        MFXQViewController *mvc =[[MFXQViewController alloc]initWithStr:SrId andqiang:YES];
        mvc.gf_id =tureModel.gf_id;
        [self.navigationController pushViewController:mvc animated:YES];
    }
}
-(void)EnterAction{
    //    [LabelView removeFromSuperview];
    //    [tishiBakViw removeFromSuperview];
    //    //(@"yincang");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
